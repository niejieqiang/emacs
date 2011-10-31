;;; perl-pod-preview.el --- preview perl pod documentation

;; Copyright 2007, 2008, 2009, 2010 Kevin Ryde
;;
;; Author: Kevin Ryde <user42@zip.com.au>
;; Version: 12
;; Keywords: docs
;; URL: http://user42.tuxfamily.org/perl-pod-preview/index.html
;; EmacsWiki: PerlPodPreview
;;
;; perl-pod-preview.el is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; perl-pod-preview.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
;; Public License for more details.
;;
;; You can get a copy of the GNU General Public License online at
;; <http://www.gnu.org/licenses/>.


;;; Commentary:

;; M-x perl-pod-preview displays a preview of Perl POD format documentation
;; using "pod2man" and "man".  It can show pod inlined in perl code or in a
;; separate pod file.
;;
;; The best feature is that when re-previewing the same file or buffer the
;; existing position in the preview is preserved, so if you change the
;; source a little you should be still quite close to the right place in the
;; preview to see how the change has come out.
;;
;; cperl-mode.el has M-x cperl-pod-to-manpage which does a similar thing,
;; but it goes from the disk copy of a buffer, so it can't work out of
;; tar-mode members etc, and it generates a new buffer every time.
;;
;; Running man for the formatting is pretty unsophisticated, but it's a
;; fairly deliberate choice because pod2man+man is probably how most people
;; will look at your docs, so seeing what it gives is a good thing.  The
;; `perl-pod-preview' docstring has some further notes.

;;; Install:

;; Put perl-pod-preview.el in one of your `load-path' directories, and in
;; your .emacs add
;;
;;     (autoload 'perl-pod-preview "perl-pod-preview" nil t)
;;
;; This makes M-x perl-pod-preview available, or you might like to bind it
;; to a key, for example f8 in cperl-mode,
;;
;;     (add-hook 'cperl-mode-hook
;;               (lambda ()
;;                 (define-key cperl-mode-map [f8] 'perl-pod-preview)))

;;; History:

;; Version 1 - the first version
;; Version 2 - copy default-directory from the source buffer
;; Version 3 - put perl 5.10 "POD ERRORS" section in the errors buffer
;; Version 4 - next-error in any buffer, eg. a tar file
;;           - make nroff errors a little clearer
;; Version 5 - fix for repeating a preview which has errors
;; Version 6 - save intermediate roff to show man errors
;; Version 7 - xemacs doesn't have no-record on switch-to-buffer-other-window
;; Version 8 - cope with non-existent `default-directory'
;; Version 9 - delete errors window when no errors
;; Version 10 - oops, `delete-windows-on' needs arg until emacs23
;; Version 11 - undo defadvice on unload-feature
;; Version 12 - express dependency on 'advice

;;; Code:

(require 'man)

;; for `ad-find-advice' macro when running uncompiled
;; (don't unload 'advice before our -unload-function)
(require 'advice)

;; xemacs incompatibilities
(defalias 'perl-pod-preview-make-temp-file
  (if (eval-when-compile (fboundp 'make-temp-file))
      'make-temp-file   ;; emacs
    ;; xemacs21
    (autoload 'mm-make-temp-file "mm-util") ;; from gnus
    'mm-make-temp-file))


(defconst perl-pod-preview-buffer "*perl-pod-preview*"
  "The name of the buffer for `perl-pod-preview' output.")

(defconst perl-pod-preview-error-buffer "*perl-pod-preview-errors*"
  "The name of the buffer for `perl-pod-preview' error messages.")

(defconst perl-pod-preview-roff-buffer " *perl-pod-preview-roff*"
  "The name of the buffer for `perl-pod-preview' intermediate nroff.
This is normally only of interest if there's errors from
\"man\".")

(defvar perl-pod-preview-origin nil
  "The name of the input buffer being displayed in `perl-pod-preview-buffer'.")


(defmacro perl-pod-preview--with-saved-display-position (&rest body)
  "Save `window-start' and point positions as line/column.
The use of line/column means BODY can erase and rewrite the
buffer contents."

  `(let ((point-column (current-column))
         (point-line   (count-lines (point-min) (line-beginning-position)))
         (window-line  (count-lines (point-min) (window-start))))
     ,@body

     (goto-char (point-min)) (forward-line window-line)
     ;; Don't let window-start be the very end of the buffer, since that
     ;; would leave it completely blank.
     (if (= (point) (point-max))
         (forward-line -1))
     (set-window-start (selected-window) (point))
     (goto-char (point-min)) (forward-line point-line)
     (move-to-column point-column)))

(defmacro perl-pod-preview--with-errorfile (&rest body)
  "Create an `errorfile' for use by the BODY forms.
An `unwind-protect' ensures the file is removed no matter what
BODY does."
  `(let ((errorfile (perl-pod-preview-make-temp-file "perl-pod-preview-")))
     (unwind-protect
         (progn ,@body)
       (delete-file errorfile))))

(defun perl-pod-preview--switch-buffer-other-norecord (buffer)
  "`switch-to-buffer-other-window' with no-record when available.
Emacs has a no-record arg, XEmacs doesn't."
  (condition-case nil
      ;; emacs
      (switch-to-buffer-other-window (current-buffer) t) ;; no-record
    (error
     ;; xemacs
     (switch-to-buffer-other-window (current-buffer)))))


;;;###autoload
(defun perl-pod-preview ()
  "Preview Perl POD documentation in the current buffer.
The buffer can be perl code with embedded pod, or an actual .pod
file.  Either way it's put through the \"pod2man\" command then
\"man\" and `Man-mode' for display.

Errors from pod2man are shown in a `compilation-mode' buffer and
the usual `next-error' (\\[next-error]) can step through offending parts
of the source.

Errors from man are shown too, as \"<pod2man output>\", and
`next-error' goes to a temporary buffer with the pod2man
intermediate output.  The most common error is a word, URL, etc
too long to wrap and the temp buffer lets you what it is.

If you re-run `perl-pod-preview' from the source buffer the
position in the preview buffer is preserved.  So if you switch
back to the source, make a small change, and re-preview, then you
should still be close to the old position to see how it looks.

The source buffer is not saved or anything for the preview and in
fact it doesn't even have to be visiting a file.  In particular
this means you can see formatted POD out of a `tar-mode' member
or similar.

------
Non-ASCII handling isn't great, mainly because pod2man is
conservative about what it spits out.  It'd be possible to use
another formatter, but pod2man is how people will see your docs,
so checking what comes out of it is no bad thing.  For reference
the non-ascii situation is roughly as follows,

* In perl 5.8 and earlier, pod2man didn't accept \"=encoding\" so
  you're probably limited to ascii input there, although latin-1
  generally made it through both pod2man and groff unmolested.

* In perl 5.10, pod2man recognises \"=encoding\" but only turns a
  few latin-1 accented characters into roff forms, with
  everything else just \"X\" characters.  Also alas as of groff
  1.18 the inking used by pod2man for accented forms doesn't come
  out properly on a tty, you end up with unaccented ascii.

------
See also `cperl-pod-to-manpage'.

The perl-pod-preview home page is
URL `http://user42.tuxfamily.org/perl-pod-preview/index.html'"

  (interactive)

  ;; Zap existing `perl-pod-preview-error-buffer'.
  ;; Turn off any compilation-mode there so that mode won't attempt to parse
  ;; the contents (until later when they've been variously munged).
  (with-current-buffer (get-buffer-create perl-pod-preview-error-buffer)
    (fundamental-mode)
    (setq buffer-read-only nil)
    (erase-buffer))

  (let ((origin-buffer (current-buffer)))
    (switch-to-buffer perl-pod-preview-buffer)
    (setq buffer-read-only nil)

    ;; If previewing a different buffer then erase here so as not to
    ;; restore point+window position into a completely different document.
    (if (not (equal perl-pod-preview-origin (buffer-name origin-buffer)))
        (erase-buffer))
    (setq perl-pod-preview-origin (buffer-name origin-buffer))

    ;; default-directory set from origin-buffer, so find-file or whatever
    ;; offers the same default as there.  This is inherited on initial
    ;; creation of the preview buffer, but must be set explicitly when
    ;; previewing a different buffer.
    (setq default-directory (with-current-buffer origin-buffer
                              default-directory)))

  (perl-pod-preview--with-errorfile
   (perl-pod-preview--with-saved-display-position
    (erase-buffer)

    ;; Coding for the input to pod2man is just the origin buffer
    ;; buffer-file-coding-system, since that's the bytes it would get from
    ;; the file.
    ;;
    ;; Coding for the output from pod2man is not quite clear.  The bytes
    ;; ought to be something "man" understands, which probably ought to
    ;; mean ascii-only (anything extra as troff directives).  Groff
    ;; (version 1.18) is usually happy with latin-1 input, and the
    ;; "man-db" man (version 2.5 at least) will actually try to guess the
    ;; input charset and convert to latin-1 (or something) for nroff/groff
    ;; as part of its preprocessing pipeline.
    ;;
    ;; In perl 5.8 pod2man didn't pay attention to non-ascii at all, it
    ;; just seemed to pass bytes through (and in particular gave an error
    ;; for a pod "=encoding" directive).  So it's anyone's guess what
    ;; encoding you'd be supposed to read from there.  Go latin-1 on the
    ;; slightly rash assumption that its most likely, and is what we feed
    ;; to "man -Tlatin1", and even if it's not true the bytes will get
    ;; through a latin-1 decode/encode to reach man unchanged.
    ;;
    ;; In perl 5.10 pod2man maybe probably kinda hopefully puts out
    ;; ascii-only, having converted other input chars into roff sequences
    ;; or expressions (and falling back on "X" for unknown chars).  So
    ;; nothing special should be needed on the read coding for that.
    ;;
    (if (get-buffer perl-pod-preview-roff-buffer)
        (kill-buffer perl-pod-preview-roff-buffer)) ;; erase
    (with-current-buffer perl-pod-preview-origin
      (let ((coding-system-for-write buffer-file-coding-system)
            (coding-system-for-read  'iso-8859-1)
            (default-directory       "/")
            (process-connection-type nil)) ;; pipe
        (apply 'call-process-region
               (point-min) (point-max) "pod2man"
               nil ;; keep input
               (list perl-pod-preview-roff-buffer  ;; output
                     errorfile)
               nil ;; don't redisplay

               ;; -name arg resembling what pod2man would make if run on the
               ;; actual filename instead of stdin; this ends up in the
               ;; output header/footer
               (and buffer-file-name
                    (list "-name" (upcase
                                   (file-name-nondirectory
                                    (file-name-sans-extension
                                     buffer-file-name))))))))

    ;; Perl 5.8 pod2man prints errors to stderr, and turn "<standard
    ;; input>" filename into "<perl-pod-preview>" ready for the
    ;; `compilation-find-file' defadvice below.
    (with-current-buffer perl-pod-preview-error-buffer
      (insert-file-contents errorfile)
      (goto-char (point-min))
      (while (search-forward "<standard input>" nil t)
        (replace-match "<perl-pod-preview>" t t)))

    ;; Running man with "-Tlatin1" makes it print overstrikes and
    ;; underscores for bold and italics, which `Man-fontify-manpage' below
    ;; crunches into fontification.
    ;;
    ;; "-Tutf8" output would also be possible, but for now its only effect
    ;; is to make unicode hyphens and other stuff that doesn't display on
    ;; a latin1 tty.  In the future if pod2man put extended characters
    ;; through in way groff understood then probably would want -Tutf8 so
    ;; as to see those.
    ;;
    ;; For man-db (version 2.5 at least) a side-effect of either of those
    ;; -T options is to lose input charset guessing (its "manconv"
    ;; program).  This is why "pod2man my-utf8.pod | man -l -" gives
    ;; sensibly formatted output (though with "?" marks for undisplayable
    ;; chars) whereas with -T here it's garbage and errors on such a
    ;; ".pod".
    ;;
    (with-current-buffer perl-pod-preview-roff-buffer
      (let ((coding-system-for-write 'iso-8859-1)
            (coding-system-for-read  'iso-8859-1)
            (default-directory       "/")
            (process-connection-type nil)) ;; pipe
        (call-process-region (point-min) (point-max) "man"
                             nil ;; keep input
                             (list perl-pod-preview-buffer errorfile)
                             nil ;; don't redisplay
                             "-Tlatin1" "-l" "-")))

    ;; "man" normal output, in particular crunch the backspace
    ;; overstriking before looking for "POD ERRORS" section
    (if (eval-when-compile (fboundp 'Man-mode))
        ;; emacs21 and emacs22
        (progn
          (Man-fontify-manpage)
          (Man-mode))
      ;; xemacs21
      (Manual-nuke-nroff-bs)
      (Manual-mode))

    ;; Perl 5.10 pod2man prints errors in a "POD ERRORS" section of
    ;; the normal output.
    (let ((errstr (perl-pod-preview-extract-pod-errors
                   "<perl-pod-preview>")))
      (if errstr
          (with-current-buffer perl-pod-preview-error-buffer
            (goto-char (point-max))
            (insert errstr))))

    ;; "man" errors, with "<standard input>" becoming "<pod2man output>"
    ;; ready for the `compilation-find-file' defadvice below
    (with-current-buffer perl-pod-preview-error-buffer
      (goto-char (point-max))
      (save-excursion
        (insert-file-contents errorfile))
      (while (search-forward "<standard input>" nil t)
        (replace-match "<pod2man output>" t t)))

    ;; show errors in a window, but only if there are any
    (save-selected-window
      (with-current-buffer perl-pod-preview-error-buffer
        (if (= (point-min) (point-max))
            (progn
              ;; No errors, kill buffer and window.  Killing the window
              ;; prevents something unrelated showing in a small window
              ;; which can be annoying for buffer cycling etc.
              (delete-windows-on (current-buffer))
              (kill-buffer nil))

          ;; emacs21 ignores the first two lines of a compilation-mode
          ;; buffer, so add in dummies
          (goto-char (point-min))
          (insert "perl-pod-preview pod2man\n\n")

          ;; switch to display, and if it it's newly displayed then shrink
          ;; to what's needed if there's only a couple of lines of errors
          (let ((existing-window (get-buffer-window (current-buffer))))
            (perl-pod-preview--switch-buffer-other-norecord (current-buffer))
            (if (not existing-window)
                (shrink-window-if-larger-than-buffer
                 (get-buffer-window (current-buffer)))))
          (compilation-mode)))))))

(defun perl-pod-preview-extract-pod-errors (filename)
  "Return a string of errors from a POD ERRORS in the current buffer.
If there's no POD ERRORS section then return nil.

Perl 5.10 pod2man (or rather Pod::Simple) emits a \"POD ERRORS\"
section for problems it finds in the input.  That section is
extracted here and each \"Around line N\" gets a GNU style
\"filename:linenum:colnum:\" inserted for the benefit of the
standard `compilation-mode' matching.  The FILENAME arg is used
for the originating file to show."

  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search nil))
      (when (search-forward "POD ERRORS\n" nil t)
        (let ((beg (match-beginning 0)))
          ;; POD ERRORS extends to next heading, which is an unindented
          ;; line, ie. beginning with a non-space, or possibly to the end of
          ;; the buffer
          (re-search-forward "^[^ \t\r\n]" nil t)
          (let ((str (buffer-substring beg (or (match-beginning 0)
                                               (point-max)))))
            (with-temp-buffer
              (insert str)

              ;; lose trailing multiple newlines
              (goto-char (point-min))
              (if (re-search-forward "\n+\\'")
                  (replace-match "\n" t t))

              ;; mung "Around line" to something the standard
              ;; compilation-mode regexps can match
              (goto-char (point-min))
              (while (re-search-forward "^[ \t]+Around line \\([0-9]+\\):"
                                        nil t)
                (save-excursion
                  (goto-char (match-beginning 0))
                  ;; xemacs21 needs the column number, emacs21 and up is ok
                  ;; without it
                  (insert filename ":" (match-string 1) ":0:\n")))

              (buffer-substring-no-properties (point-min) (point-max)))))))))
      
(defadvice compilation-find-file (around perl-pod-preview activate)
  "Use `perl-pod-preview-origin' for pod2man errors."
  (cond ((equal filename "<perl-pod-preview>")
         (setq ad-return-value perl-pod-preview-origin))
        ((equal filename "<pod2man output>")
         (setq ad-return-value perl-pod-preview-roff-buffer))
        (t
         ad-do-it)))

(defun perl-pod-preview-unload-function ()
  (when (ad-find-advice 'compilation-find-file 'around 'perl-pod-preview)
    (ad-remove-advice   'compilation-find-file 'around 'perl-pod-preview)
    (ad-activate        'compilation-find-file))
  nil) ;; and do normal unload-feature actions too

(provide 'perl-pod-preview)

;;; perl-pod-preview.el ends here

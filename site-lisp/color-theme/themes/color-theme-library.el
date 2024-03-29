 (eval-when-compile
  (require 'color-theme))

(defun color-theme-wombat ()
  "wombat,modify by niejieqiang"
  (interactive)
  (color-theme-install
   '(color-theme-wombat
     ((background-color . "#121212")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "#6d8824")
      (foreground-color . "#9090a0"))
     (default ((t (:background "#121212" :foreground "#9090a0"))))
     (border-glyph ((t (nil))))
     (buffers-tab ((t (:background "#121212" :foreground "#9090a0"))))
     (font-lock-builtin-face ((t (:background "#121212" :foreground "#308040"))))
     (font-lock-comment-face ((t (:foreground "#5080a0"))))
     (font-lock-constant-face ((t (:foreground "#a16261"))))
     (font-lock-doc-string-face ((t (:italic t :foreground "#5080a0"))))
     (font-lock-function-name-face ((t (:foreground "#308040"))))
     (font-lock-variable-name-face ((t (:foreground "#308040"))))
     (font-lock-keyword-face ((t (:foreground "#a4a338"))))
     (font-lock-preprocessor-face ((t (:foreground "#a54140"))))
     (font-lock-reference-face ((t (:foreground "#5080a0"))))
     (font-lock-apply-highlight ((t (:background "#6d8824" :foreground "white"))))

     
     (font-lock-regexp-grouping-construct ((t (:background "#121212" :foreground "#003030"))))
     (font-lock-regexp-grouping-backslash ((t (:background "#121212" :foreground "#003030"))))
     (font-lock-add-keywords ((t (:foreground "#a4a338"))))
     (font-lock-compile-keyword ((t (:foreground "#a4a338"))))
     (font-lock-eval-keywords ((t (:foreground "#a4a338"))))
     (font-lock-choose-keywords ((t (:foreground "#a4a338"))))

     (font-lock-mode-internal ((t (:foreground "#5080a0"))))
     (font-lock-string-face ((t (:foreground "#a16261"))))
     (font-lock-type-face ((t (:foreground "#a4a338"))))

     (font-lock-warning-face ((t (:bold t :foreground "#b03030"))))
     
     (region ((t (:background "#6d8824" :foreground "white"))))
     (mode-line ((t (:background "#313131" :foreground "#9090a0"))))
     (minibuffer-prompt ((t (:foreground "#a4a338"))))
     (minibuffer-completion-contents ((t (:foreground "#308040"))))
     (highline-face ((t (:foreground "white":background "#6d8824"))))
     (italic ((t (nil))))
     (left-margin ((t (nil))))
     (show-paren-match ((t (:background "#b3b3df" :foreground "#9090a0" :bold t))))
     (toolbar ((t (nil))))
     (org-todo ((t (:foreground "#a4a338" :bold t))))
     (org-hide ((t (:foreground "#0b0b0b"))))
     (cperl-nonoverridable-face ((t (:foreground "#a4a338"))))
     (cperl-hash-face((t (:foreground "#308040"))))
     (cperl-highlight-charclass ((t (:foreground "#308040"))))
     (cperl-forward-group-in-re ((t (:foreground "#003030" :background "#121212"))))
     (cperl-backward-to-start-of-continued-exp ((t (:background "#121212" :foreground "#003030"))))
     (cperl-highlight-variables-indiscriminately ((t (:background "#121212" :foreground "#308040"))))
     (cperl-array-face ((t (:foreground "#308040"))))
     (cperl-val ((t (:foreground "#308040"))))
     (cperl-beautify-regexp-piece ((t (:background "#121212" :foreground "#003030"))))
     (cperl-forward-group-in-re ((t (:background "#121212" :foreground "#003030"))))
     (cperl-backward-to-start-of-continued-exp ((t (:background "#121212" :foreground "#003030"))))
     (cperl-comment-region ((t (:foreground "#5080a0"))))
     
     (cperl-backward-to-noncomment ((t (:background "#121212" :foreground "#9090a0"))))

     (ffap ((t (:background "#121212" :foreground "#308040"))))
     (highlight ((((class color) (min-colors 88) (background dark)) (:background "#6d8824" :foreground "white"))))

     
     (anything-visible-mark ((t (:background "#308040" :foreground "white"))))
     (anything-visible-mark-face ((t (:background "#308040" :foreground "white"))))
     (anything-isearch-match-face ((t (:background "#6d8824" :foreground "white"))))
     (anything-isearch-match ((t (:background "#6d8824" :foreground "white"))))
     (anything-header-face ((t (:background "#308040" :foreground "white"))))

     (isearch-search ((t (:background "#b03030" :foreground "white"))))
     (isearch-fail ((t (:background "#b03030" :foreground "white"))))
     (isearch-forward ((t (:background "#6d8824" :foreground "white"))))
     (isearch-backward ((t (:background "#6d8824" :foreground "white"))))
     (isearch-face ((t (:background "#6d8824" :foreground "white"))))
     (isearch ((((class color) (min-colors 88) (background dark)) (:background "#6d8824" :foreground "white"))))
     (lazy-highlight ((((class color) (min-colors 88) (background dark)) (:background "#222222" :foreground "#9090a0"))))
     
     (comint-highlight-prompt ((t (:foreground "#BFAC35"))))
     (custom-comment-face ((t (:background "#6d8824" :foreground "white"))))

     (yas/field-highlight-face ((t (:background "#6d8824" :foreground "white"))))
     (ac-yasnippet-selection-face ((t (:background "steelblue" :foreground "white"))))
     
     (diredp-flag-mark ((t (:foreground "#308040"))))
    (dired-symlink-face ((t (:foreground "#003030"))))
    (diredp-other-priv ((t (:foreground "#9090a0"))))
     (dired-mark-face ((t (:background "#6d8824" :foreground "white"))))
     (diredp-dir-priv ((t (:foreground "#a4a338"))))
     (diredp-display-msg ((t (:foreground "#a4a338"))))
     (diredp-exec-priv ((t (:foreground "#4F4F3B3B2121"))))
     (diredp-flag-mark-line ((t (:background "#6d8824" :foreground "white"))))
     (diredp-number ((t (:foreground "#308040"))))
     (diredp-file-name ((t (:foreground "#5080a0"))))
     (diredp-file-suffix ((t (:foreground "#5080a0"))))
     (diredp-date-time ((t (:foreground "#9090a0"))))
)))

(add-to-list 'color-themes '(color-theme-wombat "color-theme-wombat"))
(provide 'color-theme-wombat)






(require 'saveplace) ;;save last position of cursor
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/.emacs-places")

(require 'recentf)
(setq tramp-default-method "ftp")

(add-to-list 'load-path (expand-file-name "~/emacs/site-lisp/recentf/"))
(require 'recentf-ext)

(load "recentf-buffer")
;;(global-set-key [\C-t] 'recentf-open-files-in-simply-buffer)


(iswitchb-mode 1)  ;; using iswitchb
(defcustom my-open-recent-file-history-sources '(file-name-history)
  "*Determines which history source `my-open-recent-file' uses.
Normal file name history uses the file name history saved by
`find-file', saved in the variable `file-name-history', Recentf
history uses `recentf-list' from recentf.el (enable recentf-mode
to use this) and Session uses `session-file-alist' from
session.el (external package)."
  :type '(set (const :tag "Normal file name history" file-name-history)
              (const :tag "Recentf history" recentf-list)
              (const :tag "Session" session))
  :group 'files)

(defun my-open-recent-file (fname)
  "Using iswitchb, interactively open recently opened file.
Configure `my-open-recent-file-history-sources' to control from
where to get the file name history."
  (interactive (list (flet ((iswitchb-make-buflist
                             (default)
                             (setq iswitchb-buflist 
                                   (my-open-recent-file-list))))
                       (iswitchb-read-buffer "Open file: "))))
  (find-file fname))

(defun my-open-recent-file-list ()
  (let (result)
    (dolist (x my-open-recent-file-history-sources result)
      (setq result (append result (symbol-value x))))
    (remove-duplicates result :test 'equal)))

;; I don't use `frame-configuration-to-register'
(global-set-key (kbd "C-x r f") 'my-open-recent-file)


(defun iswitchb-local-keys ();;use narrow keys to navigate buffers
      (mapc (lambda (K) 
	      (let* ((key (car K)) (fun (cdr K)))
    	        (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	    '(("<right>" . iswitchb-next-match)
	      ("<left>"  . iswitchb-prev-match)
	      ("<up>"    . ignore             )
	      ("<down>"  . ignore             ))))

    (add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)
(add-to-list 'load-path "~/emacs/site-lisp/wcy-desktop/")

(autoload 'session-initialize "session"
  "Initialize package session and read previous session file.
Setup hooks and load `session-save-file', see `session-initialize'.  At
best, this function is called at the end of the Emacs startup, i.e., add
this function to `after-init-hook'." t)

(add-hook 'after-init-hook 'session-initialize)

(defun session-settings ()
  "Settings for `session'."
  (setq session-initialize '(session menus)))

(eval-after-load "session"
  `(session-settings))

;;--------------------------------------------
;; 　　　　 ╭══╮ 
;; 　　　 ╭╯ΘΘ║ 
;; 　　　 ╰⊙═⊙╯。oо○  
;;--------------------------------------------


(require 'wcy-desktop)

(wcy-desktop-init)
(add-hook 'emacs-startup-hook
          (lambda ()
            (ignore-errors
              (wcy-desktop-open-last-opened-files))))


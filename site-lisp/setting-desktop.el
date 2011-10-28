
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name ".emacs-desktop")

  (require 'desktop)
  (desktop-save-mode 1)
  (defun my-desktop-save ()
    (interactive)
    ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    (if (eq (desktop-owner) (emacs-pid))
        (desktop-save desktop-dirname)))
  (add-hook 'auto-save-hook 'my-desktop-save)

(desktop-save-mode 1)

;; (require 'desktop-recover)
;; (prefer-coding-system 'utf-8)
;; (desktop-recover-interactive)
;; ;; (desktop-recover-define-global-key-bindings "\C-c%")


;; (require 'session)

;; (add-hook 'after-init-hook 'session-initialize)
;; (load "desktop")
;; (desktop-load-default)
;; (desktop-read);; must exec M-x desktop-save cmd if you were new to run
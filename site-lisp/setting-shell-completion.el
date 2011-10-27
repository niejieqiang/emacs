(add-to-list 'load-path "~/emacs/site-lisp/shell-completion")
(require 'shell-completion)

(add-hook 'shell-mode-hook 'wcy-shell-mode-hook-func);;quite shell mode after enter exit cmd
(defun wcy-shell-mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                            #'wcy-shell-mode-kill-buffer-on-exit)
      )
(defun wcy-shell-mode-kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))
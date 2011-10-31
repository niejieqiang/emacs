(eval-after-load "shell"
  '(progn
     (ansi-color-for-comint-mode-on)))

(require 'shell-completion)

;;                            _(\_/) 
;;                          ,((((^`\
;;                         ((((  (6 \ 
;;                       ,((((( ,    \
;;   ,,,_              ,(((((  /"._  ,`,
;;  ((((\\ ,...       ,((((   /    `-.-'
;;  )))  ;'    `"'"'""((((   (      
;; (((  /            (((      \
;;  )) |                      |
;; ((  |        .       '     |
;; ))  \     _ '      `t   ,.')
;; (   |   y;- -,-""'"-.\   \/  
;; )   / ./  ) /         `\  \
;;    |./   ( (           / /'
;;    ||     \\          //'|
;;    ||      \\       _//'||
;;    ||       ))     |_/  ||
;;    \_\     |_/          ||
;;    `'"                  \_\
;;                         `'"       `"".


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


 (add-to-list 'process-coding-system-alist ;;remove ^M char
              '("bash" . (undecided-dos . undecided-unix)))
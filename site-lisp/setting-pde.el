(add-to-list 'load-path "~/emacs/site-lisp/pde/lisp")
(load "pde-load")

(global-set-key (kbd "C-c s") 'compile-dwim-compile)
(global-set-key (kbd "C-c r") 'compile-dwim-run)
(setq compilation-buffer-name-function 'pde-compilation-buffer-name)
(autoload 'compile-dwim-run "compile-dwim" "Build and run" t)
(autoload 'compile-dwim-compile "compile-dwim" "Compile or check syntax" t)
(autoload 'executable-chmod "executable"
          "Make sure the file is executable.")

(defun pde-perl-mode-hook ()
   ;; chmod when saving
  (when (and buffer-file-name
        (not (string-match "\\.\\(pm\\|pod\\)$" (buffer-file-name))))
      (add-hook 'after-save-hook 'executable-chmod nil t))
  (set (make-local-variable 'compile-dwim-check-tools) nil))

;;┃     __%%%(\        `%%%%%   .%%%%%         ┃ 
;;┃   /a  ^  '%        %%%% %: ,%  %%"`        ┃
;;┃  '__..  ,'%     .-%:     %-'    %          ┃
;;┃   ~""%:. `     % '          .   `.         ┃ 
;;┃       %% % `   %%           .%:  . \.      ┃ 
;;┃        %%:. `-'   `        .%% . %: :\     ┃ 
;;┃        %(%,%..."   `%,     %%'   %% ) )    ┃ 
;;┃         %)%%)%%'   )%%%.....- '   "/ (     ┃ 
;;┃         %a:f%%\ % / \`%  "%%% `   / \))    ┃
;;┃          %(%'  % /-. \      '  \ |-. '.    ┃
;;┃          `'    |%   `()         \|  `()    ┃
;;┃                ||    /          ()   /     ┃
;;┃                ()   0            |  o      ┃ 
;;┃                 \  /\ AF         o /       ┃
;;┃                 o  `            /-|        ┃
;;┃              ,-/ `           ,-/           ┃
;;┗━━━━━━━━━━━━━━━━━━━━━━┛ 

(provide 'setting-pde)
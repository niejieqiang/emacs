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


(load "pde-load")

(setq cperl-highlight-variables-indiscriminately t)

;; ----------------------------------------------

;;  ______________________________________
;; /                                      \
;; |        Perl Completion               |
;; \                                      /
;;  --------------------------------------
;;   \
;;    \
;;        ___  
;;      {~._.~}
;;       ( Y )
;;      ()~*~()   
;;      (_)-(_)   
;;
;; -----------------------------------------------

(add-hook  'cperl-mode-hook
           (lambda ()
             (when (require 'auto-complete nil t ) ; no error whatever auto-complete.el is not installed.
	       	   (require 'perl-completion nil t)
               (auto-complete-mode )
	       (perl-completion-mode )
	       (hs-minor-mode )
	    
               (make-variable-buffer-local 'ac-sources)
               (setq ac-sources
                     '(ac-source-perl-completion
		       ac-source-yasnippet
		       ac-source-abbrev
		       ac-source-words-in-buffer
		       ac-source-files-in-current-dir
		       ac-source-filename
		       )))))

;;////////////////////////////////////////////////////
;;
;;( Fold key definition )
;;  ----------------------------------------
;;   o
;;    o   \_\_    _/_/
;;     o      \__/
;;            (oo)\_______
;;            (__)\       )\/\
;;                ||----w |
;;                ||     ||
;;
;; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

(define-key global-map "\M-'" 'hs-show-all) ;;M-' to show all fold
(define-key global-map "\M-[" 'hs-hide-block) ;;hide sub
(define-key global-map "\M-]" 'hs-show-block) ;;show sub

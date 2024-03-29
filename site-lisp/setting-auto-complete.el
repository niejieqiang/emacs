(add-to-list 'load-path "~/emacs/site-lisp/yasnippet-0.6.1c/")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs/site-lisp/yasnippet-0.6.1c/snippets/")

(add-to-list 'load-path "~/emacs/site-lisp/auto-complete/")
(require 'auto-complete)
(require 'auto-complete-extension)

(add-to-list 'ac-dictionary-directories "~/emacs/site-lisp/auto-complete/ac-dict/")
(require 'auto-complete-config)
(ac-config-default)

;;C-n and C-p to select goodies
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;;---------------------------------------
;;       ,-.,-.  
;;      (  (  (        
;;       \  )  ) _..-.._   
;;      __)/ ,','       `.
;;    ,"     `.     ,--.  `.     
;;  ,"   @        .'    `   \
;; (Y            (           ;''.
;;  `--.____,     \          ,  ; 
;;  ((_ ,----' ,---'      _,'_,'    
;;      (((_,- (((______,-'
;;---------------------------------------

(setq-default ac-sources '(
			   ac-source-words-in-buffer
			   ac-source-words-in-same-mode-buffers
                           ac-source-abbrev
                           ac-source-files-in-current-dir
                           ac-source-filename))
;;(setq ac-modes ac+-modes)

(global-auto-complete-mode t)           ;;enable global-mode



(server-start) ;;start server

(add-to-list 'load-path "~/emacs/.emacs.d/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs/.emacs.d/auto-complete//ac-dict")
(ac-config-default)
(require 'auto-complete-extension)
(require 'auto-complete+)
(setq ac-trigger-key "RET")
(setq ac-auto-start t)
;;(setq ac-trigger-key "TAB")
;;C-n and C-p to select goodies
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq-default ac-sources '(ac-source-words-in-all-buffer
                           ac-source-abbrev
                           ac-source-words-in-buffer
                           ac-source-words-in-all-buffer
                           ac-source-files-in-current-dir
                           ac-source-filename))

(add-to-list 'load-path
                  "~/emacs/.emacs.d/yasnippet")
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "~/emacs/.emacs.d/yasnippet/snippets")

(add-to-list 'load-path "~/emacs/.emacs.d/pde/lisp")
(load "pde-load")
(ido-mode 1)
(setq ido-enable-tramp-completion t);;ido setting tramp to find file

;;(setq ido-save-directory-list-file nil);;
(require 'template-simple)

;; pde code style
;; pde code style
;; pde code style
(global-set-key (kbd "M-;") 'comment-or-uncomment-region)
(setq-default indent-tabs-mode nil)

(defalias 'perl-mode 'cperl-mode)
(defun pde-perl-mode-hook ()
  (abbrev-mode t)
  (add-to-list 'cperl-style-alist
               '("PDE"
                 (cperl-auto-newline                         . t)
                 (cperl-brace-offset                         . 0)
                 (cperl-close-paren-offset                   . -4)
                 (cperl-continued-brace-offset               . 0)
                 (cperl-continued-statement-offset           . 4)
                 (cperl-extra-newline-before-brace           . nil)
                 (cperl-extra-newline-before-brace-multiline . nil)
                 (cperl-indent-level                         . 4)
                 (cperl-indent-parens-as-block               . t)
                 (cperl-label-offset                         . -4)
                 (cperl-merge-trailing-else                  . t)
                 (cperl-tab-always-indent                    . t)))
  (cperl-set-style "PDE"))

;;pde compile and run perl file
;;pde compile and run perl file
;;pde compile and run perl file
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

;;pde code browser
;;pde code browser
;;pde code browser
;;(require 'ffap)
(global-set-key (kbd "C-c i") 'imenu)
(global-set-key (kbd "C-c v") 'imenu-tree)
(setq tags-table-list '("./TAGS" "../TAGS" "../../TAGS"))
(autoload 'imenu-tree "imenu-tree" "Show imenu tree" t)
(setq imenu-tree-auto-update t)
(eval-after-load "imenu"
 '(defalias 'imenu--completion-buffer 'pde-ido-imenu-completion))
(autoload 'tags-tree "tags-tree" "Show TAGS tree" t)


(add-to-list 'load-path "~/emacs/.emacs.d/perl-complete/")
(add-hook 'cperl-mode-hook ;;perl-complete
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)))
(add-hook 'cperl-mode-hook
           (lambda ()
             (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
               (auto-complete-mode t)
               (make-variable-buffer-local 'ac-sources)
               (setq ac-sources
                     '(ac-source-perl-completion
                       ac-source-yasnippet
                       ac-source-words-in-all-buffer
                       ac-source-files-in-current-dir
                       ac-source-filename) ))))
(add-hook 'cperl-mode-hook 'outline-minor-mode)
(define-key global-map "\M-'" 'show-all) ;;M-' to show all fold
(define-key global-map "\M-[" 'hide-subtree) ;;hide sub
(define-key global-map "\M-]" 'show-subtree) ;;show sub

(setq cperl-highlight-variables-indiscriminately t)

;; (setq tab-width 4) ; or any other  preferred value
;; (defvaralias 'c-basic-offset 'tab-width)
;; (defvaralias 'cperl-indent-level 'tab-width)

(add-to-list 'load-path "~/emacs/.emacs.d");;display colors
(add-hook 'css-mode-hook 'css-color-mode)
(autoload 'css-mode "css-mode" "" t)
(autoload 'css-color-mode "mon-css-color" "" t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))

(global-set-key [f12] (quote shell));;press f12 enter to shell mode
(define-key global-map "\C-h" 'backward-delete-char) ;;C-h to delete a char as backspace
(defalias 'eb 'eval-buffer)
(defalias 'cr 'comment-region)
(defalias 'ucr 'uncomment-region)
(defalias 'pb 'perltidy-buffer)

(autoload 'pod-mode "pod-mode" "Mode for editing POD files" t)
(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))
(add-hook 'pod-mode-hook 'font-lock-mode)

(setq kept-old-versions 2);; version-control 
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/emacs/.emacs.d/backup")));;set backup dirs
(setq backup-by-copying t)
(setq make-backup-files nil);;不产生备份文件


(setq default-directory "~/emacs/")

(set-frame-font "Consolas-12");;
(set-fontset-font "fontset-default" 'han '("Microsoft Yahei" . "unicode-bmp"))

(icomplete-mode 99);; 

(setq user-full-name "niejieqiang");;personal info
(setq user-mail-address "niejieqiang@qq.com")

(setq-default kill-whole-line 1);;C-k delete whole line when at the head
(global-linum-mode 1);;use line number
(auto-image-file-mode 1);view image by emacs

(auto-compression-mode 1);;compress/uncompress files

(tool-bar-mode 0);;disable toolbar

(show-paren-mode 1);;show paren for braces

(setq kill-ring-max 200);; make kill-ring bigger¡

(require 'recentf);;get recent file-list;
(recentf-mode 1)

(setq x-select-enable-clipboard 1);;emacs paste to other external apps
(mouse-avoidance-mode 'animate);;
(setq mouse-yank-at-point t);;use mouse yank

(setq inhibit-startup-message 1);;disable messages when startup emacs
(fset 'yes-or-no-p 'y-or-n-p) ;;use y replace yes ,so did no.
(setq frame-title-format "editing­---%b");;modify title 

(display-time-mode 1);;display time
(setq display-time-24hr-format 1);;use 24 hour format
(setq display-time-day-and-date t);;display date
(setq display-time-use-mail-icon t);;
(setq display-time-interval 10);;
(setq display-time-format "公元%Y年%m月%d日,%A,%H:%M");;

(setq visible-bell t);;disable warning 

(setq default-major-mode 'text-mode);;text mode default 
(setq resize-mini-windows nil);;Mini buffer won't resize automaticly

(require 'dired+) ;;dired settings
(require 'dired-isearch)
(setq dired-recursive-copies 'always);;delete dir always recursive
(setq dired-recursive-deletes 'always)
(setq confirm-nonexistent-file-or-buffer nil);;don't confirm when creat new file or buffer
(setq confirm-kill-buffer nil)

(require 'ibus);; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)

(require 'shell-completion);;autocomplete in shell mode

(add-to-list 'load-path "~/emacs/.emacs.d/color-theme")
(require 'color-theme);;use my favourite theme
(color-theme-initialize)
(color-theme-wombat)



;; (add-to-list 'load-path "~/Downloads/Mew/")
;; (autoload 'mew "mew" nil t) ;;send mail by mew
;; (autoload 'mew-send "mew" nil t)
;; ;; Optional setup (Read Mail menu):
;; (setq read-mail-command 'mew)
;; ;; Optional setup (e.g. C-xm for sending a message):
;; (autoload 'mew-user-agent-compose "mew" nil t)
;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'mew-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'mew-user-agent
;;       'mew-user-agent-compose
;;       'mew-draft-send-message
;;       'mew-draft-kill
;;       'mew-send-hook))
;; (setq mew-name "niejieqiang") ;; (user-full-name)
;; (setq mew-user "niejieqiang") ;; (user-login-name)
;; (setq mew-mail-domain "qq.com")
;; (setq mew-smtp-server "smtp.qq.com")  ;; if not localhost
;; (setq mew-smtp-port "465")
;; (setq mew-proto "%")
;; (setq mew-imap-user "niejieqiang@qq.com")  ;; (user-login-name)
;; (setq mew-imap-port "993")
;; (setq mew-imap-server "imap.qq.com")    ;; if not localhost
;; (setq mew-use-smtp-auth nil)
;; (setq mew-use-cached-passwd t)


(defun my-maximized-horz ();;maximized when emacs startup
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(defun my-maximized-vert ()
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
(defun my-maximized ()
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
(my-maximized)

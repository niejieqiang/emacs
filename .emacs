(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
    (add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
    (add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
    (add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(add-to-list 'load-path "~/emacs/.emacs.d/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs/.emacs.d/auto-complete//ac-dict")
(ac-config-default)
(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq-default ac-sources '(ac-source-words-in-all-buffer)) ;;set ac-source default

(add-to-list 'load-path
                  "~/emacs/.emacs.d/yasnippet")
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "~/emacs/.emacs.d/yasnippet/snippets")
;(require 'auto-complete-yasnippet)


(add-to-list 'load-path "~/emacs/.emacs.d/pde/lisp")
(load "pde-load")
(ido-mode 1)
;;(setq ido-enable-tramp-completion t);;ido setting tramp to find file
;;(setq ido-save-directory-list-file nil);;
(require 'template-simple)
;; ;; M-SPC not available, window manager take it away
(global-set-key (kbd "M-'") 'just-one-space)
(global-set-key (kbd "C-M-=") 'pde-indent-dwim)
;; nearest key to dabbrev-expand
(global-set-key (kbd "M-;") 'hippie-expand)
(global-set-key (kbd "C-;") 'comment-dwim)
(global-set-key (kbd "C-c f") 'comint-dynamic-complete)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq hippie-expand-try-functions-list
          '(try-expand-line
            try-expand-dabbrev
            try-expand-line-all-buffers
            try-expand-list
            try-expand-list-all-buffers
            try-expand-dabbrev-visible
            try-expand-dabbrev-all-buffers
            try-expand-dabbrev-from-kill
            try-complete-file-name
            try-complete-file-name-partially
            try-complete-lisp-symbol
            try-complete-lisp-symbol-partially
            try-expand-whole-kill))
(autoload 'comint-dynamic-complete "comint" "Complete for file name" t)
(setq comint-completion-addsuffix '("/" . ""))
(setq-default indent-tabs-mode nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defalias 'perl-mode 'cperl-mode)
(defun pde-perl-mode-hook ()
  (abbrev-mode t)
  (add-to-list 'cperl-style-alist
               '("PDE"
                 (cperl-auto-newline                         . t)
                 (cperl-brace-offset                         . 1)
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
;;compile and run perl file
(global-set-key (kbd "C-c s") 'compile-dwim-compile)
(global-set-key (kbd "C-c r") 'compile-dwim-run)
(setq compilation-buffer-name-function 'pde-compilation-buffer-name)
(autoload 'compile-dwim-run "compile-dwim" "Build and run" t)
(autoload 'compile-dwim-compile "compile-dwim" "Compile or check syntax" t)
(autoload 'executable-chmod "executable"
          "Make sure the file is executable.")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun pde-perl-mode-hook ()
   ;; chmod when saving
  (when (and buffer-file-name
        (not (string-match "\\.\\(pm\\|pod\\)$" (buffer-file-name))))
      (add-hook 'after-save-hook 'executable-chmod nil t))
  (set (make-local-variable 'compile-dwim-check-tools) nil))
;;codebrowser
(require 'ffap) 
(global-set-key (kbd "C-c i") 'imenu)
(global-set-key (kbd "C-c v") 'imenu-tree)
(global-set-key (kbd "C-c j") 'ffap)
(setq tags-table-list '("./TAGS" "../TAGS" "../../TAGS"))
(autoload 'imenu-tree "imenu-tree" "Show imenu tree" t)
(setq imenu-tree-auto-update t)
(eval-after-load "imenu"
 '(defalias 'imenu--completion-buffer 'pde-ido-imenu-completion))
(autoload 'tags-tree "tags-tree" "Show TAGS tree" t)
;; A wonderful minibuffer completion mode
(partial-completion-mode 1)
(setq PC-include-file-path
      (delete-dups (append PC-include-file-path pde-perl-inc)))
(setq ffap-url-regexp
      (concat
       "\\`\\("
       "news\\(post\\)?:\\|mailto:\\|file:" ; no host ok
       "\\|"
       "\\(ftp\\|https?\\|telnet\\|gopher\\|www\\|wais\\)://" ; needs host
       "\\)[^:]" ; fix for perl module, require one more character that not ":"
       ))       
(add-to-list 'ffap-alist  '(cperl-mode . pde-ffap-locate))
;;Rebinding keys for hideshow
(require 'hideshow)
(define-key hs-minor-mode-map "\C-c\C-o"
  (let ((map (lookup-key hs-minor-mode-map "\C-c@")))
    ;; C-h is help to remind me key binding
    (define-key map "\C-h" 'describe-prefix-bindings)
    (define-key map "\C-q" 'hs-toggle-hiding)
    ;; compatible with outline
    (define-key map "\C-c" 'hs-hide-block)
    (define-key map "\C-e" 'hs-show-block)
    map))
;;
(global-set-key (kbd "C-c h") 'help-dwim)
(setq cperl-lazy-help-time 2)
(defun pde-perl-mode-hook ()
   (cperl-lazy-install))


(add-to-list 'load-path "~/emacs/.emacs.d/perl-complete/")
(add-hook 'cperl-mode-hook ;;perl-complete
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)))
(add-hook  'cperl-mode-hook
           (lambda ()
             (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
               (auto-complete-mode t)
               (make-variable-buffer-local 'ac-sources)
               (setq ac-sources
                     '(ac-source-perl-completion)))))

(setq cperl-highlight-variables-indiscriminately t)

(add-to-list 'load-path "~/emacs/.emacs.d");;display colors
(add-hook 'css-mode-hook 'css-color-mode)
(autoload 'css-mode "css-mode" "" t)
(autoload 'css-color-mode "mon-css-color" "" t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))

(global-set-key [f12] (quote shell));;press f12 enter to shell mode
(define-key global-map "\C-h" 'backward-delete-char) ;;C-h to delete a char as backspace

(setq kept-old-versions 2)
;;(setq version-control t);;
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/emacs/.emacs.d/backup")));;set backup dirs
(setq backup-by-copying t)
;;(setq dired-kept-versions 1)

(setq default-directory "~/emacs/")

(add-to-list 'load-path "~/emacs/.emacs.d/color-theme")
(require 'color-theme);;use my favourite theme
(color-theme-initialize)
(color-theme-wombat)

(set-frame-font "Consolas-12");;
(set-fontset-font "fontset-default" 'han '("Microsoft Yahei" . "unicode-bmp"))

;;(minibuffer-electric-default-mode 1);;minibuffer

(eval-after-load "dired-aux" ;;unzip 
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "7z")))

(icomplete-mode 99);; 

;;(blink-cursor-mode -1);;don't blink

(setq user-full-name "niejieqiang");;personal info
(setq user-mail-address "niejieqiang@qq.com")

(setq-default kill-whole-line 1);;C-k delete whole line when at the head
;;(setq auto-save-default nil);
(global-linum-mode 1);;use line number
(auto-image-file-mode 1);view image by emacs

(auto-compression-mode 1);;compress/uncompress files
;;(require 'chm-view);;

(tool-bar-mode 0);;disable toolbar

;;(partial-completion-mode 1);;

(setq browse-url-browser-function 'browse-url-generic ;;set conkeror as def browser of emacs
browse-url-generic-program "/usr/bin/conkeror")

(setq kill-ring-max 200);; make kill-ring bigger¡

(setq confirm-nonexistent-file-or-buffer nil);;don't confirm when creat new file or buffer
(setq confirm-kill-buffer nil)

(require 'recentf);;get recent file-list;
(recentf-mode 1)

(setq x-select-enable-clipboard 1);;emacs paste to other external apps
(setq inhibit-startup-message 1);;disable messages when startup emacs
(fset 'yes-or-no-p 'y-or-n-p) ;;use y replace yes ,so did no.
(setq frame-title-format "editing­---%b");;modify title 

(display-time-mode 1);;display time

(setq display-time-24hr-format 1);;use 24 hour format
(setq display-time-day-and-date t);;display date
;;(setq display-time-use-mail-icon t);;
(setq display-time-interval 10);;
(setq display-time-format "公元%Y年%m月%d日,%A,%H:%M");;

(mouse-avoidance-mode 'animate);;
(setq mouse-yank-at-point t);;use mouse yank

(setq visible-bell t);;disable warning 

(setq default-major-mode 'text-mode);;text mode default 
(setq resize-mini-windows nil);;Mini buffer won't resize automaticly

(setq dired-recursive-copies 'always);;delete dir always recursive
(setq dired-recursive-deletes 'always)
(add-to-list 'load-path "~/emacs/.emacs.d")
(require 'dired-view);;type the head of filename to index in dired;
(add-hook 'dired-mode-hook 'dired-view-minor-mode-on)

(show-paren-mode 1);;show paren for braces

(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)

(require 'shell-completion);;autocomplete in shell mode

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
(custom-set-variables
  ;; If there is more than one, they won't work right.
 )

(custom-set-faces
  ;; 
 '(comint-highlight-prompt ((((min-colors 88) (background dark)) (:foreground "#5080a0"))))
 '(cursor ((t (:background "#6d8824" :foreground "white"))))
 '(custom-visibility ((t (:background "#6d8824" :foreground "white" :height 0.8))))
 '(ido-subdir ((((min-colors 88) (class color)) (:foreground "#a54140"))))
 '(isearch ((((class color) (min-colors 88) (background dark)) (:background "#6d8824" :foreground "white"))))
 '(lazy-highlight ((((class color) (min-colors 88) (background dark)) (:background "#6d8824" :foreground "white"))))
 '(link ((((class color) (min-colors 88) (background dark)) (:foreground "#5090a0" :underline t))))
 '(secondary-selection ((((class color) (min-colors 88) (background dark)) (:background "SkyBlue4" :foreground "white")))))

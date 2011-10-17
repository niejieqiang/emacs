(load-file "~/emacs/.emacs.d/my-coding.el")

(global-set-key [f12] (quote shell));;press f12 enter to shell mode
(define-key global-map "\C-h" 'backward-delete-char) ;;C-h to delete a char as backspace
(defalias 'eb 'eval-buffer)
(defalias 'cr 'comment-region)
(defalias 'ucr 'uncomment-region)

(setq kept-old-versions 2);; version-control 
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/emacs/.emacs.d/backup")));;set backup dirs
(setq backup-by-copying t)

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
;;(setq display-time-use-mail-icon t);;
(setq display-time-interval 10);;
(setq display-time-format "公元%Y年%m月%d日,%A,%H:%M");;

(setq visible-bell t);;disable warning 

(setq default-major-mode 'text-mode);;text mode default 
(setq resize-mini-windows nil);;Mini buffer won't resize automaticly

(require 'dired+) ;;dired settings
(require 'dired-isearch)
(setq dired-recursive-copies 'always);;delete dir always recursive
(setq dired-recursive-deletes 'always)
(setq dired-dwim-target t)
(setq confirm-nonexistent-file-or-buffer nil);;don't confirm when creat new file or buffer
(setq confirm-kill-buffer nil)


(require 'ibus);; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)

(require 'shell-completion);;autocomplete in shell mode

(add-to-list 'load-path "~/emacs/.emacs.d/color-theme")
(require 'color-theme);;use my favourite theme
(color-theme-initialize)
(color-theme-wombat)
;;custom colors
(custom-set-variables
 )
(custom-set-faces
 '(comint-highlight-prompt ((((min-colors 88) (background dark)) (:foreground "#5080a0"))))
 '(cursor ((t (:background "black" :foreground "#909090"))))
 '(custom-visibility ((t (:background "#6d8824" :foreground "white" :height 0.8))))
 '(ido-subdir ((((min-colors 88) (class color)) (:foreground "#a54140"))))
 '(isearch ((((class color) (min-colors 88) (background dark)) (:background "#6d8824" :foreground "white"))))
 '(lazy-highlight ((((class color) (min-colors 88) (background dark)) (:background "#6d8824" :foreground "white"))))
 '(link ((((class color) (min-colors 88) (background dark)) (:foreground "#5090a0" :underline t))))
 '(secondary-selection ((((class color) (min-colors 88) (background dark)) (:background "SkyBlue4" :foreground "white")))))

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

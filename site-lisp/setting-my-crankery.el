(setq default-directory "~/emacs/")

(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;;设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插

(ido-mode nil)
;;(setq tramp-default-method "ftp") ;;disable tramp

(require 'saveplace) ;;save last position of cursor
(setq-default save-place t)

(setq user-full-name "niejieqiang");;personal info
(setq user-mail-address "niejieqiang@qq.com")

(setq-default kill-whole-line 1);;C-k delete whole line when at the head
(global-linum-mode 1);;use line number
(auto-image-file-mode 1);view image by emacs

(auto-compression-mode 1);;compress/uncompress files

(tool-bar-mode 0);;disable toolbar

(show-paren-mode 1);;show paren for braces

(setq kill-ring-max 200);; make kill-ring bigger¡

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

(global-set-key [f12] (quote shell));;press f12 enter to shell mode
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "\C-h") 'backward-delete-char) ;;C-h to delete a char as backspace
(global-set-key (kbd "M-;") 'comment-or-uncomment-region) ;;comment or uncomment
(defalias 'eb 'eval-buffer)
(defalias 'cr 'comment-region)
(defalias 'ucr 'uncomment-region)
(defalias 'pb 'perltidy-buffer)

;;(defun jbr-init ()
;;  "Called from term-setup-hook after the default
;;terminal setup is
;;done or directly from startup if term-setup-hook not
;;used.  The value
;;0xF030 is the command for maximizing a window."
;;  (interactive)
;;  (w32-send-sys-command #xf030)
;;  (ecb-redraw-layout)
;;  (calendar)
;;)
;;(setq term-setup-hook 'jbr-init)
;;(setq window-setup-hook 'jbr-init)


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



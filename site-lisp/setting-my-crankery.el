(setq default-directory "~/emacs/")

;; ╭┴┴—————┴┴╮
;; │　　　 　  　　│＼｜／
;; │　●　 　　●　│—☆—
;; │○　╰┬┬┬╯　○│／｜＼
;; │　　 ╰—╯　 ／
;; ╰—┬○————┬○╯

(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;;设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插

(blink-cursor-mode -1);;cursor dont blink
(transient-mark-mode 1)

(setq next-line-add-newlines nil);;dont add a new line when the cursor move to to the line


(setq scroll-step 1;;scroll slowly
scroll-margin 3
scroll-conservatively 10000)

(setq user-full-name "niejieqiang");;personal info
(setq user-mail-address "niejieqiang@qq.com")

(setq-default kill-whole-line 1);;C-k delete whole line when at the head
(global-linum-mode 1);;use line number
(auto-image-file-mode 1);view image by emacs

;; │＼＿＿╭╭╭╭╭＿＿／│
;; │　　　　　　　　　　　│　　　╭──────╮
;; │　　　　　　　　　　　│　　　│ 　哇來嚕 　│
;; │　＞　　　　　　　＜　│　╭╮│ 要LINUX唷!　│
;; │≡　　╰┬┬┬╯　　≡│Ｏ╰╯╰──────╯
;; │　　　　╰─╯　　　　│　
;; ╰──┬Ｏ───Ｏ┬──╯

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
(global-set-key (kbd "\C-h") 'backward-delete-char) ;;C-h to delete a char as backspace
(global-set-key (kbd "M-SPC") 'set-mark-command) ;;C-h to delete a char as backspace

(defalias 'eb 'eval-buffer)
(defalias 'cr 'comment-region)
(defalias 'ucr 'uncomment-region)
(defalias 'pb 'perltidy-buffer)

(defun maximize-frame ()
  "Maximizes the active frame in Windows"
  (interactive)
  ;; Send a `WM_SYSCOMMAND' message to the active frame with the
  ;; `SC_MAXIMIZE' parameter.
  (when (eq system-type 'windows-nt)
    (w32-send-sys-command 61488)))
(add-hook 'window-setup-hook 'maximize-frame t)


(when (equal system-type 'gnu/linux) ;;so did linux as above
    (progn
     (defun my-maximized-horz ()
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
    (my-maximized)))

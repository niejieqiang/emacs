(add-to-list 'load-path "~/emacs/site-lisp/color-theme/")
(require 'color-theme);;use my favourite theme
(color-theme-initialize)
(color-theme-wombat)

(set-frame-font "Consolas-12");;
(set-fontset-font "fontset-default" 'han '("Microsoft Yahei" . "unicode-bmp"))

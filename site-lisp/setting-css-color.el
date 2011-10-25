(add-hook 'css-mode-hook 'css-color-mode)
(autoload 'css-mode "css-mode" "" t)
(autoload 'css-color-mode "mon-css-color" "" t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))


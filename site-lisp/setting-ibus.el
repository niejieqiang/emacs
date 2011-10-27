(if (eq system-type 'gnu/linux)
    (progn
    (require 'ibus);; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)))


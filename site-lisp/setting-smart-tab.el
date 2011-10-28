(require 'smart-tabs-mode)

(add-hook 'cperl-mode-hook 'smart-tabs-mode-enable);; smart-tab hook in cperl mode
(smart-tabs-advice cperl-indent-line cperl-indent-level)

(global-set-key (kbd "TAB") 'smart-tab)
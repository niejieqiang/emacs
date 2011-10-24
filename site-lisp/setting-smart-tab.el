(add-to-list 'load-path "~/emacs/site-lisp/smart-tabs-mode/")
(require 'smart-tabs-mode)

(add-hook 'cperl-mode-hook 'smart-tabs-mode-enable)
(smart-tabs-advice cperl-indent-line cperl-indent-level);;enabe smart-tab in cperl mode

(provide 'setting-smart-tab)
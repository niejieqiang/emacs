(require 'recentf);;get recent file-list;
(recentf-mode 1)
(setq recentf-keep '(file-remote-p file-readable-p))
;;(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!


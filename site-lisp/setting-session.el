
(require 'session)

(add-hook 'after-init-hook 'session-initialize)
(load "desktop")
(desktop-load-default)
(desktop-read);; must exec M-x desktop-save cmd if you were new to run
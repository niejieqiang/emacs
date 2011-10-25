(add-to-list 'load-path "~/emacs/site-lisp/dired")
(require 'dired+) ;;dired settings
(require 'dired-isearch)
(setq dired-recursive-copies 'always);;delete dir always recursive
(setq dired-recursive-deletes 'always)
(setq confirm-nonexistent-file-or-buffer nil);;don't confirm when creat new file or buffer
(setq confirm-kill-buffer nil)













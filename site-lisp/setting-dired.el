(require 'dired+) ;;dired settings
(require 'dired-isearch)

(require 'dired-details) ;;dired details
(dired-details-install)

(require 'dired-details+)

(setq dired-recursive-deletes 'always)     ;dont remind me when delete 
(setq dired-recursive-copies 'always)       
(setq confirm-nonexistent-file-or-buffer nil);;don't confirm when creat new file or buffer
(setq confirm-kill-buffer nil)


 (defun dired-next-file-line ();;dont move not useful lines when in dired mode
   "Moves to the next dired line that have a file or directory name on
 it"
   (interactive)
   (call-interactively 'dired-next-line)
   (if (not (or (dired-move-to-filename) (eobp)))
       (dired-next-file-line)))
  (defun dired-previous-file-line ()
   "Moves to the previous dired line that have a file or directory name
 on it"
   (interactive)
   (call-interactively 'dired-previous-line)
   (if (not (or (dired-move-to-filename) (bobp)))
       (dired-previous-file-line)))


(defun mydired-sort ();;sort directory first
  "Sort dired listings with directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header 
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
    (set-buffer-modified-p nil)))
(defadvice dired-readin
  (after dired-after-updating-hook first () activate)
  "Sort dired listings with directories first before adding marks."
  (mydired-sort))












(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-co" 'org-jump-to-project-todo)

(eval-after-load 'org
  '(progn
     ;; Add all org files in the org directory to the agenda
     (mapcar
      (lambda (file)
          (add-to-list 'org-agenda-files file))
      (directory-files (expand-file-name "~/org/") t "\\.org"))))
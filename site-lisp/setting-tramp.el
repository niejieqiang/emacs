(eval-after-load "tramp"
  '(add-to-list 'tramp-default-method-alist
                '(".*\\.umich\\.edu\\'" "" "ssh")))

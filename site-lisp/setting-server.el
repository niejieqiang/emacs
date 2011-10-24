(require 'server)
(or (server-running-p) (server-start))

(provide 'setting-server)
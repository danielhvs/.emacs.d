;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

(setq url-proxy-services
   '(("http" . "http://127.0.0.1:3128")
     ("https" . "https://127.0.0.1:3128")
     ("socks" . "socks://127.0.0.1:3128")))

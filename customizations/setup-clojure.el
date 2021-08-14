;;;;
;; Clojure
;;;;

;; Enable paredit for Clojure
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))

;;;;
;; Cider
;;;;

;; provides minibuffer documentation for the code you're typing into the repl
(add-hook 'cider-mode-hook 'eldoc-mode)
(define-key clojure-mode-map (kbd "<f3>") 'cider-find-var)
(define-key clojure-mode-map (kbd "<f2>") 'cider-pop-back)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect nil)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; enable paredit in your REPL
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

;; key bindings
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

(add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
(add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)

;; daniel
(global-set-key (kbd "C-SPC") #'cider-doc)
(setq cider-prompt-for-symbol nil)

(setq cider-test-show-report-on-success t)

(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  ;; make evil-search-word look for symbol rather than word boundaries
  (setq-default evil-symbol-word-search t))

;; (defun identa-clj ()
;; "Identa clojure usando node"
;; (shell-command-to-string (format "/home/danielhabib/.nvm/versions/node/v15.9.0/bin/cljfmt --edn=/home/danielhabib/.config/cljfmt/options.edn %s" buffer-file-name)))

;; (defun save-and-indent ()
  ;; "indent while save buffer"
  ;; (interactive)
  ;; (save-excursion
    ;; (indent-region (point-min) (point-max))
    ;; nil)
  ;; (save-buffer))

(defun save-and-indent ()
  "indent while save buffer"
  (interactive)
  (save-buffer)
  (cider-format-buffer)
  (save-buffer))

(global-set-key (kbd "C-x C-s") 'save-and-indent) 

(cider-auto-test-mode 1)

(global-set-key (kbd "C-M-h") 'cider-xref-fn-refs) 


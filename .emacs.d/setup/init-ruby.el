(use-package ruby-mode
  :ensure t
  :mode (("\\.rake$" . ruby-mode)
         ("Rakefile$" . ruby-mode)
         ("\\.gemspec$" . ruby-mode)
         ("Gemfile$" . ruby-mode)
         ("Capfile$" . ruby-mode)
         ("Vagrantfile$" . ruby-mode))
  :config
  (progn
    (setq ruby-insert-encoding-magic-comment nil)
    (setq ruby-indent-level 2)
    (setq ruby-deep-indent-paren nil)))

;; ;; TODO: Find out how to include rails documentation
;; (use-package yari
;;   :ensure t
;;   :config
;;   (define-key 'help-command (kbd "R") 'yari))

;; (use-package flycheck
;;   :config
;;   (setq flycheck-ruby-executable "~/.rbenv/shims/ruby")
;;   (setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
;;   (setq flycheck-rubocop-lint-only t))

(use-package rspec-mode
  :ensure t
  :config
  (rspec-install-snippets))

;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;; Allow binstubs to be executed without writing bin/ prefix
(setenv "PATH" (concat "./bin:" (getenv "PATH")))
(setq exec-path (cons "./bin" exec-path))

(use-package yaml-mode
 :ensure t
 :mode (("\\.yml\\'" . yaml-mode)))

(use-package inf-ruby
  :ensure t)

(use-package robe
  :ensure t
  :config
  (progn
    (add-hook 'ruby-mode-hook 'robe-mode)
    ;; (eval-after-load 'company
    ;;   '(push 'company-robe company-backends))
    ))

(setq lsp-solargraph-use-bundler t)

(provide 'init-ruby)

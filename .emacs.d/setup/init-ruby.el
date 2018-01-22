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

;; TODO: Find out how to include rails documentation
(use-package yari
  :ensure t
  :config
  (define-key 'help-command (kbd "R") 'yari))

(use-package flycheck
  :config
  (setq flycheck-ruby-executable "~/.rbenv/shims/ruby")
  (setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
  (setq flycheck-rubocop-lint-only t))

(use-package rspec-mode
  :ensure t
  :config
  (rspec-install-snippets))

(provide 'init-ruby)

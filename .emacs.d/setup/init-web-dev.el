(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
         ("\\.html?\\'" . web-mode))
  :config
  (progn
    (add-hook 'web-mode-hook
              '(lambda ()
                 ;; Disable whitespace-mode.
                 ;; (whitespace-mode -1)
                 (setq web-mode-markup-indent-offset 2)
                 (setq web-mode-css-indent-offset 2)
                 (setq web-mode-code-indent-offset 4)
                 ;; (setq web-mode-disable-autocompletion t)
                 ;; (local-set-key (kbd "RET") 'newline-and-indent)
                 ))))

(use-package scss-mode
  :ensure t
  :config
  (setq css-indent-offset 2))

(provide 'init-web-dev)

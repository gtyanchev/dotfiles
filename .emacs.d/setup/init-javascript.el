(use-package js2-mode
  :ensure t
  :config
  (setq js2-basic-offset 2))

(use-package rjsx-mode
  :ensure t
  :mode (("\\.js\\'"    . rjsx-mode)
         ("\\.jsx\\'" . rjsx-mode)))

(provide 'init-javascript)

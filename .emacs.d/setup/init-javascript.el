(use-package js2-mode
  :ensure t)

(use-package rjsx-mode
  :ensure t
  :mode (("\\.js\\'"    . rjsx-mode)
         ("\\.jsx\\'" . rjsx-mode)))

(provide 'init-javascript)

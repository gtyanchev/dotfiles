;; (use-package js2-mode
;;   :ensure t
;;   :config
;;   (progn
;;     (setq js2-strict-missing-semi-warning nil)
;;     (setq js2-basic-offset 2)))

;; (use-package rjsx-mode
;;   :ensure t
;;   :mode (("\\.js\\'"    . rjsx-mode)
;;          ("\\.jsx\\'" . rjsx-mode))
;;   :config
;;   (progn
;;     (setq js2-strict-missing-semi-warning nil)))

(setq js-indent-level 2)

(use-package prettier-js
  :ensure t)

(use-package add-node-modules-path
  :ensure t
  :config
  (progn
    (add-hook 'js-mode-hook #'add-node-modules-path)))

(use-package js-mode
  :mode ((("\\.tsx\\'"    . js-mode))))

(provide 'init-javascript)

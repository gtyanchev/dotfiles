;; Setup version control packages
(use-package magit
  :ensure t
  :bind (("C-c s" . magit-status)))

;; (use-package git-gutter
;;   :ensure t
;;   :init (global-git-gutter-mode +1))

(provide 'init-version-control)

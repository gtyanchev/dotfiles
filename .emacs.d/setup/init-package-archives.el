;; Add MELPA archive
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(provide 'init-package-archives)

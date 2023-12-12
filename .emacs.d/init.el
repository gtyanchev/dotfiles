;; Initialize the packages to be able to configure them
(package-initialize)

;; Setup load path.
(add-to-list 'load-path (expand-file-name "setup" user-emacs-directory))

(require 'init-package-archives)
(require 'init-base)
(require 'init-version-control)
(require 'init-ruby)
(require 'init-javascript)
(require 'init-web-dev)
(require 'osx)

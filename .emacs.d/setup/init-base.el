;; Run a server on start
(server-start)

;; Keep emacs custom settings in custom file.
(setq custom-file (expand-file-name "setup/custom.el" user-emacs-directory))
(load custom-file)

;; Make init.el the initial buffer
(setq inhibit-startup-message t)
(find-file "~/.emacs.d/init.el")
(kill-buffer "*scratch*")

;; Configure emacs visual elements
;;;; Remove all distractions
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;;; Highlight current line
;; (when window-system (global-hl-line-mode))

;;;; Use one color theme for all the frames.
(setq color-theme-is-global t)

;;;; Always display file size, line and column numbers.
(size-indication-mode t)
(setq line-number-mode t)
(setq column-number-mode t)

;;;; Use one color theme for all the frames.
(setq color-theme-is-global t)

;;;; Disable bell sound, instead try to flash
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Disable blink cursor.
(blink-cursor-mode -1)

;; Always use UTF-8.
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Don't use tabs in indentation.
(setq-default indent-tabs-mode nil)

;; Set 4 spaces tab stops.
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112))

;; Delete selection when start writing.
(delete-selection-mode t)

;; Allow pasting selection outside of Emacs.
(setq select-enable-clipboard t)

;; Enable y or n answers.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Tweak GC threshold
(setq gc-cons-threshold 50000000)

;; Show faster incomplete commands while typing them.
(setq echo-keystrokes 0.1)

(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

;; White space mode settings.
(setq whitespace-style '(face trailing tabs))
;; (setq whitespace-line-column 80)
(global-whitespace-mode t)

(defun cleanup-buffer-safe ()
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace))

(add-hook 'before-save-hook 'cleanup-buffer-safe)

;; backup and autosave files go into the tmp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Show me empty lines after buffer end.
(set-default 'indicate-empty-lines t)

;; (use-package smex
;;   :ensure t)

(use-package counsel
  :ensure t
  :bind
  (("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line))
  :config
  (progn
    ;; Flip bindings for ivy-done and ivy-alt-done in counsel. This allows you to
    ;; hit RET to complete a directory instead of opening dired.
    (define-key counsel-find-file-map (kbd "C-j") 'ivy-done)
    (define-key counsel-find-file-map (kbd "RET") 'ivy-alt-done)))

(use-package swiper
  :diminish ivy-mode
  :ensure t
  :bind*
  (("C-s" . swiper)
   ("C-c C-r" . ivy-resume)
   ("C-x C-f" . counsel-find-file)
   ("C-c h f" . counsel-describe-function)
   ("C-c h v" . counsel-describe-variable)
   ("C-c i u" . counsel-unicode-char)
   ("C-c g" . counsel-git)
   ("C-c j" . ag-project))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (define-key read-expression-map (kbd "C-r") #'counsel-minibuffer-history)
    (ivy-set-actions
      'ivy-switch-buffer
      '(("k"
         (lambda (x)
           (kill-buffer x)
           (ivy--reset-state ivy-last))
         "kill")
        ))))

(use-package command-log-mode
  :ensure t)

;; Displays the key bindings following your
;; currently entered incomplete command (a prefix) in a popup
(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

;;; Expand the current selection
(use-package expand-region
  :ensure t
  :bind (("C-;" . er/expand-region)
         ("M-SPC" . er/expand-region)))

(use-package company
  :ensure t
  :bind (("M-/". company-complete))
  :config
  (progn
    ;; setup company mode for autocomplete
    (setq company-idle-delay 0.5)
    (setq company-tooltip-limit 10)
    (setq company-minimum-prefix-length 2)
    ;; invert the navigation direction if the the completion popup-isearch-match
    ;; is displayed on top (happens near the bottom of windows)
    (setq company-tooltip-flip-when-above t)
    (global-company-mode 1)
    (with-eval-after-load 'company
      (define-key company-active-map (kbd "M-n") nil)
      (define-key company-active-map (kbd "M-p") nil)
      (define-key company-active-map (kbd "C-n") #'company-select-next)
      (define-key company-active-map (kbd "C-p") #'company-select-previous))))

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode)
;;   :config
;;   (setq flycheck-indication-mode 'left-fringe))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :commands (mc/mark-all-like-this
             mc/mark-next-like-this
             mc/mark-previous-like-this)
  :bind (("M-n"   . mc/mark-next-like-this)
         ("M-p"   . mc/mark-previous-like-this))
  :config (add-to-list 'mc/unsupported-minor-modes 'flyspell-mode))

;; Autopair parentheses, quotes and even
;; language specific structures e.g def/end in ruby
(use-package smartparens
  :ensure t
  :config
  (progn
    (require 'smartparens-config)
    (add-hook 'prog-mode-hook 'smartparens-mode)
    (add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)))

;; Show matching parentheses
(show-paren-mode 1)

;; Colors the parentheses nesting around the cursor
(use-package highlight-parentheses
  :ensure t
  :diminish highlight-parentheses-mode
  :config
  (add-hook 'prog-mode-hook 'highlight-parentheses-mode))

;; Use different color for different levels of parentheses nesting
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Highlight the current word under the cursor
(use-package idle-highlight-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'idle-highlight-mode))

;; Moving by sentence doesn't make sense in code
(global-set-key (kbd "M-e") 'forward-paragraph)
(global-set-key (kbd "M-a") 'backward-paragraph)

;; Code snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

;; Allow operations on words to be applied on camelcase entries
(add-hook 'prog-mode-hook 'subword-mode)

;; Display number lines
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Make a bigger font-size.
(set-face-attribute 'default nil :height 140)

;; Dired human readable sizes
(setq dired-listing-switches "-alh")

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

(use-package ag
  :ensure t
  :config
  (setq ag-highlight-search t))

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g k" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (progn
            (setq dumb-jump-force-searcher 'ag)
            (setq dumb-jump-selector 'ivy)) ;; (setq dumb-jump-selector 'helm)
  :ensure)



(use-package yafolding
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'yafolding-mode))

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/bin" exec-path))

;; Disable #. backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
;; (setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
;;   backup-by-copying t    ; Don't delink hardlinks
;;   version-control t      ; Use version numbers on backups
;;   delete-old-versions t  ; Automatically delete excess backups
;;   kept-new-versions 20   ; how many of the newest versions to keep
;;   kept-old-versions 5    ; and how many of the old
;;   )

(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

;; LSP

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  ;; :hook (
  ;;        ;; (js-mode . lsp)
  ;;        ;; if you want which-key integration
  ;;        ;; (lsp-mode . lsp-enable-which-key-integration)
  ;;        )
  :commands lsp)

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)

(use-package restclient
  :ensure t)


(provide 'init-base)

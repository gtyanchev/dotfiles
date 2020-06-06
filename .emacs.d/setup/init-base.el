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

(use-package smex
  :ensure t)

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
   ("C-c j" . counsel-git-grep))
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

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-indication-mode 'left-fringe))

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

;; Make a bigger font-size.
(set-face-attribute 'default nil :height 140)

(provide 'init-base)

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode 1))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

(use-package ag
  :ensure t
  :config
  (setq ag-highlight-search t))

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/bin" exec-path))

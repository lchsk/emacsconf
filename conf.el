(require 'package)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold 800000)))

(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
        '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
        '("elpa" . "https://elpa.gnu.org/packages/"))

(unless package--initialized (package-initialize))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(setq-default cursor-type 'bar)
(blink-cursor-mode 0)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(setq-default frame-title-format '("%b"))
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(setq linum-format "%4d ")
(delete-selection-mode 1)
(global-auto-revert-mode t)
(use-package undo-tree
  :init (global-undo-tree-mode))
(add-hook 'before-save-hook
	  'delete-trailing-whitespace)
(add-hook 'prog-mode-hook
          (if (and (fboundp 'display-line-numbers-mode) (display-graphic-p))
              #'display-line-numbers-mode
            #'linum-mode))

; server
(require 'server)
(unless (server-running-p)
  (server-start))



(defun sanemacs/backward-kill-word ()
  (interactive "*")
  (push-mark)
  (backward-word)
  (delete-region (point) (mark)))

(global-set-key [mouse-3] 'mouse-popup-menubar-stuff)          ; Gives right-click a context menu
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop) ; Indent selection by one tab length
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)  ; De-indent selection by one tab length
(global-set-key (kbd "M-DEL") 'sanemacs/backward-kill-word)    ; Kill word without copying it to your clipboard
(global-set-key (kbd "C-DEL") 'sanemacs/backward-kill-word)    ; Kill word without copying it to your clipboard


(global-set-key (kbd "C-x w") 'whitespace-mode)
(global-set-key (kbd "C-x j") 'dired-jump)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq
   backup-by-copying t                                        ; Avoid symlinks
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t
   auto-save-list-file-prefix emacs-tmp-dir
   auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t))  ; Change autosave dir to tmp
   backup-directory-alist `((".*" . ,emacs-tmp-dir)))

(setq create-lockfiles nil)

(use-package gruvbox-theme)

(if (not custom-enabled-themes)
    (load-theme 'gruvbox t))

(defun reload-config ()
  (interactive)
  (load-file (concat user-emacs-directory "init.el")))

(global-set-key (kbd "C-x w") 'whitespace-mode)
(global-set-key (kbd "C-x j") 'dired-jump)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(add-hook 'emacs-startup-hook (lambda ()
(message (format "emacs init time: %s" (emacs-init-time)))
))

(use-package window-numbering
             :ensure t
             :config

             (window-numbering-mode 1))

(use-package ivy
             :ensure t
             :config

             (ivy-mode 1)
             )

;; TODO: Configure it
(use-package avy
             :ensure t
             :config
             )

(use-package anzu
             :ensure t
             :config

             (global-anzu-mode +1)
             )

(use-package evil-anzu
             :ensure t
             :config

             )
(use-package fuzzy
:ensure t
:config

)
(use-package password-generator
             :ensure t
             :config

             )
(use-package yaml-mode
             :ensure t
             :config

             (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
             )
(use-package toml-mode
             :ensure t
             :config
             )
(use-package restclient
             :ensure t
             :config

             (add-hook 'prog-mode-hook #'ws-butler-mode)
             )
(use-package ws-butler
             :ensure t
             :config

             (add-hook 'prog-mode-hook #'ws-butler-mode)
             )

(use-package json-reformat
             :ensure t
             :config

             )

(use-package typescript-mode
             :ensure t
             :config
             )

(use-package lua-mode
            :ensure t
            )

(use-package rust-mode
            :ensure t
            )

(use-package dockerfile-mode
             :ensure t
             :config
             )

(use-package multiple-cursors
             :ensure t
             :config
             )

(use-package nginx-mode
             :ensure t
             :config
             )
(use-package python-mode
             :ensure t
             :config
             )
(use-package evil-mc
:ensure t
:config
)

(use-package treemacs
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package magit
  :init
  (message "Loading Magit!")
  :config
  (message "Loaded Magit!")
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

;; Evil Mode
(use-package evil
  :ensure t
  :demand t

  :custom
    (evil-esc-delay 0.001 "avoid ESC/meta mixups")
  (evil-shift-width 4)
  (evil-search-module 'evil-search)

  :config

  (evil-mode 1)
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode t)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "s s" 'swiper
      "d x w" 'delete-trailing-whitespace
      "." 'find-file
    ))

  (use-package evil-surround
    :ensure t
    :config (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t)

  (use-package evil-org
    :ensure t
    :config
    (evil-org-set-key-theme
	  '(textobjects insert navigation additional shift todo heading))
    (add-hook 'org-mode-hook (lambda () (evil-org-mode))))

  (use-package powerline-evil
    :ensure t
    :config
    (powerline-evil-vim-color-theme)))

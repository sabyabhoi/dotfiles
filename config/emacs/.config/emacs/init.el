(setq inhibit-startup-message t) ;; hide startup 

(scroll-bar-mode -1) ;; disable scroll bar
(tool-bar-mode -1) ;; disable tool bar
(tooltip-mode -1) ;; disable tooltips
(set-fringe-mode 10) ;; give some inline padding
(menu-bar-mode -1) ;; disable menu bar
(global-hl-line-mode 1)

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq backup-directory-alist '((".*" . "/tmp")))
(setq byte-compile-warnings '(cl-functions))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq font-name "JetBrainsMono Nerd Font"
      font-height 170)
(defun cb/set-font-faces ()
  (dolist (face '(default fixed-pitch))
    (set-face-attribute `,face nil :font font-name :height font-height :weight 'normal))
  (set-face-attribute 'variable-pitch nil :font "JetBrainsMono Nerd Font" :height 170 :weight 'light)
  ;;    (let ((font-name "Iosevka Nerd Font Mono") (font-height 174))
  ;;      )
  )

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (cb/set-font-faces))))
  (cb/set-font-faces))

(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
(setq electric-pair-inhibit-predicate ;; don't autocomplete '<'
      `(lambda (c)
         (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(make-variable-buffer-local 'global-hl-line-mode)
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                treemacs-mode-hook
                vterm-mode-hook))
  (add-hook mode (
                  lambda () 
                  (display-line-numbers-mode 0) (setq global-hl-line-mode nil)
                  )))

(setq workdir "/home/cognusboi/workspace/")

(require 'package)

  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("org" . "https://orgmode.org/elpa/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))

  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))

  ;; Install use-package if it's not already installed
  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (require 'use-package)
  (setq use-package-always-ensure t)
;;  (setq use-package-verbose t)

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*", (no-littering-expand-var-file-name "auto-save/") t)))

(use-package openwith
  :ensure t
  :config
  (setq openwith-associations
        (list
         (list (openwith-make-extension-regexp
                '("mpg" "mpeg" "mp3" "mp4"
				  "avi" "wmv" "wav" "mov" "flv"
				  "ogm" "ogg" "mkv"))
			   "mpv"
			   '(file))
		 (list (openwith-make-extension-regexp
				'("xbm" "pbm" "pgm" "ppm" "pnm"
				  "png" "gif" "bmp" "tif" "jpeg")) 
			   "imv"
			   '(file))
		 (list (openwith-make-extension-regexp
				'("pdf"))
			   "zathura"
			   '(file))))
  )

(use-package posframe
  :ensure t)

(use-package evil
  :config (evil-mode 1)
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-undo-system 'undo-redo))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package projectile
  :defer 0
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (use-package rg)
  (when (file-directory-p "~/workspace/programming")
    (setq projectile-project-search-path '("~/workspace/programming")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit
  :commands (magit-status magit-get-current-branch))

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode)
  (savehist-mode)
  (setq completion-ignore-case t)
  )
(define-key vertico-map "?" #'minibuffer-completion-help)
(define-key vertico-map (kbd "M-RET") #'minibuffer-force-complete-and-exit)
(define-key vertico-map (kbd "M-TAB") #'minibuffer-complete)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic partial-completion flex))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion)))))
  )

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package consult
  :bind (("C-s" . consult-line)))

(use-package dashboard
  :ensure t
  :custom
  (dashboard-center-content t)
  (dashboard-show-shortcuts nil)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-set-navigator t)
  (dashboard-items 'nil)
  (dashboard-set-footer 'nil)
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  )

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.10)
(use-package company
  :hook (prog-mode . company-mode)
  :after lsp
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common)))

(add-hook 'after-init-hook 'global-company-mode)

(dolist (mode '(term-mode-hook
                eshell-mode-hook
                treemacs-mode-hook
                gdb-mode-hook))
  (add-hook mode (lambda () (company-mode 0))))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :ensure t
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :ensure t
  :config
  (general-evil-setup t)

  (general-create-definer cb/leader-key-def
    :keymaps '(normal)
    :prefix "SPC"
    :global-prefix "SPC")
  (cb/leader-key-def
    "b" '(consult-buffer :which-key "Find File")
    "." '(find-file :which-key "Find File")
    "og" '(lambda () (interactive) (dired (concat workdir  "orgfiles/guides/")))
    "oa" '(org-agenda :which-key "Org Agenda")
    "oj" '(lambda () (interactive) (dired (concat workdir  "orgfiles/journal/")))
    "oc" '(org-capture :which-key "Org Capture Prompt")
    "mds" '(org-schedule :which-key "Agenda Schedule")
    "mdd" '(org-deadline :which-key "Agenda Deadline")
    "oe" '(lambda () (interactive) (find-file
                                    (expand-file-name (concat workdir  "orgfiles/guides/Emacs_config.org"))))
    "c" '(lambda () (interactive) (dired (concat workdir "college/3-2/")))
    "rn" 'lsp-rename
	"h" 'hydra-text-scale/body
	)
  (general-nmap
    "K" 'lsp-ui-doc-glance
    ))

(use-package hydra)
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(use-package nordic-night-theme
  :ensure t)

(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-irc nil)
  (doom-modeline-height 50)
  :init
  (doom-modeline-mode 1)
  (use-package all-the-icons
    :ensure t))

(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-tomorrow-night t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024))
  :custom
  (lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-idle-delay 0.1
        lsp-prefer-capf t))

(require 'posframe)
(setq lsp-signature-function 'lsp-signature-posframe)

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-doc-delay 0.05)
  (lsp-ui-doc-position 'at-point))

(use-package yasnippet
  :defer t
  :config
  (add-to-list 'yas-snippet-dirs "~/.config/emacs/snippets")
  (yas-global-mode 1))

(use-package emmet-mode
:hook (sgml-mode-hook web-mode-hook css-mode-hook))

;;(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
;;(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
;;(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(use-package dap-mode
  :commands dap-debug
  :config
  (require 'dap-lldb))

(evil-define-key nil prog-mode-map
  (kbd "<f9>") 'gud-break
  (kbd "S-<f9>") 'gud-remove
  (kbd "<f5>") 'gud-next
  (kbd "S-<f5>") 'gud-cont)

;;  (evil-define-key nil c-mode-map
;;    (kbd "<f9>") 'gud-break
;;    (kbd "S-<f9>") 'gud-remove
;;    (kbd "<f5>") 'gud-next)

(use-package nasm-mode
  :ensure t
  :config 
  (add-to-list 'auto-mode-alist '("\\.asm\\'" . nasm-mode)))

(use-package c++-mode
  :ensure nil
  :hook ((c++-mode . lsp-deferred)))

(use-package c-mode
  :ensure nil
  :hook ((c-mode . lsp-deferred)))

(use-package rustic
  :ensure t
  :defer 0
  :hook((rustic-mode . lsp-deferred))
  :config
  (require 'lsp-rust))

(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
         (go-mode . company-mode))
  :config
  (require 'lsp-go)
  (setq lsp-go-analyses
        '((fieldalignment . t)
          (nilness        . t)
          (unusedwrite    . t)
          (unusedparams   . t))
        )
  (add-to-list 'exec-path "~/go/bin")
  (setq gofmt-command "goimport"))
(add-hook 'go-mode-hook (lambda () (setq tab-width 4)))

(use-package lua-mode
  :ensure t
  :hook ((lua-mode . lsp-deferred))
  :config
  ;;    (add-hook 'lua-mode-hook #'yas-minor-mode)
  ;;    (add-hook 'lua-mode-hook #'company-mode)
  ;;    (add-hook 'lua-mode-hook #'lsp)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil)

  (defun lua-at-most-one-indent (old-function &rest arguments)
    (let ((old-res (apply old-function arguments)))
      (if (> old-res lua-indent-level) lua-indent-level old-res)))

  (advice-add #'lua-calculate-indentation-block-modifier
              :around #'lua-at-most-one-indent)
  )

(use-package zig-mode
  :after lsp
  :custom
  (zig-format-on-save nil)
  :config
  (require 'lsp-mode)
  (setq lsp-zig-zls-executable "/usr/bin/zls"))

(add-hook 'zig-mode-hook 'lsp)
(add-hook 'zig-mode-hook 'company-mode)
(add-hook 'zig-mode-hook 'yas-minor-mode)

(use-package haskell-mode
  :custom
  (haskell-process-suggest-remove-import-lines t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t)
  :bind
  (:map haskell-mode-map
        ("C-c C-c" . haskell-compile))
  )
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(use-package lsp-java
  :ensure t
  :custom
  (lsp-java-vmargs
   (list
    "-Xmx1G"
    "-XX:+UseG1GC"
    "-XX:+UseStringDeduplication"
    "-javaagent:/home/cognusboi/workspace/instdir/lombok.jar"))
  :hook
  ((java-mode . lsp-deferred))
  )
(add-hook 'java-mode-hook (lambda () (setq tab-width 4)))
(add-hook 'java-mode-hook 'lsp)
(use-package java-snippets
  :ensure t
  :hook java-mode)

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  (python-indent-offset 4)
  :config
  (setq lsp-pyls-plugins-flake8-ignore '("D100", "D101"))
  (setq lsp-pylsp-plugins-flake8-ignore '("D100", "D101"))
  )

(defun cb/insert-pipe-operator ()
  (interactive)
  (insert "%>%"))

(use-package ess
  :defer t
  :ensure t)

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))

(use-package prettier-js
  :defer t
  :ensure t)
(add-hook 'web-mode-hook #'(lambda ()
                             (enable-minor-mode
                              '("\\.jsx?\\'" . prettier-js-mode))
                             (enable-minor-mode
                              '("\\.tsx?\\'" . prettier-js-mode))
                             ))

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      create-lockfiles nil)
(use-package web-mode
  :ensure t
  :hook ((web-mode . lsp-deferred))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  :mode (("\\.js\\'" . web-mode)
         ("\\.jsx\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.html\\'" . web-mode))
  :commands web-mode
  :config
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))

(defun web-mode-init-prettier-hook ()
  (prettier-js-mode))

(add-hook 'web-mode-hook  'web-mode-init-prettier-hook)

(define-derived-mode astro-mode web-mode "astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(astro-mode . "astro"))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
                    :activation-fn (lsp-activate-on "astro")
                    :server-id 'astro-ls)))

(use-package svelte-mode
  :ensure t
  :defer 0
  :hook((svelte-mode . lsp-deferred)))

(use-package css-mode
  :ensure nil
  :hook((css-mode . lsp-deferred)))

(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

(use-package prisma-mode
  :load-path "/home/cognusboi/workspace/instdir/emacs-prisma-mode"
  :hook ((prisma-mode . lsp-deferred)))

(setq LaTeX-math-abbrev-prefix ";")
(use-package auctex
  :ensure t
  :defer t
  :config
  )
(use-package cdlatex
  :ensure t :defer t
  :bind
  ((";" . cdlatex-math-symbol)))

(use-package ess
  :ensure t)

(defun cb/org-mode-setup ()
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (auto-fill-mode 0) ;; automatic line break
  (visual-line-mode 1) ;; word wrap turned on
  (setq org-fontify-done-headline t
        org-html-validation-link nil
        org-indent-mode t
        org-startup-indented t
        evil-auto-indent t
        org-pretty-entities t
        org-startup-with-inline-images t
        org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-src-fontify-natively t
        org-src-window-setup 'current-window ;; edit in current window
        org-src-strip-leading-and-trailing-blank-lines t
        org-src-preserve-indentation nil ;; do not put two spaces on the left
        org-edit-src-content-indentation 0
        org-src-tab-acts-natively t)
  (display-line-numbers-mode 0))

(add-hook 'org-mode-hook 'variable-pitch-mode)

(add-hook 'org-mode-hook 'org-indent-mode)

(use-package org
  :hook (org-mode . cb/org-mode-setup)
  :bind (("C-x e" . org-edit-src-code)
		 ("`" . org-cdlatex-mode))
  :custom
  (org-agenda-span 10)
  (org-deadline-warning-days 7)
  (org-directory (concat workdir "orgfiles/guides"))
  (org-agenda-files '("inbox.org"
                      "repeaters.org"
                      ("~/workspace/college/3-2/academics.org")))
  (org-agenda-start-with-log-mode t)
  (org-use-speed-commands t)
  (org-tags-column 5)
  (org-startup-with-latex-preview t) 
  (org-todo-keywords '((type "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                       (type "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
  :config
  (setq org-format-latex-options
        '(:foreground "White" :background "White"
                      :scale 2.5
                      :html-foreground "White" :html-background "White" :html-scale 1.0
                      :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-image-actual-width nil)
  (dolist (face '(
                  (org-document-title . 1.8)
                  (org-level-1 . 1.3)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil
                        :font "JetBrainsMono Nerd Font"
                        :weight 'bold
                        :height (cdr face))))

(custom-theme-set-faces
 'user
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

(defun cb/org-mode-visual-fill ()
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . cb/org-mode-visual-fill))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "◉" "○"))
  )

(setq org-hidden-keywords '(title subtitle author date email))

(with-eval-after-load 'org
  (require 'org-tempo)
  (dolist (expand '(("el" . "src emacs-lisp")
                    ("pro" . "src python :session :results output")
                    ("rro" . "src R :session :results output")
                    ("rrv" . "src R :session")
                    ("prv" . "src python :session ")))
    (add-to-list 'org-structure-template-alist expand)))

(with-eval-after-load 'org
  ;; (setq py-default-interpreter "/usr/bin/python3")
  ;; (setq org-src-tab-acts-natively t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (haskell . t)
     (shell . t)
     (lisp . t)
     (R . t)
     (C . t)))
  (setq org-confirm-babel-evaluate nil))

(defun cb/org-babel-tangle-config()
  (when (string-equal (buffer-file-name)
                      (expand-file-name (concat workdir "orgfiles/guides/Emacs_config.org")))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'cb/org-babel-tangle-config)))

(use-package org-ref
  :defer 0
  :config
  (setq bibtex-completion-bibliography '((concat workdir "college/uni.bib")))
  (setq org-latex-pdf-process (list "latexmk -pdflatex=xelatex -shell-escape -f -pdf %f"))
  )

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (concat workdir  "orgfiles/gyaan"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :bind-keymap ("C-c n d" . org-roam-dailies-map)
  :config
  (setq org-roam-mode-sections
        (list #'org-roam-backlinks-section
              #'org-roam-unlinked-references-section))
  (org-roam-db-autosync-mode)
  (org-roam-setup))

(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t))

(use-package org-capture
  :defer t
  :ensure nil
  :config
  (setq org-capture-templates
        '(
		  ("t" "Todo")
		  ("tg" "General" entry
           (file "~/workspace/orgfiles/guides/inbox.org")
           "* TODO %^{Enter Todo}\n SCHEDULED: %^t \n %?")
		  ("ta" "Academics" entry
		   (file "~/workspace/college/3-2/academics.org")
		   "* TODO %^{Enter Todo}\n %^{Choose|SCHEDULED|DEADLINE}: %^t \n %?")
		  ("b" "Book Entry" entry
		   (file "~/workspace/orgfiles/journal/reading_list.org")
		   "* %^{Enter Name of the Book}
:PROPERTIES:
:AUTHOR: %^{Enter Name of the Author}
:RATING: %^{Choose|TBD|OKAY|NICE|GOAT}
:COMPLETED:  %?
:END:
"
		   )
		  ))
  )

(use-package org-journal
  :ensure t
  :custom
  (org-journal-dir (concat workdir "orgfiles/journal/"))
  (org-journal-date-prefix "#+TITLE: ")
  (org-journal-date-format "%a, %Y-%m-%d")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-time-prefix "*")
  (org-journal-time-format " "))

(use-package ox-reveal
  :custom
  (org-reveal-root "/home/cognusboi/workspace/instdir/reveal.js")
  (org-reveal-theme "blood")
  (org-reveal-init-options "transition: \'none\'")
  )

(defun cb/display-startup-time()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'cb/display-startup-time)

(use-package term
  :defer t
  :config
  (setq explicit-shell-file-name "bash")
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  )

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-max-scrollback 10000))

(evil-define-key 'normal dired-mode-map
    (kbd "h") 'dired-up-directory
    (kbd "l") 'dired-find-file)
;;  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(vterm eterm-256color ox-reveal org-journal org-roam-ui org-roam org-ref org-bullets visual-fill-column cdlatex auctex svelte-mode web-mode prettier-js ess python-mode java-snippets lsp-java haskell-mode zig-mode lua-mode go-mode rustic nasm-mode dap-mode emmet-mode yasnippet lsp-ui lsp-treemacs lsp-mode rainbow-delimiters doom-themes all-the-icons doom-modeline nordic-night-theme hydra general helpful company-box company which-key dashboard consult marginalia orderless vertico magit rg projectile evil-collection evil posframe openwith no-littering use-package))
 '(warning-suppress-types '((org-roam))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

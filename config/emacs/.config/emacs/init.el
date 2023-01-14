(setq inhibit-startup-message t) ;; hide startup 

(scroll-bar-mode -1) ;; disable scroll bar
(tool-bar-mode -1) ;; disable tool bar
(tooltip-mode -1) ;; disable tooltips
(set-fringe-mode 10) ;; give some inline padding
(menu-bar-mode -1) ;; disable menu bar

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

(defun cb/set-font-faces ()
  (let ((font-name "JetBrainsMono Nerd Font Mono") (font-height 152))
    (dolist (face '(default fixed-pitch))
      (set-face-attribute `,face nil :font font-name :height font-height :weight 'normal))
    (set-face-attribute 'variable-pitch nil :font "SF Pro Text" :height 182 :weight 'normal)
    ))

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

(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                treemacs-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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
(setq use-package-verbose t)

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*", (no-littering-expand-var-file-name "auto-save/") t)))

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
  (when (file-directory-p "~/workspace/userfiles/programming")
    (setq projectile-project-search-path '("~/workspace/userfiles/programming")))
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
  (completion-styles '(orderless basic partial-completion flex)))

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
 ;;   :bind
 ;;   (:map company-active-map
 ;;         ("<tab>" . company-complete-selection))
 ;;   (:map lsp-mode-map
 ;;         ("<tab>" . company-indent-or-complete-common))
    :config
    )

  (add-hook 'after-init-hook 'global-company-mode)

;;  (with-eval-after-load 'company
;;    (define-key company-active-map (kbd "<return>") nil)
;;    (define-key company-active-map (kbd "RET") nil)
;;    (define-key company-active-map (kbd "<tab>") #'company-complete-selection))

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
    "oa" '(org-agenda :which-key "Org Agenda")
    "oc" '(org-capture :which-key "Org Capture Prompt")
    "mds" '(org-schedule :which-key "Agenda Schedule")
    "mdd" '(org-deadline :which-key "Agenda Deadline")
    "oe" '(lambda () (interactive) (find-file
                                    (expand-file-name "~/workspace/userfiles/orgfiles/guides/Emacs_config.org")))
    "c" '(lambda () (interactive) (dired "~/workspace/userfiles/college/3-1/"))
    "rn" 'lsp-rename)
  (general-nmap
    "K" 'lsp-ui-doc-glance
    ))

(use-package hydra)
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

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
  (load-theme 'doom-material-dark t))

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
  (message "LSP Mode loaded")
  (setq lsp-idle-delay 0.1))

(require 'posframe)
(setq lsp-signature-function 'lsp-signature-posframe)

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :hook (lsp-mode . lsp-ui-sideline-mode)
  :commands lsp-ui-mode
  :ensure t
  :custom
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-doc-delay 0.0)
  (lsp-ui-doc-position 'at-point))

(use-package yasnippet
  :config
  (add-to-list 'yas-snippet-dirs "~/.config/emacs/snippets")
  (yas-global-mode 1))

(use-package emmet-mode)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(use-package realgud
  :ensure t
  :defer 0)

(use-package dap-mode
  :ensure t
  :config (require 'dap-cpptools))

(load-file "~/workspace/userfiles/programming/Lisp/cc-mode/main.el")

(use-package c++-mode
  :ensure nil
  :hook ((c++-mode . lsp-deferred)))

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
  :ensure t)

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
:config
(setq lsp-pylsp-plugins-flake8-ignore '("D100"))
  )

(defun cb/insert-pipe-operator ()
  (interactive)
  (insert "%>%"))

(use-package ess
  :ensure t)

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))

(use-package prettier-js
  :ensure t)
(add-hook 'web-mode-hook #'(lambda ()
                             (enable-minor-mode
                              '("\\.jsx?\\'" . prettier-js-mode))
                             (enable-minor-mode
                              '("\\.tsx?\\'" . prettier-js-mode))
                             ))

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
  :commands web-mode)

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

(use-package lsp-tailwindcss
  :custom
  (lsp-tailwindcss-major-modes
   '(rjsx-mode web-mode html-mode css-mode typescript-mode astro-mode)))

(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

(defun cb/org-mode-setup ()
  (org-indent-mode)
  (org-toggle-pretty-entities)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq org-fontify-done-headline t
        org-html-validation-link nil
        evil-auto-indent t
        org-startup-with-inline-images t
        org-default-notes-file (concat org-directory "/notes.org"))
  (display-line-numbers-mode 0))

(use-package org-habit
  :ensure nil
  :custom
  (org-habit-graph-column 70))

(add-hook 'org-mode-hook 'variable-pitch-mode)

(use-package org
  :hook (org-mode . cb/org-mode-setup)
  :bind (("C-x e" . org-edit-src-code))
  :custom
  (org-directory "~/workspace/userfiles/orgfiles/guides")
  (org-agenda-files '("Tasks.org" "Meetings.org"))
  (org-agenda-start-with-log-mode t)
  (org-tags-column 5)
  (org-startup-with-latex-preview t) 
  (org-todo-keywords '((type "TODO" "WAIT" "|" "DONE" "KILL")))
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
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil
                        :font "JetBrainsMono Nerd Font Mono"
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

(use-package ox-latex
  :ensure nil
  :defer 0
  :config
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted) 
  (setq org-latex-caption-above nil)
  )

(with-eval-after-load 'org
  (require 'org-tempo)
  (dolist (expand '(("el" . "src emacs-lisp")
                    ("pro" . "src python :session :results output")
                    ("rro" . "src R :session :results output")
                    ("prv" . "src python :session ")))
    (add-to-list 'org-structure-template-alist expand)))

(setq org-hidden-keywords '(title subtitle author date email))

(defun cb/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . cb/org-mode-visual-fill))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "◉" "○"))
  )

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
                      (expand-file-name
                       "~/workspace/userfiles/orgfiles/guides/Emacs_config.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'cb/org-babel-tangle-config)))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/workspace/userfiles/orgfiles/gyaan")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
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
  :ensure nil
  :config
  (setq org-capture-templates
        '(("m" "Meeting Minutes" entry
           (file "~/workspace/userfiles/orgfiles/guides/Meetings.org") "* %?")
          ("t" "Todo" entry
           (file "~/workspace/userfiles/orgfiles/guides/Tasks.org")
           "* TODO %^{Enter Todo}\n SCHEDULED: %^t \n %?")
          ("n" "Note")
          ("nr" "Reference Note" entry
           (file "~/workspace/userfiles/orgfiles/guides/References.org")
           "* %^{Enter note title}\n:PROPERTIES:\n:REF: %?\n:END:\n%T\n")
          ("nf" "Fleeting Note" entry
           (file "~/workspace/userfiles/orgfiles/guides/Fleets.org")
           "* %?\n%T\n")
          ))
  )

(use-package org-ref
  :defer 0
  :config
  (setq bibtex-completion-bibliography '("~/workspace/userfiles/college/uni.bib"))
  (setq org-latex-pdf-process (list "latexmk -pdflatex=xelatex -shell-escape -f -pdf %f"))
  )

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

(use-package ligature
  :load-path "~/workspace/userfiles/programming/Lisp/ligature.el/"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 't '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                               ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                               "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                               "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                               "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                               "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                               "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                               "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                               ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                               "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                               "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                               "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                               "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

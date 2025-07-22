;;


;; =======================
;; === Package Manager ===
;; =======================
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)  ;; Load use-package




;; ===================================
;; === Load package configurations ===
;; ===================================
;; list the files you want to load:
(mapc (lambda (f)
        (let ((p (expand-file-name f configs-packages-path)))
          (when (file-exists-p p)
            (load-file p))))
      '( ;; === BACKBONE ===
        "themes/kaolin.el"  ;; Theme
        "evil.el"           ;; VIM MAPPINGS
        "lsp-mode.el"       ;; LSP Supports
        "treesit-auto.el"   ;; Treesitter Supports
        "corfu"             ;; Auto comletation
        ;; "company.el"        ;; Auto comletation
        ;; === Others ===
        ))

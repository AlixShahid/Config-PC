;; === PATHS ===
(defvar root-path              "~/.config/ide/emacs/")
(defvar config-d-path          "~/.emacs.d/")
;;
(defvar install-root-path     "~/.local/share/emacs/")
(defvar state-root-path       "~/.local/state/emacs/")


(defvar config-d-emacs-file "~/.emacs.d/overridden-by-emacs.el")
;; configs paths
(defvar configs-path          (concat root-path "configs/"))
(defvar configs-conf-file     (concat configs-path      "conf.el"))
(defvar configs-manager-file  (concat configs-path      "package-manager.el"))
(defvar configs-mappings-file (concat configs-path      "mappings.el"))
(defvar configs-ui-file       (concat configs-path      "ui.el"))
(defvar configs-packages-path (concat configs-path      "packages/"))
(defvar utils-path            (concat configs-path      "utils/"))
(defvar utils-helper-file     (concat utils-path              "helper.el"))

;; LSP
(defvar lsp-install-path (concat install-root-path "lsp/servers"))
(defvar lsp-session-path (concat install-root-path "lsp/sessions"))


(provide 'const)

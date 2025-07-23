;;; const.el --- path constants for AMACS config -*- lexical-binding: t -*-

;; ------------------------
;; ## Root directories
;; ------------------------
(defconst ae-v/root-dir
  (expand-file-name "~/.config/ide/emacs/")
  "Base directory for all custom Emacs files in AMACS.")

(defconst ae-v/config-emacs-dir
  (expand-file-name "~/.emacs.d/")
  "Your main Emacs config directory (where init.el lives).")

(defconst ae-v/install-root-dir
  (expand-file-name "~/.local/share/emacs/")
  "Where to install external tools (LSP servers, etc).")

(defconst ae-v/state-root-dir
  (expand-file-name "~/.local/state/emacs/")
  "Where to stash Emacs state (autosaves, backups, sessions).")

;; ------------------------
;; ## Custom-file
;; ------------------------
(defconst ae-v/custom-file
  (expand-file-name "overridden-by-emacs.el" user-emacs-directory)
  "File to store `custom-set-variables` (so init.el stays clean).")

;; ------------------------
;; ## "configs/" module layout
;; ------------------------
(defconst ae-v/configs-dir
  (expand-file-name "configs/" ae-v/root-dir)
  "Directory holding feature-specific config modules.")

(defconst ae-v/configs-conf-file
  (expand-file-name "conf.el" ae-v/configs-dir)
  "Your entry-point config (loads all the others).")

(defconst ae-v/configs-manager-file
  (expand-file-name "package.el" ae-v/configs-dir)
  "Your package-management setup (use-package, straight, etc).")

(defconst ae-v/configs-mapping-file
  (expand-file-name "mapping.el" ae-v/configs-dir)
  "Your custom key-mapping definitions.")

(defconst ae-v/configs-ui-file
  (expand-file-name "ui.el" ae-v/configs-dir)
  "UI-related tweaks: themes, modelines, icons, etc.")

(defconst ae-v/utils-dir
  (expand-file-name "utils/" ae-v/configs-dir)
  "Helper scripts & utilities used by your configs.")

(defconst ae-v/utils-helper-file
  (expand-file-name "helper.el" ae-v/utils-dir)
  "Where you keep helper functions like `my/setup-emacs-state-dirs`.")

;; ------------------------
;; ## Packages/overlays
;; ------------------------
(defconst ae-v/packages-dir
  (expand-file-name "packages/" ae-v/root-dir)
  "Where you drop standalone .el files for package overrides or extensions.")

;; ------------------------
;; ## LSP-specific paths
;; ------------------------
(defconst ae-v/lsp-install-dir
  (expand-file-name "lsp/servers/" ae-v/install-root-dir)
  "Directory under which LSP servers are installed by your scripts.")

(defconst ae-v/lsp-session-dir
  (expand-file-name "lsp/sessions/" ae-v/install-root-dir)
  "Directory where `lsp-session` and caches are stored.")


(provide 'const)
;;; const.el ends here

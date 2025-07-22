(use-package treesit-auto
  :ensure t
  :hook (prog-mode . treesit-auto-mode)
  :config
  ;; Auto-install any missing parser without asking
  (setq treesit-auto-install 'always))


;; ─────────────────────────────────────────────────────────────────────────────
;; LSP Mode Configuration
;; ─────────────────────────────────────────────────────────────────────────────
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred lsp-install-server)

  ;; === INIT ===
  :init
  (setq lsp-keymap-prefix "C-c l")         ;; optional: your LSP “leader”
  ;; ;; Don't auto-kill LSP server after last workspace buffer is killed, because I
  ;; ;; will do it for you, after `+lsp-defer-shutdown' seconds.
  ;; (setq lsp-keep-workspace-alive nil)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; NOTE I tweak LSP's defaults in order to make its more expensive or imposing
  ;;      features opt-in. Some servers implement these poorly and, in most
  ;;      cases, it's safer to rely on Emacs' native mechanisms (eldoc vs
  ;;      lsp-ui-doc, open in popup vs sideline, etc).

  ;; Disable features that have great potential to be slow.
  (setq lsp-enable-folding nil
        lsp-enable-text-document-color nil)
  ;; Reduce unexpected modifications to code
  (setq lsp-enable-on-type-formatting nil)
  ;; Make breadcrumbs opt-in; they're redundant with the modeline and imenu
  (setq lsp-headerline-breadcrumb-enable nil)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  ;; === HOOK ===
  :hook
  ((XXX-mode . lsp) ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
   (prog-mode . lsp-deferred) ;; start LSP in all prog buffers
   (lsp-mode . lsp-enable-which-key-integration))


  ;; === CONFIGS ===
  :config
  (setq lsp-enable-snippet t ;; if you want yasnippet support
        lsp-prefer-capf t    ;; let LSP drive completion
        ))


;; Optional: nice UI for doc popups & sideline diagnostics
(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-doc-enable      t))


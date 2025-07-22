
;; ─────────────────────────────────────────────────────────────────────────────
;; Company Mode (Auto-Completion) Configuration
;; ─────────────────────────────────────────────────────────────────────────────
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)      ;; enable everywhere
  :init
  (setq company-idle-delay               0.1    ;; popup after 0.1s idle
        company-minimum-prefix-length    1      ;; complete after first char
        company-selection-wrap-around    t      ;; cycle at ends
        company-require-match            nil)   ;; allow free typing
  :bind (:map company-active-map
              ;; TAB / <tab> → next, S-TAB / <backtab> → previous
              ("TAB"       . company-select-next)
              ("<tab>"     . company-select-next)
              ("S-TAB"     . company-select-previous)
              ("<backtab>" . company-select-previous)
              ;; RET → accept
              ("RET"       . company-complete-selection)
              ("<return>"  . company-complete-selection)))

;; Hook Company into LSP’s Capf backend
(with-eval-after-load 'lsp-mode
  (setq lsp-completion-provider :capf)
  (add-hook 'lsp-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '(company-capf)))))

;; ─────────────────────────────────────────────────────────────────────────────
;; (Optional) Keybinding to manually trigger completion
;; ─────────────────────────────────────────────────────────────────────────────
(global-set-key (kbd "C-<space>") #'company-complete)



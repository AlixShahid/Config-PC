;;


(set-frame-font "JetBrains Mono-14" t t)


;; === Disable ===

(setq use-dialog-box nil)          ;; Don't pop up UI dialogs when prompting
(menu-bar-mode -1)                 ;; Disable the menu bar
(tool-bar-mode -1)                 ;; Disable the tool bar
(when (fboundp 'scroll-bar-mode)   ;; Turn off the scroll bar in this frame
  (scroll-bar-mode -1))
(add-to-list 'default-frame-alist  ;; Ensure new frames inherit “no scroll-bar”
             '(vertical-scroll-bars . nil))


;; === Highlight ===

(global-hl-line-mode 1)  ;; Enable line highlighting globally


;; === Line ===

(global-display-line-numbers-mode 1)        ;; turn on absolute line numbers everywhere
(setq  display-line-numbers-type 'relative  ;; relative numbers
     display-line-numbers-width nil         ;; nil ⇒ auto-calculate width
     display-line-numbers-grow-only nil     ;; allow it to shrink when lines drop
     display-line-numbers-width-start 1)    ;; start at 1 character
(dolist (mode '(term-mode-hook              ;;disable line numbers in certain modes
                shell-mode-hook
                eshell-mode-hook
                org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

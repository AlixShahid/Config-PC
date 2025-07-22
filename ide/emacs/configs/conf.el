
;; (setq confirm-kill-emacs 'y-or-n-p) ;; Ask y-or-n when you try to kill Emacs
 ;; Revert buffers when the underlying files has been changed
(global-auto-revert-mode 1)
;; Revert Dired and other buffers
(setq global-auto-revert-non-files-buffers t)
 ;; Remember recelntly edited files
(recentf-mode 1)
;; Remember the last place you visited in a file
(save-place-mode 1)
;; Avoid having Emacs place those variables into your configuration file
(redirect-custom-file config-d-emacs-file)
;; backup and state files location
(setup-emacs-state-dirs nil "!" "!")

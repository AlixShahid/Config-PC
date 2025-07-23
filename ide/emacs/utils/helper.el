;;; helper.el — some utility helper functions -*- lexical-binding: t -*-

(defvar my/emacs-state-root "~/.local/state/emacs/"
  "Base directory for Emacs state (autosave + backup).")

(defvar my/emacs-state-autosave-dir nil
  "Where auto-save files go.")
(defvar my/emacs-state-backup-dir nil
  "Where backup files go.")
(defvar my/emacs-state-autosave-prefix nil
  "Prefix/suffix char for auto-saves.")
(defvar my/emacs-state-backup-prefix nil
  "Prefix char for backups.")

;; I made it over complicated...
(defun setup-emacs-state-dirs (&optional root backup-prefix autosave-prefix)
  "Redirect Emacs autosaves and backups under ROOT and use custom prefixes.
ROOT defaults to `~/.local/state/emacs/'.
BACKUP-PREFIX (char or 1-char string) defaults to \"!\".
AUTOSAVE-PREFIX defaults to BACKUP-PREFIX."
  (let* ((root-dir      (expand-file-name (or root my/emacs-state-root)))
         (autosave-dir  (expand-file-name "autosave/" root-dir))
         (backup-dir    (expand-file-name "backup/"   root-dir))
         (bpref-str     (cond ((null backup-prefix)   "!")
                              ((characterp backup-prefix) (char-to-string backup-prefix))
                              ((stringp backup-prefix)   backup-prefix)
                              (t (error "BACKUP-PREFIX must be char or string"))))
         (apref-str     (cond ((null autosave-prefix) bpref-str)
                              ((characterp autosave-prefix) (char-to-string autosave-prefix))
                              ((stringp autosave-prefix)   autosave-prefix)
                              (t (error "AUTOSAVE-PREFIX must be char or string")))))
    ;; 1) create dirs if missing
    (dolist (d (list root-dir autosave-dir backup-dir))
      (unless (file-directory-p d)
        (make-directory d t)))
    ;; 2) stash globals
    (setq my/emacs-state-autosave-dir   autosave-dir
          my/emacs-state-backup-dir     backup-dir
          my/emacs-state-autosave-prefix apref-str
          my/emacs-state-backup-prefix   bpref-str)
    ;; 3) override backup generation
    (setq backup-directory-alist `((".*" . ,backup-dir))
          make-backup-file-name-function #'my/make-backup-file-name)
    ;; 4) override auto-save generation
    (setq auto-save-file-name-transform nil)    ; ignore the default transforms
    (advice-remove 'make-auto-save-file-name #'my/make-auto-save-file-name)
    (advice-add 'make-auto-save-file-name :override #'my/make-auto-save-file-name)
    (message "[Init] State root=%s\n  autosaves → %s (prefix=%s)\n  backups   → %s (prefix=%s)"
             root-dir autosave-dir apref-str backup-dir bpref-str)))

(defun my/make-backup-file-name (file)
  "Return a backup name for FILE using `my/emacs-state-backup-dir` and prefix."
  (let* ((dir   (file-name-directory file))
         (rel   (file-relative-name dir "/"))
         (flat  (replace-regexp-in-string "/" my/emacs-state-backup-prefix rel))
         (name  (file-name-nondirectory file)))
    (expand-file-name
     (concat my/emacs-state-backup-prefix flat name "~")
     my/emacs-state-backup-dir)))

(defun my/make-auto-save-file-name ()
  "Return an auto-save name using `my/emacs-state-autosave-dir` and prefix/suffix."
  (when buffer-file-name
    (let* ((rel  (file-relative-name buffer-file-name "/"))
           (flat (replace-regexp-in-string "/" my/emacs-state-autosave-prefix rel))
           (fn   (concat my/emacs-state-autosave-prefix flat my/emacs-state-autosave-prefix)))
      (expand-file-name fn my/emacs-state-autosave-dir))))



(defun redirect-custom-file (filename)
  "Tell Emacs to write its `custom-set-variables` into FILENAME instead of init.el.
FILENAME is interpreted relative to `user-emacs-directory`."
  (let ((file (locate-user-emacs-file filename)))
    ;; make sure file exists so Customize can write to it
    (unless (file-exists-p file)
      (with-temp-buffer (write-file file)))
    ;; point Emacs at this file for all future `customize` writes
    (setq custom-file file)
    ;; load it silently if there's already content in it
    (load custom-file)
    (message "Custom-file redirected to %s" custom-file)))


(provide 'helper)


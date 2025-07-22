(add-to-list 'load-path "~/.config/ide/emacs/utils/")
(require 'helper)
(require 'const)


;; Load package manager
(load-file configs-manager-file)
;; Load configurations
(load-file configs-mappings-file)
(load-file configs-ui-file)
(load-file configs-conf-file)


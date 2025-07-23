;;; init.el --- initial/root of AMACS's config -*- lexical-binding: t -*-

(add-to-list 'load-path "~/.config/ide/emacs/utils/")
(require 'helper)
(require 'const)


;; Load package manager
(load-file ae-v/configs-manager-file)
;; Load configurations
(load-file ae-v/configs-mapping-file)
(load-file ae-v/configs-ui-file)


;; WARN: show be at end of the line
(load-file ae-v/configs-conf-file)

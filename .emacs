(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p "`y-or-n-p' is easier.")

(add-hook 'write-file-hook
	  '(lambda ()
	     (time-stamp)))
(setq time-stamp-active t)

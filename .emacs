; Emacs settings
;
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq default-frame-alist '((left-fringe . 0) (right-fringe . 0)))
(setq initial-frame-alist '((left-fringe . 0) (right-fringe . 0)))

(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p "`y-or-n-p' is easier.")

(setq default-frame-alist '((background-color . "black")
			    (foreground-color . "gray")))

; Packages

(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
           ("ELPA" . "http://tromey.com/elpa/")
           ("gnu" . "http://elpa.gnu.org/packages/")
           ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

; Evil settings and evil mappings
(evil-mode 1)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

; Org-mode

(add-hook 'write-file-hooks
	  '(lambda ()
	     (time-stamp)))
(setq time-stamp-active t)

(add-hook 'org-mode-hook
	  '(lambda ()
	     (define-key evil-normal-state-local-map "t"
	       '(lambda ()
		  (interactive)
		  (if (org-on-heading-p) (org-todo) (evil-fin-char-to))))))

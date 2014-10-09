;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/.emacs.d")
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
(ido-mode t)
(desktop-save-mode t)
(menu-bar-mode -1)
(normal-erase-is-backspace-mode 0)
(show-paren-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)
(setq make-backup-files nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))))
 '(diff-added ((t (:foreground "cyan"))))
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))))
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((t (:background "coral3"))))
 '(vertical-border ((t nil))))

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'zap-to-char)

;; ----------------------------------------
;; -- Comment-uncomment-line             --
;; -- ORIGINAL IDEA FROM                 --
;; -- HTTP://WWW.OPENSUBSCRIBER.COM/MESSAGE/EMACS-DEVEL@GNU.ORG/10971693.HTML
;; ----------------------------------------
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; ------------------------------------
;; -- web mode configuration
;; ------------------------------------
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)

(set-face-attribute 'web-mode-doctype-face nil :foreground "Blue")
(set-face-attribute 'web-mode-html-tag-face nil :foreground "Orange")


;; -------------------------------------
;; -- auto indent
;; -------------------------------------
(add-hook 'prog-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)
  (linum-mode 1)))     ;; show line number

;; -------------------------------------
;; -- melpa
;; -------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)
(add-to-list 'package-archives
  '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)


;; ------------------------------------
;; -- yasnippet
;; ------------------------------------
(add-to-list 'load-path
              "~/.emacs.d/elpa/yasnippet-0.9.0.1/")
(require 'yasnippet)
(yas-global-mode 1)
;; (setq yas-prompt-functions '(yas-x-prompt yas-dropdown-prompt))
(setq yas-snippet-dirs
      '("~/.emacs.d/elpa/yasnippet-0.9.0.1/snippets/web-mode"        ;; personal snippets
        "~/.emacs.d/elpa/yasnippet-0.9.0.1/snippets"                 ;; the default collection
        ))
(setq yas/root-directory "~/.emacs.d/elpa/yasnippet-0.9.0.1/snippets")
(yas/load-directory yas/root-directory)

;; ------------------------------------
;; -- auto-complete
;; ------------------------------------
(setq ac-auto-start t)
;;; should be loaded after yasnippet so that they can work together
;; (add-to-list 'load-path "~/.emacs.d/auto-complete-1.4.0")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.4.0/dict")
(ac-config-default)

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
;; (ac-set-trigger-key "TAB")
;; (ac-set-trigger-key "<tab>")
;; (define-key yas-minor-mode-map (kbd "\C-o") 'yas-expand)
;; (setq yas-triggers-in-field t)
;; ------------------------------------
;; -- hippie-expand
;; ------------------------------------
;; (global-set-key "\M- " 'hippie-expand)
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(show-paren-mode t)
;;  '(window-combination-resize nil))
;; (setq hippie-expand-try-functions-list '(yas-hippie-try-expand
;; 					 try-expand-dabbrev
;; 					 try-expand-dabbrev-all-buffers
;; 					 try-expand-dabbrev-from-kill
;; 					 try-complete-file-name-partially
;; 					 try-complete-file-name
;; 					 try-expand-all-abbrevs
;; 					 try-expand-list
;; 					 try-expand-line
;; 					 try-complete-lisp-symbol-partially
;; 					 try-complete-lisp-symbol))
;; (setq yas-prompt-functions '(yas-x-prompt yas-dropdown-prompt))



;; -------------------------------------
;; -- dash integration
;; -------------------------------------
;; (add-to-list 'load-path "/path/to/dash-at-point")
(autoload 'dash-at-point "dash-at-point"
          "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

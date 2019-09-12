(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;;ウインドウサイズ
(setq initial-frame-alist
      '((top . 80) (left . 50) (width . 130) (height . 40)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ricty Discord" :foundry "PfEd" :slant normal :weight normal :height 136 :width normal)))))

;; use-packageをインストールする
(straight-use-package 'use-package)
;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; 本来は (use-package hoge :straight t) のように書く必要がある
(setq straight-use-package-by-default t)
;; init-loader
(use-package init-loader)
;; ~/.emacs.d/inits配下のelファイルをすべてロードする
(init-loader-load "~/.emacs.d/init")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "Japanese")
 ;;; ログはエラーが出た時のみ
 '(init-loader-show-log-after-init (quote error-only)))


;; ;; read uim.el
;; (require 'uim)
;; ;; uncomment next and comment out previous to load uim.el on-demand
;; ;; (autoload 'uim-mode "uim" nil t)

;; ;; key-binding for activate uim (ex. C-\)
;; ;(global-set-key "\C-\\" 'uim-mode)
;; ;; Set UTF-8 as preferred character encoding (default is euc-jp).
;; (setq uim-lang-code-alist
;;       (cons '("Japanese" "Japanese" utf-8 "UTF-8")
;;            (delete (assoc "Japanese" uim-lang-code-alist) 
;;                    uim-lang-code-alist)))
;インライン変換表示
;(setq uim-candidate-display-inline t)
;; (straight-use-package 'ibus)
;; (add-hook 'after-init-hook 'ibus-mode-on)

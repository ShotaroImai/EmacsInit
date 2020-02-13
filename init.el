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
;; use-packageをインストールする
(straight-use-package 'use-package)
;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; 本来は (use-package hoge :straight t) のように書く必要がある
(setq straight-use-package-by-default t)
;;atom-one-dark-themeを使う
(straight-use-package 'atom-one-dark-theme)
(load-theme 'atom-one-dark t)
;;ウインドウサイズ
(setq initial-frame-alist
      '((top . 100) (left .45) (width . 130) (height . 40)))
;80 50

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ricty Discord" :foundry "PfEd" :slant normal :weight normal :height 136 :width normal)))))

;;言語環境
(set-language-environment "Japanese")           ; 言語環境を"japanese"に
(prefer-coding-system 'utf-8)                   ; デフォルトの文字コードをUTF-8に

;; read uim.el
(require 'uim)
;Ubuntuで配布しているuim-elはemacs26では不具合(uim-modeがオンになるとC-xが無効になる)なので、githubから直接落と
;(straight-use-package '(uim :local-repo "uim/emacs"))
;; uim.elを読み込みEmacsへIMを登録する
;(require 'uim-leim)
;;デフォルトをskkのひらがなモードへ
(setq uim-default-im-engine "skk")
(setq default-input-method "japanese-skk-uim")
(setq uim-default-im-prop
      '("action_skk_hiragana"))
;; uncomment next and comment out previous to load uim.el on-demand
;(autoload 'uim-mode "uim" nil t)
;; key-binding for activate uim (ex. C-\)
(global-set-key (kbd "S-SPC") 'uim-mode)
;;uim-modeを切りたいときのために
(global-set-key "\C-\\" 'uim-mode)
;; ;; Set UTF-8 as preferred character encoding (default is euc-jp).
(setq uim-lang-code-alist
     (cons '("Japanese" "Japanese" utf-8 "UTF-8")
           (delete (assoc "Japanese" uim-lang-code-alist) 
                    uim-lang-code-alist)))
;; ;インライン変換表示
(setq uim-candidate-display-inline t)

;; init-loader
(use-package init-loader)
(setq init-loader-show-log-after-init 'error-only);;エラーのときだけログを出す
;; ~/.emacs.d/inits配下のelファイルをすべてロードする
(init-loader-load "~/.emacs.d/init")

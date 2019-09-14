;;; 基本的設定を色々書く
;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)
(setq transient-mark-mode t) ;;リージョンに色をつける
;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
(electric-pair-mode 1) ;;カッコ補完
(show-paren-mode t) ;; 対応する括弧をハイライト
;; ツールバーを非表示
(tool-bar-mode 0)
;; タイトルにフルパス表示
(setq frame-title-format "%f")
;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;行番号出すEmacs 26からこれでいけるらしい
(global-display-line-numbers-mode t)
(column-number-mode t) ;; 列番号の表示
(line-number-mode t) ;; 行番号の表示
;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;;モードラインのカスタマイズ
(straight-use-package 'diminish)
(defmacro diminish-minor-mode (file mode &optional new-name)
  "https://github.com/larstvei/dot-emacs/blob/master/init.org"
  `(with-eval-after-load ,file
     (diminish ,mode ,new-name)))
(defmacro diminish-major-mode (hook new-name)
  `(add-hook ,hook #'(lambda ()
                    (setq mode-name ,new-name))))
;; minor mode
(diminish-minor-mode "eldoc" 'eldoc-mode "eld")
(diminish-minor-mode "company" 'company-mode "")
(diminish-minor-mode "git-gutter" 'git-gutter-mode "")
(diminish-minor-mode "Undo-Tree" 'undo-tree-mode "Ut")
(diminish-minor-mode "TmpB" 'tempbuf-mode "")
(diminish-minor-mode "Helm" 'helm-mode "")
;; major mode
(diminish-major-mode 'emacs-lisp-mode-hook "Elisp")

;;smart-mode-lineの設定
(straight-use-package 'smart-mode-line)
;;; この変数を定義しておかないとエラーになるバグあり
;(setq sml/active-background-color "gray60")
;パーセンテージ表示消す
(setq sml/position-percentage-format "")
;;; 読み込み専用バッファは%で表示
(setq sml/read-only-char "%%")
;;; 修正済みバッファは*で表示
(setq sml/modified-char "*")
;;; これがないと表示がはみでる
(setq sml/extra-filler -10)
;;; これを入れないとsmart-mode-lineを読み込むたびに
;;; Loading a theme can run Lisp code.  Really load? (y or n)
;;; と聞いてくる。
(setq sml/no-confirm-load-theme t)
;テーマ
(setq sml/theme 'atom-one-dark)
;(sml/shorten-modes nil)
(sml/setup)
;(sml/apply-theme 'respectful)
;;; その他のthemeを設定
;;(sml/apply-theme 'dark)
;;(sml/apply-theme 'light)

;;自動で使わないバッファを消す
(straight-use-package 'tempbuf)
;;ファイルを開いたら自動的にtempbufを有効にする
(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
;;diredバッファに対してtempbufを有効にする
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
;;magitバッファに対してtempbufを有効にする
(add-hook 'magit-mode-hook 'turn-on-tempbuf-mode)

(straight-use-package 'recentf-ext)
(recentf-mode 1)
(setq recentf-max-saved-items 200)
(setq recentf-save-file "~/.emacs.d/recentf")
(setq recentf-auto-cleanup 'never)
(setq helm-for-files-preferred-list
      '(helm-source-buffers-list
        helm-source-recentf
        helm-source-bookmarks
        helm-source-file-cache
        helm-source-files-in-current-dir
        helm-source-bookmark-set
        helm-source-locate))


;dired+
(straight-use-package 'dired+)
;;Diredモードのときにrでリネームできる
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;redo+
(straight-use-package 'redo+)
(setq undo-no-redo t) ;;過去のundoがredoされないようにする
;;大量のundoに耐えられるように
(setq undo-limit 10000)
(setq undo-strong-limit 1000)

;;undo-tree
;;C-u xでundo-treeを開く
(straight-use-package 'undo-tree)
;; undo-tree を起動時に有効にする
(global-undo-tree-mode t)
;; M-/ をredo に設定する。
(global-set-key (kbd "M-/") 'undo-tree-redo)

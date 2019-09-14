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

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;;自動バイトコンパイル
;; (straight-use-package 'auto-async-byte-compile)
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;自動で使わないバッファを消す
(straight-use-package 'tempbuf)
;;ファイルを開いたら自動的にtempbufを有効にする
(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
;;diredバッファに対してtempbufを有効にする
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)


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

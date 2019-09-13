;;; 基本的設定を色々書く
;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)
(straight-use-package 'linum+) ;;左に行番号表示
(global-linum-mode)
(column-number-mode t) ;; 列番号の表示
(line-number-mode t) ;; 行番号の表示
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
(straight-use-package 'auto-async-byte-compile)
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

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

(straight-use-package 'company)
(global-company-mode)
(setq company-transformers '(company-sort-by-backend-importance))
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)
(setq company-selection-wrap-around t)
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)
(define-key company-active-map [tab] 'company-complete-selection)
(define-key company-active-map (kbd "C-f") 'company-complete-selection)
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)


(straight-use-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(straight-use-package 'migemo)
(straight-use-package 'helm-migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

(global-set-key "\C-s" 'swiper)
(defvar swiper-include-line-number-in-search t)
(straight-use-package 'avy)
(straight-use-package 'swiper-helm)
(straight-use-package 'avy-migemo)
(avy-migemo-mode 1)
(require 'avy-migemo-e.g.swiper)

;;undo-tree
(straight-use-package 'undo-tree)
;; undo-tree を起動時に有効にする
(global-undo-tree-mode t)
;; M-/ をredo に設定する。
(global-set-key (kbd "M-/") 'undo-tree-redo)

;;dired+
(straight-use-package 'dired+)
;;Diredモードのときにrでリネームできる
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;redo+
(straight-use-package 'redo+)
(global-set-key (kbd "C-M-/") 'redo) ;;C-M-/でredo
(setq undo-no-redo t) ;;過去のundoがredoされないようにする
;;大量のundoに耐えられるように
(setq undo-limit 10000)
(setq undo-strong-limit 1000)

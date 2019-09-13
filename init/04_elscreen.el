(straight-use-package 'elscreen)
;;; プレフィクスキーはC-z
(setq elscreen-prefix-key (kbd "C-z"))
;; C-z c 新規スクリーン
;; C-z k スクリーンを閉じる
;; C-z n 次のスクリーン
;; C-z p 前のスクリーン
;; C-z [0-9] 番号のスクリーンへ
;; C-z C-f 新しいスクリーンでファイルを開く
;; C-z b 新しいスクリーンでバッファを開く
;; C-z d 新しいスクリーンでdiredを開く
(elscreen-start)
(set-face-attribute 'elscreen-tab-background-face nil
                    :background "grey10"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-control-face nil
                    :background "grey20"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-current-screen-face nil
                    :background "grey20"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-other-screen-face nil
                    :background "grey30"
                    :foreground "grey60")
;;; [X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; [<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; タブに表示させる内容を決定
;; (setq elscreen-buffer-to-nickname-alist
;;       '(("^dired-mode$" .
;;          (lambda ()
;;            (format "Dired(%s)" dired-directory)))
;;         ("^Info-mode$" .
;;          (lambda ()
;;            (format "Info(%s)" (file-name-nondirectory Info-current-file))))
;; (setq elscreen-mode-to-nickname-alist
;;       '(("[Ss]hell" . "shell")
;;         ("compilation" . "compile")
;;         ("-telnet" . "telnet")
;;         ("dict" . "OnlineDict")))

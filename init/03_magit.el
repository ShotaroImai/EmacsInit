;;;gitの差分と行番号両方出す
;; git-gutter
(straight-use-package 'git-gutter)
(global-git-gutter-mode t)
(straight-use-package 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; ファイル編集時に，bufferを再読込
(global-auto-revert-mode 1)

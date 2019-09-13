;; git-gutter-fringe
(global-git-gutter-mode 1)
(straight-use-package 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; ファイル編集時に，bufferを再読込
(global-auto-revert-mode 1)

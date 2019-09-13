;;;gitの差分と行番号両方出す
(require 'linum)
;(global-linum-mode) 
;; git-gutter-fringe
;(straight-use-package 'git-gutter)
(straight-use-package 'fringe-helper)
(straight-use-package 'git-gutter-fringe)
;(git-gutter-fr+-minimal)
;; (set-face-foreground 'git-gutter+-modified "yellow")
;; (set-face-foreground 'git-gutter+-added    "blue")
;; (set-face-foreground 'git-gutter+-deleted  "white")
;(setq git-gutter:window-width 2)
(setq-default left-fringe-width  15)
(global-display-line-numbers-mode t)
(column-number-mode t) ;; 列番号の表示
(line-number-mode t) ;; 行番号の表示
(global-git-gutter-mode t)
(straight-use-package 'magit)
(global-set-key (kbd "C-x g") 'magit-status)


;; ファイル編集時に，bufferを再読込
(global-auto-revert-mode 1)

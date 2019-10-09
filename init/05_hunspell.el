;;installing flycheck-hunspell
(use-package flycheck-hunspell
  :straight (flycheck-hunspell :type git :host github
                      :repo "leotaku/flycheck-hunspell")
  :after flycheck)
;;Enable your preferred checkers by adding them to flycheck-checkers like so:
;(add-to-list 'flycheck-checkers 'tex-hunspell-dynamic)
;;You may also want to automatically enable flycheck for TeX or any other mode.
(add-hook 'TeX-mode-hook 'flycheck-mode)

;;ispellをaspellに置き換え
(setq ispell-program-name "hunspell")

;;日本語まじりでも使えるようにする
(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))


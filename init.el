;;; Last Update:<2020-04-29@16:11JST by imai>
;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el
;; <leaf-install-code>
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)
    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;; ここにいっぱい設定を書く
;;言語環境
(set-language-environment "Japanese")           ; 言語環境を"japanese"に
(prefer-coding-system 'utf-8)
(define-key global-map (kbd "C-t") 'other-window) ; ウィンドウ切り替え
(setq-default indent-tabs-mode nil)
;; <leaf-setting>
(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))
;; </leaf-setting>

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :added "2020-04-26"
  :custom
  `((tool-bar-mode . nil)
    (inhibit-startup-message . t) ;; すたーとめにゅー消す
    (transient-mark-mode . t)  ;;リージョンに色をつける
    (make-backup-files . nil) ;; *.~ とかのバックアップファイルを作らない
    (electric-pair-mode . t) ;;カッコ補完
    (show-paren-mode . t) ;; 対応する括弧をハイライト
    (tab-width . 4)
    ;行番号出すEmacs 26からこれでいけるらしい
    (global-display-line-numbers-mode . t)
    (column-number-mode . t) ;; 列番号の表示
    (line-number-mode . t) ;; 行番号の表示
    )
  )
(setq initial-frame-alist
      '((top . 80) (left . 60) (width . 160) (height . 40)))
(set-face-attribute 'default nil :family "Ricty Discord" :height 140)
(setq frame-title-format "%f")

(leaf atom-one-dark-theme
  :doc "Atom One Dark color theme"
  :added "2020-04-26"
  :url "https://github.com/jonathanchu/atom-one-dark-theme"
  :ensure t
  :config
  (load-theme 'atom-one-dark t)
  )

;; (leaf ddskk
;;   :doc "Simplnne Kana to Kanji conversion program."
;; ;  :req "ccc-1.43" "cdb-20141201.754"
;;   :require skk-study
;;   :added "2020-04-26"
;;   :ensure t
;; ;  :after ccc cdb
;;   :bind
;;    (("C-\\" . skk-mode))
;;    ;;("\C-x\C-j" . skk-mode))
;;    :init
;;    (setq skk-jisyo-code 'utf-8-dos)
;;    (setq skk-user-directory "~/google/CorvusSKK/")
;;    (setq skk-init-file "~/google/CorvusSKK/init")
;; ;   (setq skk-jisyo (cons "~/google/CorvusSKK/userdict.txt" 'utf-8))
;;    (setq skk-jisyo "~/google/CorvusSKK/userdict.txt")
;;    ;; (setq skk-large-jisyo "~/google/CorvusSKK/SKK-JISYO.L")
;; ;   (setq skk-large-jisyo "~/google/CorvusSKK/skk_jisyo/SKK-JISYO.L")
;; ;   (setq skk-large-jisyo (cons "~/google/CorvusSKK/skkdict.txt" 'utf-8))
;;    (setq skk-large-jisyo "~/google/CorvusSKK/skkdict.txt")
;;    (setq default-input-method "japanese-skk")
;;    )

(leaf uim
;  :ensure t
;  :el-get uim/uim
  :tag "buildin"
  :added "2020-04-27"
  :bind
  ("C-\\" . uim-mode)
  :init
  (setq uim-default-im-engine "skk")
  (setq default-input-method "japanese-skk-uim")
  (setq uim-default-im-prop
        '("action_skk_hiragana"))
;  :config
  ;; ;; Set UTF-8 as preferred character encoding (default is euc-jp).
  )
  ;; (setq uim-lang-code-alist
  ;; (cons '("Japanese" "Japanese" utf-8 "UTF-8")
  ;; (delete (assoc "Japanese" uim-lang-code-alist) 
  ;;  uim-lang-code-alist)))
  ;; ;インライン変換表示
  (setq uim-candidate-display-inline t)

(leaf time-stamp
  :doc "Maintain last change time stamps in files edited by Emacs"
  :tag "builtin"
  :added "2020-04-27"
  :hook
  (before-save-hook . time-stamp)
  :config
  (setq time-stamp-active t)
  (setq time-stamp-start "[lL]ast[ -][uU]pdate:<")
  ;; 西暦-月-日@時刻(24時間表示)JST(タイムゾーン) by user
  (setq time-stamp-format "%04y-%02m-%02d@%02H:%02M%Z by %u")
  (setq time-stamp-end ">")
  (setq time-stamp-line-limit 20)
  )

(leaf recentf-ext
 :doc "Recentf extensions"
 :tag "files" "convenience"
 :added "2020-04-27"
 :url "http://www.emacswiki.org/cgi-bin/wiki/download/recentf-ext.el"
 :ensure t
 :config
 (recentf-mode 1)
 (setq recentf-max-saved-items 200)
 (setq recentf-save-file "~/.emacs.d/recentf")
 (setq recentf-auto-cleanup 'never)
 ;; .recentf自体は含まない
 (setq recentf-exclude '("recentf"))
 )

(leaf undo-tree
  :doc "Treat undo history as a tree"
  :tag "tree" "history" "redo" "undo" "files" "convenience"
  :added "2020-04-27"
  :url "http://www.dr-qubit.org/emacs.php"
  :ensure t
  :leaf-defer nil
  :bind
  ("M-/" . undo-tree-redo)
  :custom
;  :init
  ;; undo-tree を起動時に有効にする
  (global-undo-tree-mode . t)
  )

(leaf git-gutter
  :doc "Port of Sublime Text plugin GitGutter"
  :req "emacs-24.3"
  :tag "emacs>=24.3"
  :added "2020-04-27"
  :url "https://github.com/emacsorphanage/git-gutter"
  :emacs>= 24.3
  :ensure t
  :config
  (global-git-gutter-mode t)
  )

(leaf magit
  :doc "A Git porcelain inside Emacs."
  :req "emacs-25.1" "async-20180527" "dash-20180910" "git-commit-20181104" "transient-20190812" "with-editor-20181103"
  :tag "vc" "tools" "git" "emacs>=25.1"
  :added "2020-04-27"
  :emacs>= 25.1
  :ensure t
  :after git-commit with-editor
  :bind
  ("C-x g" . magit-status)
  :config
  ;; ファイル編集時に，bufferを再読込
  (global-auto-revert-mode 1)
  )

(leaf elscreen
  :doc "Emacs window session manager"
  :req "emacs-24"
  :tag "convenience" "window" "emacs>=24"
  :added "2020-04-27"
  :url "https://github.com/knu/elscreen"
  :emacs>= 24
  :ensure t
  :bind
  ("C-z" . elscreen-prefix-key)
  :init
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
  :config
;;; [X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
;;; [<->]を表示しない
  (setq elscreen-tab-display-control nil)
)

(leaf yatex
  :doc "Yet Another tex-mode for emacs //野鳥//"
  :added "2020-04-27"
  :ensure t
  :mode
  ("\\.tex$" . yatex-mode)
  ("\\.sty$" . yatex-mode)
  ("\\.bbl$" . yatex-mode)
  :bind (("C-c C-t" . YaTeX-typeset-menu))
  :hook
  (yatex-mode . turn-on-reftex)
  (yatex-mode-hook .(lambda ()
                      (reftex-mode 1)
                      (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
                      (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
  :config
  (setq YaTeX-inhibit-prefix-letter t)
  (setq YaTeX-kanji-code nil)
  (setq YaTeX-latex-message-code 'utf-8)
  (setq YaTeX-use-LaTeX2e t)
  (setq YaTeX-use-AMS-LaTeX t)
  (setq tex-command "ptex2pdf -u -l -ot \"-kanji=utf8 -synctex=1\"")
  ;; (setq tex-command "lualatex -synctex=1")
  ;evinceでPDF見る
  (setq dvi2-command "evince")
  (setq tex-pdfview-command "evince")
  ;bibtex
  (setq bibtex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
  (setq makeindex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
  )

;;<ivy/counsel>
(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :added "2020-04-27"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
;;  (setq ivy-height 20) ;; minibufferのサイズをかくだい
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)
          (swiper . ivy--regex-plus)))
  (setq ivy-use-virtual-buffers t)
  )

(leaf swiper
  :doc "Isearch with an overview. Oh, man!"
  :req "emacs-24.5" "ivy-0.13.0"
  :tag "matching" "emacs>=24.5"
  :added "2020-04-27"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :after ivy
  :bind
  ("C-s" . isearch-forward-or-swiper)
  :config
  (defun isearch-forward-or-swiper (use-swiper)
    (interactive "p")
    ;; (interactive "P") ;; 大文字のPだと，C-u C-sでないと効かない
    (let (current-prefix-arg)
      (call-interactively (if use-swiper 'swiper 'isearch-forward))))
  )

(leaf counsel
  :doc "Various completion functions using Ivy"
  :req "emacs-24.5" "swiper-0.13.0"
  :tag "tools" "matching" "convenience" "emacs>=24.5"
  :added "2020-04-27"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :after swiper
  :bind
  ("M-x" . counsel-M-x)
  ("M-y" . counsel-yank-pop)
  ("C-x C-r" . counsel-recentf)
  ("C-x C-b" . counsel-ibuffer)
  ("C-x C-f" . counsel-find-file)
  :config
  (counsel-mode 1)
;;  (setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
  )

(leaf migemo
  :doc "Japanese incremental search through dynamic pattern expansion"
  :req "cl-lib-0.5"
  :added "2020-04-27"
  :url "https://github.com/emacs-jp/migemo"
  :disabled t
  :when (executable-find "cmigemo")
  :commands migemo-init
  :config
  (setq migemo-command (executable-find "cmigemo"))
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
  (setq migemo-coding-system 'utf-8-unix)
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (load-libray "migemo")
  (migemo-init))

(leaf avy-migemo
  :doc "avy with migemo"
  :req "emacs-24.4" "avy-0.4.0" "migemo-1.9"
  :tag "migemo" "avy" "emacs>=24.4"
  :added "2020-04-27"
  :url "https://github.com/momomo5717/avy-migemo"
  :emacs>= 24.4
  :ensure t
  :after avy migemo
  :require "avy-migemo-e.g.swiper"
  :bind
  ("C-M-;" . avy-migemo-goto-char-timer)
  :config
  (avy-migemo-mode . t)
  (setq avy-timeout-seconds nil)
  (require 'avy-migemo-e.g.swiper)
  )


(leaf company
  :doc "Modular text completion framework"
  :req "emacs-24.3"
  :tag "matching" "convenience" "abbrev" "emacs>=24.3"
  :added "2020-04-27"
  :url "http://company-mode.github.io/"
  :emacs>= 24.3
  :ensure t
  :bind
  (company-active-map
   ("C-n" . company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("C-s" . company-filter-candidates) ;; C-sで絞り込む
   ("[tab]" . company-complete-selection) ;; TABで候補を設定
   ("C-f" . company-complete-selection) ;; C-fで候補を設定
)
  :config
  (global-company-mode . t)
  (setq company-transformers . company-sort-by-backend-importance)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (setq company-selection-wrap-around . t)
  (setq completion-ignore-case . t)
  (setq company-dabbrev-downcase . nil)
)

;; <multi-term>
(leaf multi-term
  :ensure t
  :custom `((multi-term-program . ,(getenv "SHELL")))
  :preface
  (defun namn/open-shell-sub (new)
   (split-window-below)
   (enlarge-window 5)
   (other-window 1)
   (let ((term) (res))
     (if (or new (null (setq term (dolist (buf (buffer-list) res)
                                    (if (string-match "*terminal<[0-9]+>*" (buffer-name buf))
                                        (setq res buf))))))
         (multi-term)
       (switch-to-buffer term))))
  (defun namn/open-shell ()
    (interactive)
    (namn/open-shell-sub t))
  (defun namn/to-shell ()
    (interactive)
    (namn/open-shell-sub nil))
  :bind (("C-^"   . namn/to-shell)
         ("C-M-^" . namn/open-shell)
         (:term-raw-map
          ("C-t" . other-window))))
;;</multi-term>

;;<tab>
(leaf whitespace
  :ensure t
  :custom
  ((whitespace-style . '(face
                         trailing
                         tabs
                         ;; spaces
                         ;; empty
                         space-mark
                         tab-mark))
   (whitespace-display-mappings . '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
   (global-whitespace-mode . t)))
;;</tab>

;; Prevent Inserting custom-variables by system
(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :added "2020-04-26"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))
(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

;; command menu
(leaf transient-dwim
  :ensure t
  :bind (("M-=" . transient-dwim-dispatch)))
(provide 'init)
 ;; Local Variables:
;; indent-tabs-mode: nil
;; End:

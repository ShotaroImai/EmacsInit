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
;; Emacs入門から始めるleaf.el入門
;;https://qiita.com/conao3/items/347d7e472afd0c58fbd7
;;にしたがった
;; <leaf-setting>
(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))
;; </leaf-setting>
(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

;; command menu
(leaf transient-dwim
  :doc "Useful preset transient commands"
  :req "emacs-26.1" "transient-0.1"
  :tag "tools" "emacs>=26.1"
  :added "2020-05-03"
  :url "https://github.com/conao3/transient-dwim.el"
  :emacs>= 26.1
  :ensure t
  :bind (("M-=" . transient-dwim-dispatch)))


;;<interfaceや使い勝手の向上>
(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :added "2020-04-26"
  :bind
  ("C-t" . other-window)
  :init
  ;; 言語環境を"japanese"に。LANG=en_USなので。
;  (set-language-environment "Japanese")
  (prefer-coding-system 'utf-8)
  (setq-default indent-tabs-mode nil)
  (setq initial-frame-alist
        '((top . 105) (left . 60) (width . 165) (height . 35)))
;  (set-face-attribute 'default nil :family "Ricty Discord" :height 140)
  (set-face-attribute 'default nil :family "HackGen Console" :height 140)
  (setq frame-title-format "%f")
  :custom
  (tool-bar-mode . nil)
  (inhibit-startup-message . t) ;; スタートメニュー消す
  (transient-mark-mode . t)  ;;リージョンに色をつける
  (make-backup-files . nil) ;; *.~ とかのバックアップファイルを作らない
  (electric-pair-mode . t) ;;カッコ補完
  (show-paren-mode . t) ;; 対応する括弧をハイライト
  (tab-width . 4)
  ;;行番号出すEmacs 26からこれでいける
  (global-display-line-numbers-mode . t)
  (column-number-mode . t) ;; 列番号の表示
  (line-number-mode . t) ;; 行番号の表示
  )

(leaf atom-one-dark-theme
  :doc "Atom One Dark color theme"
  :added "2020-04-26"
  :url "https://github.com/jonathanchu/atom-one-dark-theme"
  :ensure t
  :config
  (load-theme 'atom-one-dark t)
  )

(leaf ddskk
  :doc "Simplnne Kana to Kanji conversion program."
;;  :req "ccc-1.43" "cdb-20141201.754"
  :require skk-study
  :added "2020-04-26"
  :ensure t
;;  :after ccc cdb
  :bind
   (("C-\\" . skk-mode))
   ;;("\C-x\C-j" . skk-mode))
   :init
   (setq skk-preload t)
   (setq skk-jisyo-code 'utf-8)
   (setq skk-user-directory "~/google/ddskk/")
   (setq skk-jisyo "~/google/ddskk/userdict.utf8")
   (setq skk-large-jisyo "~/google/ddskk/SKK-JISYO.utf8")
   (setq skk-record-file "~/google/ddskk/record")
   (setq default-input-method "japanese-skk")
   ;;自動コンパイル
   (setq skk-byte-compile-init-file t)
   :hook
   (skk-load-hook . (lambda() (require 'context-skk)))
   :mode
   ("\\.py$" . context-skk-programming-mode)
   ("\\.pu$" . context-skk-programming-mode)
   :config
   (setq skk-use-auto-kutouten t
         skk-show-icon t
         skk-japanese-message-and-error t
         skk-version-codename-ja t
         skk-auto-paren-string-alist t)
   )

;; (leaf uim
;; ;  :ensure t
;; ;  :el-get uim/uim
;;   :tag "buildin"
;;   :added "2020-04-27"
;;   :bind
;;   ("C-\\" . uim-mode)
;;   :init
;;   (setq uim-default-im-engine "skk")
;;   (setq default-input-method "japanese-skk-uim")
;;   (setq uim-default-im-prop
;;         '("action_skk_hiragana"))
;; ;  :config
;;   ;; ;; Set UTF-8 as preferred character encoding (default is euc-jp).
;;   )
;;   ;; (setq uim-lang-code-alist
;;   ;;       (cons '("Japanese" "Japanese" utf-8 "UTF-8")
;;   ;;             (delete (assoc "Japanese" uim-lang-code-alist)
;;   ;;                     uim-lang-code-alist)))
;;   ;; )

(leaf recentf-ext
 :doc "Recentf extensions"
 :tag "files" "convenience"
 :added "2020-04-27"
 :url "http://www.emacswiki.org/cgi-bin/wiki/download/recentf-ext.el"
 :ensure t
 ;; :init
 :bind
 ;; counsel-recentfが何故か動かないので
;; ("C-x C-r" . recentf-open-files)
 :config
 (recentf-mode t)
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
  ;; undo-tree を起動時に有効にする
  (global-undo-tree-mode . t)
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

(leaf neotree
  :doc "A tree plugin like NerdTree for Vim"
  :req "cl-lib-0.5"
  :added "2020-05-03"
  :url "https://github.com/jaypei/emacs-neotree"
  :ensure t
  :bind
  ("C-q" . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  ;; ルートディレクトリを自動更新しない
  (setq neo-autorefresh nil)
  ;; neotreeを開いた時のカレントファイルのディレクトリを表示する
  (setq neo-smart-open t)
  ;; 隠しファイルをデフォルトで表示
  (setq neo-show-hidden-files t)
  )
;;</interface>

;;<ivy/counsel>
(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :added "2020-04-27"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :init
  (ivy-mode t)
  :bind
  ("<escape>" . minibuffer-keyboard-quit)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
;;  (setq ivy-height 20) ;; minibufferのサイズをかくだい
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)
          (swiper . ivy--regex-plus)))
  ;; プロンプトの表示が長い時に折り返す（選択候補も折り返される）
  (setq ivy-truncate-lines nil)
  ;; リスト先頭で `C-p' するとき，リストの最後に移動する
  (setq ivy-wrap t)
  (with-eval-after-load "magit"
    (setq magit-completing-read-function 'ivy-completing-read))
  (setq ivy-count-format "(%d/%d) ")
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
;;  ("C-s" . swiper-thing-at-point)
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
  ;;counsel-recentfが動かない
  ("C-x C-r" . counsel-recentf)
  ("C-x C-b" . counsel-ibuffer)
  ("C-c g" . counsel-git)
  ("C-x C-f" . counsel-find-file)
  :init
  (counsel-mode 1)
  ;;  (setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
  )

(leaf ivy-dired-history
  :doc "use ivy to open recent directories"
  :req "ivy-0.9.0" "counsel-0.9.0" "cl-lib-0.5"
  :added "2020-05-03"
  :url "https://github.com/jixiuf/ivy-dired-history"
  :ensure t
  :after ivy counsel
  :bind
;;  (dired-mode-map ("," 'dired))
  :config
  (with-eval-after-load "session"
    (add-to-list 'session-globals-include 'ivy-dired-history-variable))
  )


(leaf all-the-icons-ivy-rich
  :doc "Better experience with icons for ivy"
  :req "emacs-24.5" "ivy-rich-0.1.0" "all-the-icons-2.2.0"
  :tag "ivy" "icons" "convenience" "emacs>=24.5"
  :added "2020-05-03"
  :url "https://github.com/seagle0128/all-the-icons-ivy-rich"
  :emacs>= 24.5
  :ensure t
  :after ivy-rich all-the-icons
  :init
  (all-the-icons-ivy-rich-mode 1)
  ;; The icon size
  (setq all-the-icons-ivy-rich-icon-size 1.0)
  )

(leaf ivy-rich
  :doc "More friendly display transformer for ivy."
  :req "emacs-24.5" "ivy-0.8.0"
  :tag "ivy" "emacs>=24.5"
  :added "2020-05-03"
  :emacs>= 24.5
  :ensure t
  :after ivy
  :init
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  )
;; </ivy/counsel>

;; ;;<spell check>
(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "tools" "languages" "convenience" "emacs>=24.3"
  :added "2020-05-02"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :init (global-flycheck-mode)
  :config
   (setq
     flycheck-display-errors-delay 1
     flycheck-highlighting-mode 'lines  ;; columns symbolsm sexps lines
     flycheck-check-syntax-automatically '(save)
     )
   )

(leaf flyspell
  :doc "On-the-fly spell checker"
  :tag "builtin"
  :added "2020-05-02"
  :hook
  ;; flyspell-prog-modeはコメント領域だけ
  ((prog-mode . flyspell-prog-mode)
         (yatex-mode . flyspell-mode)
         (org-mode . flyspell-mode)
         (text-mode . flyspell-mode)
         (python-mode . flyspell-mode))
)

(leaf ispell
  :doc "interface to spell checkers"
  :tag "builtin"
  :added "2020-05-02"
  :config
  (setq ispell-program-name "hunspell")
  (setq ispell-really-hunspell t)
  ;;;日本語混りでも使えるように
  (eval-after-load "ispell"
    '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
  (setq ispell-dictionary   "en_US")
  )

(leaf flyspell-correct-ivy
  :doc "Correcting words with flyspell via ivy interface"
  :req "flyspell-correct-0.6.1" "ivy-0.8.0" "emacs-24.3"
  :tag "emacs>=24.3"
  :added "2020-05-03"
  :url "https://github.com/d12frosted/flyspell-correct"
  :emacs>= 24.3
  :ensure t
  :after flyspell-correct ivy
  :bind
  (flyspell-mode-map
   ("C-;" . flyspell-correct-wrapper))
  )
;; ;;</spell check>

;; ;;<migemo>
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
  (migemo-init)
  )

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
  )
;; ;;</migemo>

;; ;;<git>
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
  ;;設定が効いてない。何故?
  ("C-x g" . magit-status)
  :config
  ;; ファイル編集時に，bufferを再読込
  (global-auto-revert-mode 1)
  )
;; ;;</git>

;; ;;<tex>
(leaf yatex
  :doc "Yet Another tex-mode for emacs //野鳥//"
  :added "2020-04-27"
  :ensure t
  :mode
  (("\\.tex$" . yatex-mode)
  ("\\.sty$" . yatex-mode)
  ("\\.bbl$" . yatex-mode))
  ;; :bind
  ;; (yatex-mode-map
  ;;  ("C-c C-t" . YaTeX-typeset-menu))
  :init
  (setq YaTeX-inhibit-prefix-letter t)
  (setq YaTeX-kanji-code nil)
  (setq YaTeX-latex-message-code 'utf-8)
  (setq YaTeX-use-LaTeX2e t)
  (setq YaTeX-use-AMS-LaTeX t)
  :hook
  (yatex-mode . turn-on-reftex)
  (yatex-mode-hook .(lambda ()
                      (reftex-mode 1)
                      (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
                      (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
  :config
  (setq tex-command "ptex2pdf -u -l -ot \"-kanji=utf8 -synctex=1\"")
  ;; (setq tex-command "lualatex -synctex=1")
  ;evinceでPDF見る
  (setq dvi2-command "evince")
  (setq tex-pdfview-command "evince")
  ;bibtex
  (setq bibtex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
  (setq makeindex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
  )
;; ;;</tex>

;; ;;<python>
(leaf python-mode
  :doc "Python major mode"
  :added "2020-05-06"
  :ensure t
  :mode
  ("\\.py\\'" . python-mode)
  :interpreter
  ("python" . python-mode)
  ("python3" . python-mode)
  )

(leaf ein
  :doc "Emacs IPython Notebook"
  :req "emacs-25" "websocket-20190620.338" "anaphora-20180618" "request-20200117.0" "deferred-0.5" "polymode-20190714.0" "dash-2.13.0"
  :tag "emacs>=25"
  :added "2020-05-03"
  :emacs>= 25
  :ensure t
  :after websocket anaphora deferred polymode
  )

(leaf elpy
  :doc "Emacs Python Development Environment"
  :req "company-0.9.2" "emacs-24.4" "highlight-indentation-0.5.0" "pyvenv-1.3" "yasnippet-0.8.0" "s-1.11.0"
  :tag "emacs>=24.4"
  :added "2020-05-03"
  :emacs>= 24.4
  :ensure t
  :after company highlight-indentation pyvenv yasnippet
  :init
  (elpy-enable)
  :config
  ;; (setq python-shell-interpreter "python3"
  ;;       python-shell-interpreter-args "-i")
  (setq elpy-rpc-python-command "python3")
  ;; Use Jupyter console
  (setq python-shell-interpreter "jupyter"
        python-shell-interpreter-args "console --simple-prompt"
        python-shell-prompt-detect-failure-warning nil)
  (add-to-list 'python-shell-completion-native-disabled-interpreters
               "jupyter")
  ;;  Enable Flycheck
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  (setq elpy-rpc-virtualenv-path 'current)
  (when (load "flycheck" t t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  )

;; ;;</python>

;; ;;<plantuml>
(leaf plantuml-mode
  :doc "Major mode for PlantUML"
  :req "dash-2.0.0" "emacs-25.0"
  :tag "ascii" "plantuml" "uml" "emacs>=25.0"
  :added "2020-05-02"
  :emacs>= 25.0
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.pu$" . plantuml-mode))
  (setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
  (setq plantuml-default-exec-mode 'jar)
  ;; javaにオプションを渡したい場合はここにかく
  ;;(setq plantuml-java-options "")
  ;; plantumlのプレビューをsvg, pngにしたい場合はここをコメントイン
  ;; デフォルトでアスキーアート
  ;;(setq plantuml-output-type "utxt")
  ;; 日本語を含むUMLを書く場合はUTF-8を指定
  (setq plantuml-options "-charset UTF-8")
  )

(leaf flycheck-plantuml
  :doc "Integrate plantuml with flycheck"
  :req "flycheck-0.24" "emacs-24.4" "plantuml-mode-1.2.2"
  :tag "emacs>=24.4"
  :added "2020-05-02"
  :url "https://github.com/alexmurray/flycheck-plantuml"
  :emacs>= 24.4
  :ensure t
  :after flycheck plantuml-mode
  :config
  (flycheck-plantuml-setup)
  )
;; ;;</plantuml>

;; ;;<company>
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
;;   ("[tab]" . company-complete-selection) ;; TABで候補を設定
   ("C-f" . company-complete-selection) ;; C-fで候補を設定
   ("<tab>" . company-indent-or-complete-common)
   )
  :config
  (global-company-mode)
  (setq company-transformers . company-sort-by-backend-importance)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (setq company-selection-wrap-around . t)
  (setq completion-ignore-case . t)
  (setq company-dabbrev-downcase . nil)
  ;; -や_などを含む語句も補完
  (setq company-dabbrev-char-regexp "\\(\\sw\\|\\s_\\|_\\|-\\)")
  (setq company-backends '((company-capf company-dabbrev)
                           ;;company-bbdb
                           ;;company-eclim
                           company-semantic
                           ;;company-clang
                           ;;company-xcode
                           ;;company-cmake
                           company-files
                           (company-dabbrev-code company-gtags
                                                 company-etags company-keywords)
                           ;;company-oddmuse
                           ))
  )
;; ;;</company>

;; <tabスペース削除>
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
;; </tabスペース削除>

;; ;; ;;<fish>
;; (leaf fish-mode
;;   :doc "Major mode for fish shell scripts"
;;   :req "emacs-24"
;;   :tag "shell" "fish" "emacs>=24"
;;   :added "2020-05-06"
;;   :emacs>= 24
;;   :ensure t)
;; ;; ;;</fish>

;;<timestamp>
(leaf time-stamp
  :doc "Maintain last change time stamps in files edited by Emacs"
  :tag "builtin"
  :added "2020-05-11"
  :config
  (add-hook 'before-save-hook 'time-stamp)
  (setq time-stamp-active t)
  (setq time-stamp-start "[lL]ast[ -][uU]pdate:<")
  ;;西暦-月-日@時刻(24時間表示)JST(タイムゾーン) by user
  (setq time-stamp-format "%04y-%02m-%02d@%02H:%02M%Z by %u")
  (setq time-stamp-end ">")
  (setq time-stamp-line-limit 10)
  )

;; ;;<文字コ-ド表示>
;;モードラインの文字エンコーディング表示をわかりやすくする
;;https://qiita.com/kai2nenobu/items/ddf94c0e5a36919bc6db
(leaf cl-lib
  :doc "Common Lisp extensions for Emacs"
  :tag "builtin"
  :added "2020-04-29"
  :config
  ;; 改行文字の文字列表現
(set 'eol-mnemonic-dos "(CRLF)")
(set 'eol-mnemonic-unix "(LF)")
(set 'eol-mnemonic-mac "(CR)")
(set 'eol-mnemonic-undecided "(NON)")

;; 文字エンコーディングの文字列表現
(defun my-coding-system-name-mnemonic (coding-system)
  (let* ((base (coding-system-base coding-system))
         (name (symbol-name base)))
    (cond ((string-prefix-p "utf-8" name) "U8")
          ((string-prefix-p "utf-16" name) "U16")
          ((string-prefix-p "utf-7" name) "U7")
          ((string-prefix-p "japanese-shift-jis" name) "SJIS")
          ((string-match "cp\\([0-9]+\\)" name) (match-string 1 name))
          ((string-match "japanese-iso-8bit" name) "EUC")
          (t "???")
          )))

(defun my-coding-system-bom-mnemonic (coding-system)
  (let ((name (symbol-name coding-system)))
    (cond ((string-match "be-with-signature" name) "[BE]")
          ((string-match "le-with-signature" name) "[LE]")
          ((string-match "-with-signature" name) "[BOM]")
          (t ""))))

(defun my-buffer-coding-system-mnemonic ()
  "Return a mnemonic for `buffer-file-coding-system'."
  (let* ((code buffer-file-coding-system)
         (name (my-coding-system-name-mnemonic code))
         (bom (my-coding-system-bom-mnemonic code)))
    (format "%s%s" name bom)))

;; `mode-line-mule-info' の文字エンコーディングの文字列表現を差し替える
(setq-default mode-line-mule-info
              (cl-substitute '(:eval (my-buffer-coding-system-mnemonic))
                             "%z" mode-line-mule-info :test 'equal))
)
;; ;;</文字コ-ド表示>

;; Prevent Inserting custom-variables by system
(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :added "2020-04-26"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(provide 'init)
;; Local Variables:
;; indent-tabs-mode: nil
;; End:


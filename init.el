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
  :bind
  ("C-t" . other-window)
  :init
    (set-language-environment "Japanese") ; 言語環境を"japanese"に
    (prefer-coding-system 'utf-8)
;;    (define-key global-map (kbd "C-t") 'other-window) ; ウィンドウ切り替え
    (setq-default indent-tabs-mode nil)
    (setq initial-frame-alist
          '((top . 80) (left . 60) (width . 160) (height . 40)))
    (set-face-attribute 'default nil :family "Ricty Discord" :height 140)
    (setq frame-title-format "%f")
  :custom
  `((tool-bar-mode . nil)
    (inhibit-startup-message . t) ;; スタートメニュー消す
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
;  :req "ccc-1.43" "cdb-20141201.754"
  :require skk-study
  :added "2020-04-26"
  :ensure t
;  :after ccc cdb
  :bind
   (("C-\\" . skk-mode))
   ;;("\C-x\C-j" . skk-mode))
   :init
   (setq skk-jisyo-code 'utf-8)
   (setq skk-user-directory "~/google/CorvusSKK/")
   (setq skk-init-file "~/google/CorvusSKK/init")
   (setq skk-jisyo "~/google/CorvusSKK/userdict.utf8")
   (setq skk-large-jisyo "~/google/CorvusSKK/SKK-JISYO.utf8")
   (setq default-input-method "japanese-skk")
   )

(leaf recentf-ext
 :doc "Recentf extensions"
 :tag "files" "convenience"
 :added "2020-04-27"
 :url "http://www.emacswiki.org/cgi-bin/wiki/download/recentf-ext.el"
 :ensure t
 ;; :init
 ;; (defun my/ido-recentf ()
 ;; (interactive)
 ;; (find-file (ido-completing-read "Find recent file: " recentf-list)))
;; :bind
;; ("C-x C-r" . counsel-recentf)
;; ("C-x C-r" . recentf-open-files)
 :config
 (recentf-mode t)
 (setq recentf-max-saved-items 200)
 (setq recentf-save-file "~/.emacs.d/recentf")
 (setq recentf-auto-cleanup 'never)
 ;; .recentf自体は含まない
 (setq recentf-exclude '("recentf"))
 (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
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

;; <ido>
(leaf ido
  :doc "interactively do things with buffers and files"
  :tag "builtin"
  :added "2020-05-02"
  :bind
  ("C-x C-f" . ido-find-file)
  ;;  ("C-x C-r" . recentf-list)
  ("C-x C-d" . ido-dired)
  ("C-x b" . ido-switch-buffer)
  ("C-x C-b" . ido-switch-buffer)
  :config
  (ido-mode t)
  (ido-everywhere t)
;;  (ido-ubiquitous-mode t)
  ;; あいまい検索
  (setq ido-enable-flex-matching t)
  )

(leaf amx
  :doc "Alternative M-x with extra features."
  :req "emacs-24.4" "s-0"
  :tag "usability" "convenience" "emacs>=24.4"
  :added "2020-05-02"
  :url "http://github.com/DarwinAwardWinner/amx/"
  :emacs>= 24.4
  :ensure t
  :bind
  ("M-x" . amx)
  :config
  (amx-mode t)
  )

(leaf ido-completing-read+
  :doc "A completing-read-function using ido"
  :req "emacs-24.4" "seq-0.5" "cl-lib-0.5" "memoize-1.1"
  :tag "convenience" "completion" "ido" "emacs>=24.4"
  :added "2020-05-02"
  :url "https://github.com/DarwinAwardWinner/ido-completing-read-plus"
  :emacs>= 24.4
  :ensure t
  :after memoize
  :config
  (ido-ubiquitous-mode t)
  )

(leaf ido-yes-or-no
  :doc "Use Ido to answer yes-or-no questions"
  :req "ido-completing-read+-0"
  :tag "ido" "completion" "convenience"
  :added "2020-05-02"
  :url "https://github.com/DarwinAwardWinner/ido-yes-or-no"
  :ensure t
  :after ido-completing-read+
  :config
  (ido-yes-or-no-mode t)
  )

(leaf *Ido-recentf-open
  :preface
  (defun ido-recentf-open ()
    (interactive)
    (find-file (ido-completing-read "Find recent file: " recentf-list)))
  :bind ("C-x C-r" . ido-recentf-open)
  )

(leaf ido-vertical-mode
  :doc "Makes ido-mode display vertically."
  :tag "convenience"
  :added "2020-05-02"
  :url "https://github.com/creichert/ido-vertical-mode.el"
  :ensure t
  :config
  (ido-vertical-mode t)
  ;; C-n/C-pで候補選択する
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  )
(leaf flx-ido
  :doc "flx integration for ido"
  :req "flx-0.1" "cl-lib-0.3"
  :added "2020-05-02"
  :url "https://github.com/lewang/flx"
  :ensure t
  :after flx
  :config
  (flx-ido-mode 1)
  :custom
  `((flx-ido-use-faces . t)
    (flx-ido-threshold . 10000))
  )

(leaf ido-flex-with-migemo
  :doc "use ido with flex and migemo"
  :req "flx-ido-0.6.1" "migemo-1.9.1" "emacs-24.4"
  :tag "matching" "emacs>=24.4"
  :added "2020-05-02"
  :url "https://github.com/ROCKTAKEY/ido-flex-with-migemo"
  :emacs>= 24.4
  :ensure t
  :after flx-ido migemo
  :config
  (ido-flex-with-migemo-mode . t)
  )
;;</ido>


(leaf plantuml-mode
  :doc "Major mode for PlantUML"
  :req "dash-2.0.0" "emacs-25.0"
  :tag "ascii" "plantuml" "uml" "emacs>=25.0"
  :added "2020-05-02"
  :emacs>= 25.0
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\.pu$" . plantuml-mode))
  (setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
  (setq plantuml-default-exec-mode 'jar)
;; javaにオプションを渡したい場合はここにかく
;(setq plantuml-java-options "")
;; plantumlのプレビューをsvg, pngにしたい場合はここをコメントイン
;; デフォルトでアスキーアート
;(setq plantuml-output-type "utxt")
  ;; 日本語を含むUMLを書く場合はUTF-8を指定
  (setq plantuml-options "-charset UTF-8")
  )

;; ;;<flycheck>
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

(leaf flyspell
  :doc "On-the-fly spell checker"
  :tag "builtin"
  :added "2020-05-02"
  :hook ((prog-mode . flyspell-prog-mode)    ;; flyspell-prog-modeはコメント領域だけ
         (yatex-mode . flyspell-mode)
         (org-mode . flyspell-mode)
         (text-mode . flyspell-mode))
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


;; ;;<ivy/counsel>
;; (leaf ivy
;;   :doc "Incremental Vertical completYon"
;;   :req "emacs-24.5"
;;   :tag "matching" "emacs>=24.5"
;;   :added "2020-04-27"
;;   :url "https://github.com/abo-abo/swiper"
;;   :emacs>= 24.5
;;   :ensure t
;;   :config
;;   (ivy-mode 1)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq enable-recursive-minibuffers t)
;; ;;  (setq ivy-height 20) ;; minibufferのサイズをかくだい
;;   (setq ivy-extra-directories nil)
;;   (setq ivy-re-builders-alist
;;         '((t . ivy--regex-plus)
;;           (swiper . ivy--regex-plus)))
;;   (setq ivy-use-virtual-buffers t)
;;   )

;; (leaf swiper
;;   :doc "Isearch with an overview. Oh, man!"
;;   :req "emacs-24.5" "ivy-0.13.0"
;;   :tag "matching" "emacs>=24.5"
;;   :added "2020-04-27"
;;   :url "https://github.com/abo-abo/swiper"
;;   :emacs>= 24.5
;;   :ensure t
;;   :after ivy
;;   :bind
;;   ("C-s" . isearch-forward-or-swiper)
;;   :config
;;   (defun isearch-forward-or-swiper (use-swiper)
;;     (interactive "p")
;;     ;; (interactive "P") ;; 大文字のPだと，C-u C-sでないと効かない
;;     (let (current-prefix-arg)
;;       (call-interactively (if use-swiper 'swiper 'isearch-forward))))
;;   )

;; (leaf counsel
;;   :doc "Various completion functions using Ivy"
;;   :req "emacs-24.5" "swiper-0.13.0"
;;   :tag "tools" "matching" "convenience" "emacs>=24.5"
;;   :added "2020-04-27"
;;   :url "https://github.com/abo-abo/swiper"
;;   :emacs>= 24.5
;;   :ensure t
;;   :after swiper
;;   :bind
;;   ("M-x" . counsel-M-x)
;;   ("M-y" . counsel-yank-pop)
;;   ("C-x C-r" . counsel-recentf)
;;   ("C-x C-b" . counsel-ibuffer)
;;   ("C-c g" . counsel-git)
;;   ("C-x C-f" . counsel-find-file)
;;   :config
;;   (counsel-mode 1)
;; ;;  (setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
;;   )

;; (leaf avy-migemo
;;   :doc "avy with migemo"
;;   :req "emacs-24.4" "avy-0.4.0" "migemo-1.9"
;;   :tag "migemo" "avy" "emacs>=24.4"
;;   :added "2020-04-27"
;;   :url "https://github.com/momomo5717/avy-migemo"
;;   :emacs>= 24.4
;;   :ensure t
;;   :after avy migemo
;;   :require "avy-migemo-e.g.swiper"
;;   :bind
;;   ("C-M-;" . avy-migemo-goto-char-timer)
;;   :config
;;   (avy-migemo-mode . t)
;;   (setq avy-timeout-seconds nil)
;;   (require 'avy-migemo-e.g.swiper)
;;   )
;; ;; </ivy/counsel>

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

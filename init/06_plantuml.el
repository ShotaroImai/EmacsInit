(straight-use-package 'plantuml-mode)
(straight-use-package 'flycheck-plantuml)

;;;;;;;(setq plantuml-default-exec-mode 'executable)
;; .pu拡張子のファイルをplantuml-modeで開く
(add-to-list 'auto-mode-alist '("\.pu$" . plantuml-mode))
;; あなたのplantuml.jarファイルの絶対パスをかく
(setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
;; javaにオプションを渡したい場合はここにかく
;(setq plantuml-java-options "")
;; plantumlのプレビューをsvg, pngにしたい場合はここをコメントイン
;; デフォルトでアスキーアート
;(setq plantuml-output-type "utxt")
;; 日本語を含むUMLを書く場合はUTF-8を指定
(setq plantuml-options "-charset UTF-8")
;; ;; plantuml-modeの時にC-c C-sでplantuml-save-png関数を実行
;; (add-hook 'plantuml-mode-hook
;; (lambda () (local-set-key (kbd "C-c C-s") 'plantuml-save-png)))

;; ;; もしも.puファイルを保存した時にpngファイルを保存したい場合はこちらをコメントイン
;; ;; (add-hook ‘plantuml-mode-hook
;; ;; (lambda () (add-hook ‘after-save-hook ‘plantuml-save-png)))

;; ;; plantumlをpngで保存する関数
;; (defun plantuml-save-png ()
;; (interactive)
;; (when (buffer-modified-p)
;; (map-y-or-n-p "Save this buffer before executing PlantUML?"
;; 'save-buffer (list (current-buffer))))
;; (let ((code (buffer-string))
;; out-file
;; cmd)
;; (when (string-match "^\\s-*@startuml\\s-+\\(\\S-+\\)\\s*$" code)
;; (setq out-file (match-string 1 code)))
;; (setq cmd (concat
;; "java -Djava.awt.headless=true -jar " plantuml-java-options " "
;; (shell-quote-argument plantuml-jar-path) " "
;; (and out-file (concat "-t" (file-name-extension out-file))) " "
;; plantuml-options " "
;; (buffer-file-name)))
;; (message cmd)
;; (call-process-shell-command cmd nil 0)))

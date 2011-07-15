;;; php-shell.el --- Uruchom interpreter php

;; Author: Kamil Szymczyk <kaszymczyk@gmail.com>

;; Przykład użycia
;; Do .emacs dodaj (load-file "[sciezka_dostepu]/php-shell.el")

(require 'comint)

(defun php-shell ()
  "Runs php interpreter"
  (interactive)
  (apply 'make-comint "php" "php" nil '("-a"))
  (delete-other-windows)
  (switch-to-buffer-other-window "*php*")
  (other-window -1))
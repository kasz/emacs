(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require 'python-mode)
(add-hook 'python-mode-hook
      (lambda ()
	(set-variable 'py-indent-offset 4)
	;(set-variable 'py-smart-indentation nil)
	(set-variable 'indent-tabs-mode nil)
	(define-key py-mode-map (kbd "RET") 'newline-and-indent)
	;(define-key py-mode-map [tab] 'yas/expand)
	;(setq yas/after-exit-snippet-hook 'indent-according-to-mode)
	;; (smart-operator-mode-on)
	))
;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wyłączam bo przez to ac wogóle nie działa
;; (defun prefix-list-elements (list prefix)
;;   (let (value)
;;     (nreverse
;;      (dolist (element list value)
;;       (setq value (cons (format "%s%s" prefix element) value))))))
;; (defvar ac-source-rope
;;   '((candidates
;;      . (lambda ()
;;          (prefix-list-elements (rope-completions) ac-target))))
;;   "Source for Rope")
;; (defun ac-python-find ()
;;   "Python `ac-find-function'."
;;   (require 'thingatpt)
;;   (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;     (if (null symbol)
;;         (if (string= "." (buffer-substring (- (point) 1) (point)))
;;             (point)
;;           nil)
;;       symbol)))
;; (defun ac-python-candidate ()
;;   "Python `ac-candidates-function'"
;;   (let (candidates)
;;     (dolist (source ac-sources)
;;       (if (symbolp source)
;;           (setq source (symbol-value source)))
;;       (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;              (requires (cdr-safe (assq 'requires source)))
;;              cand)
;;         (if (or (null requires)
;;                 (>= (length ac-target) requires))
;;             (setq cand
;;                   (delq nil
;;                         (mapcar (lambda (candidate)
;;                                   (propertize candidate 'source source))
;;                                 (funcall (cdr (assq 'candidates source)))))))
;;         (if (and (> ac-limit 1)
;;                  (> (length cand) ac-limit))
;;             (setcdr (nthcdr (1- ac-limit) cand) nil))
;;         (setq candidates (append candidates cand))))
;;     (delete-dups candidates)))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;                  (auto-complete-mode 1)
;;                  (set (make-local-variable 'ac-sources)
;;                       (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
;;                  (set (make-local-variable 'ac-find-function) 'ac-python-find)
;;                  (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;;                  (set (make-local-variable 'ac-auto-start) nil)))
;; ;;Ryan's python specific tab completion
;; (defun ryan-python-tab ()
;;   ; Try the following:
;;   ; 1) Do a yasnippet expansion
;;   ; 2) Do a Rope code completion
;;   ; 3) Do an indent
;;   (interactive)
;;   (if (eql (ac-start) 0)
;;       (indent-for-tab-command)))
;; (defadvice ac-start (before advice-turn-on-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) t))
;; (defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) nil))
;; (define-key py-mode-map "\t" 'ryan-python-tab)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; End Auto Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto Syntax Error Hightlight
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))
(add-hook 'find-file-hook 'flymake-find-file-hook)
(provide 'init_python)


;; to moje - kasz
;; ipython
(require 'ipython)
(setq py-python-command-args '( "--colors" "Linux"))

;; wykorzystanie anything do autocomplete
(require 'anything-ipython)
(add-hook 'python-mode-hook #'(lambda ()
                                (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
(add-hook 'ipython-shell-hook #'(lambda ()
                                  (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))

;; przeklejony kod mający zapewnić autocomplete w ipython
(defun dss-ipython-completion-candidate (&optional use-ido)
  "This is a hacked version of ipython-complete from ipython.el,
    which can be used with either autocomplete-mode or ido.

    It mostly works but there are a few bugs that need resolving...


"
  (let* ((ugly-return nil)
         (sep ";")
         (python-process (or (get-buffer-process (current-buffer))
                                        ;XXX hack for .py buffers
                             (get-process py-which-bufname)))
         (beg (save-excursion (skip-chars-backward "a-z0-9A-Z_." (point-at-bol))
                               (point)))
         (end (point))
         (pattern (buffer-substring-no-properties beg end))

         (completions nil)
         (completion nil)
         (comint-preoutput-filter-functions
          (append comint-preoutput-filter-functions
                  '(ansi-color-filter-apply
                    (lambda (string)
                      (setq ugly-return (concat ugly-return string))
                      "")))))

    (message pattern)
    (process-send-string python-process
                         (format ipython-completion-command-string pattern))
    (accept-process-output python-process)
    (setq completions
          (split-string (substring ugly-return 0 (position ?\n ugly-return)) sep))

    (setq completions (if (string-match "\\." pattern)
                          (mapcar
                             (lambda (completion)
                               (car (last (cdr (split-string completion "\\.")))))
                             completions)
                        completions))
    (if use-ido
        (let* ((prefix-beg (if (string-match "\\." pattern)
                               (save-excursion (skip-chars-backward "a-z0-9A-Z_" (point-at-bol))
                                               (point))
                             beg))
               (prefix (buffer-substring-no-properties prefix-beg end))
               (choice (if (<= (length completions) 1)
                           (car completions)
                         (ido-completing-read "Choice:" completions nil nil prefix nil prefix)))
               )
          (if (and choice (not (string= pattern choice)))
              (progn
                (message "%s %s %s %s" prefix prefix-beg beg (point-at-bol))
                (delete-region prefix-beg end)
                (insert choice))))
      (progn
        ;(message "not using ido")
        completions))))


(defun dss/ido-ipython-complete ()
  (interactive)
  (dss-ipython-completion-candidate t))

(ac-define-source dss-ipy
  '((candidates . dss-ipython-completion-candidate)
    (requires . 0)
    (symbol . "f")))

(ac-define-source dss-ipy-dot
  '((candidates . dss-ipython-completion-candidate)
    (prefix . c-dot)
    (requires . 0)
    (symbol . "f")))

(add-hook 'ipython-shell-hook 'auto-complete-mode)
(add-hook 'py-shell-hook 'auto-complete-mode)

;; to było w definicji powższej funkcji, ale podejrzewam, że powinno być tutaj
;; (albo można to wogóle usunąć - sprawdzić później)
(defun dss/start-ipy-complete ()
  (interactive)
  (setq ac-sources '(ac-source-dss-ipy-dot
                     ac-source-dss-ipy
                     ac-source-filename)))
(add-hook 'ipython-shell-hook 'dss/start-ipy-complete)
(add-hook 'py-shell-hook 'dss/start-ipy-complete)

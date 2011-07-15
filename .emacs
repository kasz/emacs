;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; kasz .emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;; 0.Ważne ustawienie ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(load "~/elisp/nxhtml/autostart.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. USTAWIENIA LOKLALNE ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(dired-dwim-target t)
 '(dired-listing-switches "-alh")
 '(ibuffer-saved-filters (quote (("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(ibuffer-truncate-lines t)
 '(inferior-lisp-program "clisp")
 '(snipplr-user-key "4e3147108052bbbb0860")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(w32shell-cygwin-bin "C:\\cygwin\\bin"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ffffff" :foreground "#141312" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 103 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1.1. USTAWIENIE SERWERA DLA LINUXA (WINDOWS ROBI TO Z AUTOMATU) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond
 ((string-match "linux" (emacs-version))
  (server-start)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. USTAWIENIE KATALOGU Z ROSZERZENIAMI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/elisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. ŁADOWANE MODY GŁÓWNE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; php-mode (zastąpione wersją z nxhtml)
;; (autoload 'php-mode "php-mode" "Major mode for editing php code." t)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; ustawia nxml-mode jako standardowy zamiast xml-mode
(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))

;; ładowanie pymacsa
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (eval-after-load "pymacs"
;;   '(add-to-list 'pymacs-load-path "~/elisp/pymacs"))

;; ładowanie yasnippet
(add-to-list 'load-path
              "~/elisp/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/elisp/yasnippet/snippets")

;; ladowanie yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; ladowanie js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; ladowanie csv-mode
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)

;; ladowanie psvn
(require 'psvn)

;; uruchamianie auto-completion mode
;; (require 'auto-complete)
;; (global-auto-complete-mode t)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/elisp//ac-dict")
(ac-config-default)

;; ładowanie gebena (debugger od php)
(autoload 'geben "geben" "PHP Debugger on Emacs" t)

;; ładowanie modułu integrującego emacsa z mozrepl
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'js2-mode-hook 'js2-custom-setup)
(defun js2-custom-setup ()
  (moz-minor-mode 1))

;; dodawanie anything
(add-to-list 'load-path "~/elisp/anything-config")
(require 'anything-config)
(require 'anything-match-plugin)
;; (require 'anything-startup)

;; ładowanie modułu umożliwiającego komunikację z snipplr (trzeba go trochę zmoderniować)
;;(require 'snipplr)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3.1. ŁADOWANE MODY GŁÓWNE SPECYFICZNE DLA LINUXA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond
 ((string-match "linux" (emacs-version))

  ;; loadwanie cedeta
  ;; (load-file "~/elisp/cedet.el")
  (global-ede-mode 1)
  ;; (require 'semantic/sb)
  ;; (require 'cedet)
  (semantic-mode 1)
  
  ;; ładowanie konfiguracji pythona
  (load-file "~/elisp/init_python.el")

  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3.2. ŁADOWANE MODY GŁÓWNE SPECYFICZNE DLA WINDOWSA ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond
 ((string-match "mingw" (emacs-version))
  (setq ahk-syntax-directory "C:/Program Files (x86)/AutoHotkey/Extras/Editors/Syntax/")
  (add-to-list 'auto-mode-alist '("\\.ahk$" . ahk-mode))
  (autoload 'ahk-mode "ahk-mode")
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4. ŁADOWANE MODY PODRZĘDNE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; zalaczanie modulu ido (http://www.cua.dk/ido.html)
(require 'ido)
(ido-mode t)
;; (ido-everywhere 1)
;; (setq ido-enable-flex-matching t)


;; uruchomienie customizacji nazw buforów
(require 'uniquify)

;; dodanie funkcji umożliwiającej wyświetlanie listy wolnych skrótów klawiszowych
(require 'unbound)

;; zalaczenie templatow c-c++
;; (require 'tempo-c-cpp)

;; wyświetlanie numeru linii
(line-number-mode 1)

;; wyświetlanie numeru kolumny
(column-number-mode 1)

;; wyświetlanie wielkości pliku
(size-indication-mode 1)

;; odpalanie moda pokazującego pozycje nawiasów
(show-paren-mode 1)

;; konfiguracja aspella
(setq ispell-program-name "aspell") ;; jeżeli jest zainstalowany aspell
(setq ispell-dictionary "polish")   ;; tu konfiguracja dt. aspella aby korzystał z słownika polskiego

;; zapisywanie sesji emacsowej (http://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html)
(desktop-save-mode 1)

;; ===== Set the highlight current line minor mode =====

;; In every buffer, the line which contains the cursor will be fully
;; highlighted
(global-hl-line-mode 1)

; display line numbers in margin (fringe). Emacs 23 only.
(global-linum-mode 1) ; always show line numbers

;; dodanie menu ostatnio otworzonych plików
(recentf-mode 1)

;; dodanie autouzupełniania wprowadzanych plików
(icomplete-mode 1)

;; domyślne odpalanie el-doc dla elispa
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
	     (turn-on-eldoc-mode)))

;; ładowanie modułu umożliwiającego używanie el-doc z c
(load "c-eldoc")
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;; i dla php
;; (require 'php-doc)

;; dorzucenie pliku z abbrevami
(load "my-emacs-abbrev")

(require 'list-register)

;; moduł od poświetlania zagnieżdżania nawiasów, przyda się do Lispa
(require 'rainbow-delimiters)
(add-hook 'php-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)

;; (require 'zenburn-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4.1. ŁADOWANE MODY PODRZĘDNE SPECYFICZNE DLA WERSJI 23.2 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ustawienie tak, żeby zmienne napisane w camelCase traktował jako osobne
; słowa, tak jak w przypadku podkreślników
;; TODO: zmienić - należy wziąć pod uwagę, że dla innych systemów, ten string
;; może mieć inną liczbę elementów, lepiej po prostu przeszukiwać string i sprawdzać
;; czy zawiera fragment "23.2"
;; TODO: wyciągnąć funkcję pomocniczą sprawdzającą wersję
;; TODO: przerobić ją na coś w stylu (if (and (>= emacs-major-version 23) (>= emacs-minor-version 2)))
(cond
     ((string-match "23.2" (nth 2 (split-string (emacs-version) " " t)))
      (global-subword-mode 1) ; 1 for on, 0 for off
      ;; dodanie podświetlania nazwy aktualnej funkcji (wymaga cedeta)
      (global-semantic-highlight-func-mode 1)
      (global-semantic-decoration-mode 1)
      (add-hook 'dired-load-hook
		(function (lambda () (load "dired-x"))))
     )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4.2. ŁADOWANE MODY PODRZĘDNE SPECYFICZNE DLA WINDOWSA

; ustawienie lokalizacji aspella
(cond
 ((string-match "nt" (emacs-version))

  (setq-default ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell.exe")

  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. USTAWIENIA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; odblokwanie wyłączonych funkcji (emacs sam to dodał)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; odpala wyświetlanie czasu i ustawia format 24h
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;; Answer y or n instead of yes or no at minibar prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

; poniższy kod służy do ustawinia "autoenterowania" linii po osiągnięciu pewnej długośći linii
; TODO: dowiedzieć się jak ustawić to dla konkrtengeo modułu (konkrtenie text i fundamental)
;; ========== Set the fill column ==========

;; Enable backup files.
(setq-default fill-column 78)

;; ===== Turn on Auto Fill mode automatically in all modes =====

;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.

;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.
;(setq auto-fill-mode 1)

;; ustawienie ssh jako defaultowej metody połączenia przez trampa
(setq tramp-default-method "ssh")

; zmienia standardowe zachowanie redo http://www.emacswiki.org/emacs/RedoMode
(require 'redo)
(global-set-key [(meta backspace)] 'undo)
(global-set-key [(meta shift backspace)] 'redo)

; usuwa pasek narzedziowy (i tak nic z niego nie uzywalem)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; zmienia sposób nazewnictwa buforów diredowych - teraz mają końcówkę /dired
(add-hook 'dired-mode-hook 'ensure-buffer-name-ends-in-slash)
(defun ensure-buffer-name-ends-in-slash ()
  "change buffer name to end with slash-dired"
  (let ((name (buffer-name)))
    (if (not (string-match " /dired$" name))
        (rename-buffer (concat name " /dired") t))))

;; żeby speedbar widział pliki php
(eval-after-load "speedbar" '(speedbar-add-supported-extension ".php"))
(eval-after-load "speedbar" '(speedbar-add-supported-extension ".phtml"))
(eval-after-load "speedbar" '(speedbar-add-supported-extension ".tpl"))
(eval-after-load "speedbar" '(speedbar-add-supported-extension ".xml"))

;; ustawienia flymake'a
;; wyświetlanie błędu w mini-buforze
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'my-flymake-show-help)

;; funkcja tworząca plik tymczasowy _flymake w /tmp zamiast w tym samym katalogu
(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

(defun flymake-php-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local-file "-l"))))

;; f5 odświeża bufor
(defun refresh-buffer ()
  "Refreshes current buffer"
  (interactive)
  (revert-buffer t t t))

(global-set-key [C-f5] 'refresh-buffer)

;; f6 sprawdza błąd przy danej linijce jeśli jest flymake
(global-set-key [f6] 'flymake-display-err-menu-for-current-line)

;; f7 sprawdza region pod względem ortograficznym
(global-set-key [f7] 'flyspell-region)

;; f8 zakopuje bufor
(global-set-key [f8] 'bury-buffer)

;; f9 kompilacja
(global-set-key [f9] 'compile)

;; f11 włącza php-mode
(global-set-key [f11] 'php-mode)

;; f12 włącza php-mode
(global-set-key [f12] 'nxml-mode)

;; jeśli dobrze pamiętam to to miało umożliwiać normalne wywołanie tabulacji,
;; ale okazało się zbędne
(global-set-key [C-tab] 'indent-for-tab-command)

; ustawia alias (xpaste) dla x-clipboard-yank
(defalias 'xpaste 'x-clipboard-yank)
(defalias 'xcopy 'clipboard-kill-ring-save)

;; ustawienie automatycznego dodawnia time stampa dla org-mode (jeszcze nie wiem jak to zapisać)

;; ustawienie globalnego skrótu do kopiowania linku do danego punktu, do późniejszego wykorzystania w org-mode
(define-key global-map "\C-cl" 'org-store-link)

;; ustawienie zapamiętywania do zdefiniowanego pliku danego fragmentu tekstu (standardowow ~/.notes)
(define-key global-map "\C-cr" 'org-remember)

;; ustawienie ibuffera zamiast list-buffers (zamienione na ustawienie ibuffera z filtrowaniem grup po modzie głównym
;; (defalias 'list-buffers 'ibuffer)
(defun ibuffer-filtered () (interactive) (ibuffer) (ibuffer-set-filter-groups-by-mode))
(defalias 'list-buffers 'ibuffer-filtered)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Konfiguracja org-timer pod Pomodoro ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'org-modules 'org-timer)

;; Set a default value for the timer, for example :
(setq org-timer-default-timer 25)

;; Modify the org-clock-in so that a timer is started with the default
;; value except if a timer is already started :

(add-hook 'org-clock-in-hook '(lambda () 
      (if (not org-timer-current-timer) 
      (org-timer-set-timer '(16)))))

;; ustawianie zapisywania miejsca w pliku między sesjami
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Konfiguracja project-root.el ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'project-root)
(setq project-roots
      `(("Socialengine project"
         :root-contains-files ("socialengine.project")
	 :default-command shell
         :filename-regex ,(regexify-ext-list '(php html tpl css js))
         :exclude-paths ("temporary" "img" "install"))
	("Magento project"
	 :root-contains-files ("magento.project")
	 :default-command shell
         :filename-regex ,(regexify-ext-list '(php html css js xml phtml))
         :exclude-paths ("var" "media" "downloader"))))

;; (global-set-key (kbd "C-c p f") 'project-root-find-file) ; nie działa
(global-set-key (kbd "C-c p g") 'project-root-grep) ;
(global-set-key (kbd "C-c p a") 'project-root-ack)
(global-set-key (kbd "C-c p d") 'project-root-goto-root)
(global-set-key (kbd "C-c p p") 'project-root-run-default-command)
(global-set-key (kbd "C-c p l") 'project-root-browse-seen-projects)

(global-set-key (kbd "C-c p M-x")
                'project-root-execute-extended-command)

;; wywołuje listowanie svna, bądź gita
(global-set-key
 (kbd "C-c p v")
 (lambda ()
   (interactive)
   (with-project-root
       (let ((root (cdr project-details)))
         (cond
           ((file-exists-p ".svn")
            (svn-status root))
           ((file-exists-p ".git")
            (git-status root))
           (t
            (vc-directory root nil)))))))

;; zastępstwo nie działającej funkcji od wyszuszukiwania - zmiast tego używa find-name-dired
(global-set-key
 (kbd "C-c p f")
 (lambda ()
   (interactive)
   (with-project-root
       (find-name-dired default-directory (read-string "Find-name (filename wildcard): ")))))

;; skrót do wywoływania rgrepa z katalogu głównego projektu
(global-set-key
 (kbd "C-c p r")
 (lambda ()
   (interactive)
   (with-project-root
       (rgrep (read-string "Search for: ") (read-string "Search in files: ") default-directory nil))))


;; skrót do wywoływania funkcji usuwającej pliki flymake
(global-set-key
 (kbd "C-c p m")
 (lambda ()
   (interactive)
   (with-project-root
       (start-process-shell-command "delete-flymake-files" "*delete-flymake-files*" "./delete_fmake_files.sh")
       (minibuffer-message "Rozpoczęto usuwanie plików flymake")
       ;; (shell-command "./delete_fmake_files.sh")
     )))

(global-set-key
 (kbd "C-c p !")
 (lambda ()
   (interactive)
   (with-project-root
       (shell-command (read-string "Shell command on project root: "))
     )))

;; emacsowy frontend dla paru funkcji zarządzających magento
(defun mage-cc ()
  (interactive)
  (with-project-root
      (shell-command "./clear_cache.sh")
      ))

(defun mage-create-module-withoute-route ()
  (interactive)
  (with-project-root
      (shell-command (concat "./create_module_withoute_route.sh " (read-string "Nazwa pakietu: ") " " (read-string "Nazwa modułu: ")))))

(defun mage-create-module ()
  (interactive)
  (with-project-root
      (shell-command (concat "./create_module.sh " (read-string "Nazwa pakietu: ") " " (read-string "Nazwa modułu: ")))))

(defun mage-add-model ()
  (interactive)
  (with-project-root
      (shell-command (concat "./add_model.py"
			     " -p " (read-string "Nazwa pakietu: ")
			     " -m " (read-string "Nazwa modułu: ")
			     " -t " (read-string "Nazwa tabeli: ")
			     " " (read-string "Nazwa modelu: ")))))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5.1. USTAWIENIA SPECYFICZNE DLA LINUXA ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; funkcja ustawiająca włączanie emacsa na cały ekran (tylko pod linuxem)
(cond
 ((string-match "linux" (emacs-version))

					; return a backup file path of a give file path
					; with full directory mirroring from a root dir
					; non-existant dir will be created
  (defun my-backup-file-name (fpath)
    "Return a new file path of a given file path. If the new path's directories does not exist, create them."
    (let (backup-root bpath)
      (setq backup-root "~/.emacs-backup")
      (setq bpath (concat backup-root fpath "~"))
      (make-directory (file-name-directory bpath) bpath)
      bpath
      )
    )
  (setq make-backup-file-name-function 'my-backup-file-name)


  ;; treść owej funkcji
  (defun toggle-fullscreen ()
    (interactive)
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
    )
  (toggle-fullscreen)
  ;; koniec treści
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6. USTAWIENIA MODUŁÓW ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; umożlwia wybieranie opcji modułu auto-complete za pomocą C-n i C-p 
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; zamienienie standardowych funkcji na wersje wykorzystujące anything
;; przydałby się jakiś inny skrót, ten jest zbyt przydatny i nie bardzo daje się
;; go w ten sposób zastąpić
;; (global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "M-s o") 'anything-occur)
(global-set-key (kbd "C-c SPC") 'anything-all-mark-rings)

;; hooki
(add-hook 'org-mode-hook 'flyspell-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 7. WŁASNE FUNKCJE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; zawiera funkcję uruchmiającą konsolę php w emacsie 
(load-file "~/elisp/php-shell.el")

;; Funkcja usuwająca procesy flymake
(defun delete-flymake-processes (number)
  "Deletes defined number of flymake processes"
  (let ((counter 1))
    (while (< counter (1+ number))
      (delete-process (concat "flymake-proc<" (int-to-string counter) ">"))
      (setq counter (1+ counter)))))

;; Funkcja zmieniające ustawienia kolorystki emacsa między jasną a ciemną
(defun toogle-color-theme ()
  "Toogles between white and black color themes"
  (interactive)
  (if (equal (frame-parameter (next-frame) 'background-color) "white")
    (set-black-color-theme)
    (set-white-color-theme)))

(defun set-black-color-theme ()
  "Sets black color theme"
  (interactive)
  (set-background-color "black")
  (set-foreground-color "white")
  (set-cursor-color "white"))

(defun set-white-color-theme ()
  "Sets white color theme"
  (interactive)
  (progn (set-background-color "white")
  	   (set-foreground-color "black")
  	   (set-cursor-color "black")))

;; nie działa
(defun skrzat-vpn ()
  "Starts connection to skrzat-vpn"
  (interactive)
  (start-process-shell-command "skrzat-vpn" "*skrzat-vpn*" "skrzat_vpn"))

;; nie działa
;; (defun refresh-other-buffer ()
;;   (interactive)
;;   (other-buffer)
;;   (refresh-buffer)
;;   (other-buffer))

; TODO: napisać funkcje w emacs lisp zmieniające formatowanie z camelCase na podkreślenia i odwrotnie
;       (ale najpierw sprawdzić czy ktoś już tego nie zrobił // zrobił, ale i tak napiszę własną)
; TODO: stworzyć funkcję wrzucajacą zawartość wybranego rejestru do schowka (kill-ringa)
;; TODO: napiszę funkcję dodającą wybrany rejestr do kill-ringa

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 8. WŁASNE MAKRA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; w python-mode praktycznie nie da się cofnąć linii na odpowiednią pozycję tabem (a M-m próbowałeś?)
(fset 'python-line-indent-macro
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 backspace 10] 0 "%d")) arg)))

;; makro, które komentuje linię i wstawia pod nią następną, taką samą
(fset 'duplicate-and-comment-macro
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217837 67108896 5 134217847 67108896 134217837 134217787 5 10 25] 0 "%d")) arg)))
(global-set-key (kbd "C-x C-k D") 'duplicate-and-comment-macro)

;; makro które likwiduje drugi bufor (głównie po to aby usuwać niepotrzebne uzupłenienia po tabie itp.)
(fset 'kill-other-buffer-macro
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 111 24 107 return 24 111] 0 "%d")) arg)))
(global-set-key (kbd "C-x C-k k") 'kill-other-buffer-macro)

(fset 'comment-php-macro
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([19 112 104 112 13 67108896 19 63 2 134217787 1 14] 0 "%d")) arg)))
(global-set-key (kbd "C-x C-k ;") 'comment-php-macro)

(fset 'refresh-other-buffer-macro
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 111 C-f5 24 111] 0 "%d")) arg)))

(global-set-key (kbd "C-x C-k r") 'refresh-other-buffer-macro)
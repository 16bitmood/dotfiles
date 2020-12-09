;;; mytheme-theme.el --- An Opinionated Xresources Theme
;;; Commentary:
;;; The main idea is to have a "cohesive" color scheme based on Xresources defined colors
;;; Code:

(defun mytheme--x-get (x)
    "Get color(x) from xrdb"
    (x-get-resource x ""))

(defun mytheme--hexcolor-to-int (c)
  (string-to-number (substring c 1) 16))

(defun lightendarkencolor (col amt)
    "Change col(#RRGGBB) Brightness by amt(Int)"
    (let* ((c (mytheme--hexcolor-to-int col))
        (r (+ amt (ash c -16)))
        (b (+ amt (logand (ash c -8) #x00FF)))
        (g (+ amt (logand c #x0000FF)))
        (total (logior g (ash b 8) (ash r 16))))
        (concat
            "#"
            (format "%x"
                (if (> total #xFFFFFF)
                    #xFFFFFF
                    (if (> #x000000 total)
                        #x000000
                        total))))))

;; Ex: (mytheme--lightendarkencolor (x-get-resource "foreground" "") -2)

(defun mytheme--height (multiplier)
    "Return the height as MULTIPLIER * variable-pitch height."
    (truncate (* 1.23 (* (face-attribute 'fixed-pitch :height nil 'default) multiplier))))

(deftheme mytheme "(I know, very original name)")

;; ----------------------------
;; -- Normal      Bright     --
;; ----------------------------
;; -- 0 Black      8 Black   --
;; -- 1 Red        9 Red     --
;; -- 2 Green     10 Green   --
;; -- 3 Yellow    11 Yellow  --
;; -- 4 Blue      12 Blue    --
;; -- 5 Magenta   13 Magenta --
;; -- 6 Cyan      14 Cyan    --
;; -- 7 White     15 White   --
;; ----------------------------
(defvar mytheme--style
  (if (>
       (mytheme--hexcolor-to-int (mytheme--x-get "foreground"))
       (mytheme--hexcolor-to-int (mytheme--x-get "background")))
      "dark"
      "light")
  "Color Scheme Style.")

(let* ((foreground     (mytheme--x-get "foreground"))
       (background     (mytheme--x-get "background"))
       (black          (mytheme--x-get "color0"))
       (red            (mytheme--x-get "color1"))
       (green          (mytheme--x-get "color2"))
       (yellow         (mytheme--x-get "color3"))
       (blue           (mytheme--x-get "color4"))
       (magenta        (mytheme--x-get "color5"))
       (cyan           (mytheme--x-get "color6"))
       (gray           (mytheme--x-get "color7"))
       (bright-gray    (mytheme--x-get "color8"))
       (bright-red     (mytheme--x-get "color9"))
       (bright-green   (mytheme--x-get "color10"))
       (bright-yellow  (mytheme--x-get "color11"))
       (bright-blue    (mytheme--x-get "color12"))
       (bright-magenta (mytheme--x-get "color13"))
       (bright-cyan    (mytheme--x-get "color14"))
       (bright-white   (mytheme--x-get "color15")))

    (custom-theme-set-faces 'mytheme
        ;; Basic Coloring
        '(button              ((t (:underline t))))
        `(link                ((t (:foreground ,yellow :underline t :weight bold))))
        `(link-visited        ((t (:foreground ,yellow :underline t :weight normal))))
        `(default             ((t (:foreground ,foreground :background ,background))))
        `(cursor              ((t (:foreground ,foreground :background ,foreground))))
        `(escape-glyph        ((t (:foreground ,yellow :bold t))))
        `(fringe              ((t (:foreground ,foreground :background ,background))))
        `(highlight           ((t (:background ,background))))
        `(success             ((t (:foreground ,green :weight bold))))
        `(warning             ((t (:foreground ,red :weight bold))))

        ;; Secondary Items

        `(minibuffer-prompt   ((t (:foreground ,yellow)))))
   ;; Scheme specific colors
    (if (string= mytheme--style "dark")
        (let* ((c-bg+1 (lightendarkencolor background 15))
               (c-bg+2 (lightendarkencolor background 30))
               (c-bg+3 (lightendarkencolor background 45))
               (c-bg+4 (lightendarkencolor background 60))
               (c-bg+5 (lightendarkencolor background 75))

               (c-fg-1 (lightendarkencolor foreground -15))
               (c-fg-2 (lightendarkencolor foreground -30))
               (c-fg-3 (lightendarkencolor foreground -45))
               (c-fg-4 (lightendarkencolor foreground -60))
               (c-fg-5 (lightendarkencolor foreground -75)))

        (custom-theme-set-faces 'mytheme

            `(menu           ((t (:foreground ,foreground :background ,c-bg+1))))

            ;; Header Line TODO: Fix This
            `(header-line    ((t (:foreground ,foreground
                                        :background ,background
                                        :box (:line-width -1 :style released-button)))))
            ;; Mode Line
            `(mode-line       ((t (:foreground ,green
                                    :background ,background
                                    :box (:line-width -1 :style released-button)))
                            (t :inverse-video t)))
            `(mode-line-inactive
                            ((t (:foreground ,green
                                    :background ,background
                                    :box (:line-width -1 :style released-button)))))

            `(mode-line-buffer-id ((t (:foreground ,yellow :weight bold))))

            ;; Secondary Items
            ;; `(region              ((t (:background ,blue))
            ;;             (t :inverse-video t)))
            ;; `(secondary-selection ((t (:background ,background))))
            ;; `(trailing-whitespace ((t (:background ,red))))
            ;; `(vertical-border     ((t (:foreground ,foreground))))

            ;; font lock
            `(font-lock-builtin-face              ((t (:foreground ,foreground :weight bold))))
            `(font-lock-comment-face              ((t (:foreground ,c-fg-5))))
            `(font-lock-comment-delimiter-face    ((t (:foreground ,c-fg-5))))
            `(font-lock-constant-face             ((t (:foreground ,green))))
            `(font-lock-doc-face                  ((t (:foreground ,magenta))))
            `(font-lock-function-name-face        ((t (:foreground ,cyan))))
            `(font-lock-keyword-face              ((t (:foreground ,yellow :weight bold))))
            `(font-lock-negation-char-face        ((t (:foreground ,yellow :weight bold))))
            `(font-lock-preprocessor-face         ((t (:foreground ,blue))))
            `(font-lock-regexp-grouping-construct ((t (:foreground ,yellow :weight bold))))
            `(font-lock-regexp-grouping-backslash ((t (:foreground ,green :weight bold))))
            `(font-lock-string-face               ((t (:foreground ,red))))
            `(font-lock-type-face                 ((t (:foreground ,blue))))
            `(font-lock-variable-name-face        ((t (:foreground ,red))))
            `(font-lock-warning-face              ((t (:foreground ,yellow :weight bold))))
            ;; `(c-annotation-face                   ((t (:inherit font-lock-constant-face))))

            ;; auto-complete
            `(ac-candidate-face ((t (:background ,foreground :foreground ,background))))
            `(ac-selection-face ((t (:background ,blue :foreground ,foreground))))
            `(popup-tip-face    ((t (:background ,yellow :foreground ,background))))
            `(popup-scroll-bar-foreground-face ((t (:background ,blue))))
            `(popup-scroll-bar-background-face ((t (:background ,background))))
            `(popup-isearch-match ((t (:background ,background :foreground ,foreground))))

            ;; company-mode
            `(company-tooltip ((t (:foreground ,foreground :background ,c-bg+3))))
            `(company-tooltip-selection ((t (:foreground ,c-bg+3 :background ,foreground))))
            `(company-tooltip-mouse ((t (:background ,background))))
            `(company-tooltip-common ((t (:foreground ,green))))
            `(company-tooltip-common-selection ((t (:foreground ,c-bg+3))))
            `(company-scrollbar-fg ((t (:background ,background))))
            `(company-scrollbar-bg ((t (:background ,background))))
            `(company-preview ((t (:background ,green))))
            `(company-preview-common ((t (:foreground ,green :background ,background))))

            ;; flycheck
            `(flycheck-error
                ((((supports :underline (:style wave)))
                (:underline (:style wave :color ,red) :inherit unspecified))
                (t (:foreground ,red :weight bold :underline t))))
            `(flycheck-warning
                ((((supports :underline (:style wave)))
                (:underline (:style wave :color ,yellow) :inherit unspecified))
                (t (:foreground ,yellow :weight bold :underline t))))
            `(flycheck-info
                ((((supports :underline (:style wave)))
                (:underline (:style wave :color ,cyan) :inherit unspecified))
                (t (:foreground ,cyan :weight bold :underline t))))
            `(flycheck-fringe-error ((t (:foreground ,red :weight bold))))
            `(flycheck-fringe-warning ((t (:foreground ,yellow :weight bold))))
            `(flycheck-fringe-info ((t (:foreground ,cyan :weight bold))))

            ;; org-mode
            `(org-agenda-date-today
                ((t (:foreground ,foreground :slant italic :weight bold))) t)
            `(org-agenda-structure
                ((t (:inherit font-lock-comment-face))))
            `(org-archived ((t (:foreground ,foreground :weight bold))))
            `(org-checkbox ((t (:background ,background :foreground ,foreground
                                            :box (:line-width 1 :style released-button)))))
            `(org-date ((t (:foreground ,blue :underline t))))
            `(org-deadline-announce ((t (:foreground ,red))))
            `(org-done ((t (:bold t :weight bold :foreground ,green))))
            `(org-formula ((t (:foreground ,yellow))))
            `(org-headline-done ((t (:foreground ,green))))
            `(org-hide ((t (:foreground ,background))))
            `(org-level-1 ((t (:foreground ,red))))
            `(org-level-2 ((t (:foreground ,green))))
            `(org-level-3 ((t (:foreground ,blue))))
            `(org-level-4 ((t (:foreground ,yellow))))
            `(org-level-5 ((t (:foreground ,cyan))))
            `(org-level-6 ((t (:foreground ,green))))
            `(org-level-7 ((t (:foreground ,red))))
            `(org-level-8 ((t (:foreground ,blue))))
            `(org-link ((t (:foreground ,yellow :underline t))))
            `(org-scheduled ((t (:foreground ,green))))
            `(org-scheduled-previously ((t (:foreground ,red))))
            `(org-scheduled-today ((t (:foreground ,blue))))
            `(org-sexp-date ((t (:foreground ,blue :underline t))))
            `(org-special-keyword ((t (:inherit font-lock-comment-face))))
            `(org-table ((t (:foreground ,green))))
            `(org-tag ((t (:bold t :weight bold))))
            `(org-time-grid ((t (:foreground ,red))))
            `(org-todo ((t (:bold t :foreground ,red :weight bold))))
            `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
            `(org-warning ((t (:bold t :foreground ,red :weight bold :underline nil))))
            `(org-column ((t (:background ,background))))
            `(org-column-title ((t (:background ,background :underline t :weight bold))))
            `(org-mode-line-clock ((t (:foreground ,foreground :background ,background))))
            `(org-mode-line-clock-overrun ((t (:foreground ,background :background ,red))))
            `(org-ellipsis ((t (:foreground ,yellow :underline t))))
            `(org-footnote ((t (:foreground ,cyan :underline t))))

            ;; Source Code in Org
            ;; `(org-block-background ((t (:background ,c-bg+2 :extend t)))) ;; :inherit fixed-pitch))))
            ;; `(org-code             ((t (:background ,c-bg+2 :extend t))))
            `(org-block-begin-line ((t (:foreground ,c-fg-5 :background ,background :extend t))))
            `(org-block-end-line   ((t (:foreground ,c-fg-5 :background ,background :extend t))))
            `(org-block            ((t (:background ,c-bg+1 :extend t))))


            ))

        (let* ((c-fg+1 (lightendarkencolor foreground 10))
               (c-fg+2 (lightendarkencolor foreground 20))
               (c-fg+3 (lightendarkencolor foreground 30))
               (c-fg+4 (lightendarkencolor foreground 40))
               (c-fg+5 (lightendarkencolor foreground 50))

               (c-bg-1 (lightendarkencolor background -10))
               (c-bg-2 (lightendarkencolor background -20))
               (c-bg-3 (lightendarkencolor background -30))
               (c-bg-4 (lightendarkencolor background -40))
               (c-bg-5 (lightendarkencolor background -50))))))

;; todo:
;; - Fringe try gray

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory
                (file-name-directory load-file-name))))

(provide-theme 'mytheme)

;;; mytheme-theme.el ends here

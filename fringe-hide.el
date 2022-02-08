;;; fringe-hide.el --- Hide fringe in buffer -*- lexical-binding: t -*-

;; Version: 1.0
;; Keywords: fringe, fringe-hide
;; Author: irek <mail@gumen.pl>
;; URL: https://github.com/ir33k/fringe-hide

;; This file is part of fringe-hide.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Hide left, right or both fringes in buffer.  Emacs already has
;; `fringe-mode' but it hides fringes on all windows in all frames.
;; Despite of simple local variables that can be used to change size
;; of fringes in given buffer I wasn't able to find any easy way to
;; set them because for new value to have effect other function has
;; to be called.  So there it is - yet another Emacs minor mode.

;;; Code:

(defconst fringe-hide-version "1.0" "Hide buffer fringe version string.")

(defgroup fringe-hide nil "Hide fringe in buffer."
  :prefix "fringe-hide-" :group 'environment :version "25")

(defun fringe-hide (action)
  "Hide left, right or both buffer fringes depending on ACTION value.
Depending on ACTION value margin might be added on left, right
or both buffer window edges to prevent text from being pixel
perfect blue to the window border.  For ACTION value:

* \"show\", nil or empty string - Show all fringes and remove margins.
* \"both\" - Hide both fringes and add 1 char of margin on both sides.
* \"left\" - Hide left fringe and add 1 char of margin on left side.
* \"right\" - Hide right fringe and add 1 char or margin on right side.
* \"both-margin\" - Hide both fringes and remove both margins.
* \"left-margin\" - Hide left fringe and remove left margin.
* \"right-margin\" - Hide right fringe and remove left margin."
  (interactive
   (list (completing-read "Hide buffer fringes: "
                          '("show" "both" "left" "right"
                            "both-margin" "left-margin" "right-margin")
                          nil t nil nil "")))
  (let* ((action (or action ""))        ; Supprot nil value
         (both-p   (string-match "^both" action))
         (margin-p (string-match "margin$" action))
         (left-p   (or both-p (string-match "^left" action)))
         (right-p  (or both-p (string-match "^right" action))))
    (setq left-fringe-width  (if left-p  0))
    (setq right-fringe-width (if right-p 0))
    (setq left-margin-width  (if (and (not margin-p) left-p)  1 0))
    (setq right-margin-width (if (and (not margin-p) right-p) 1 0)))
  ;; This function needs is required to call to apply fringes and
  ;; margins width changes.
  (set-window-buffer (get-buffer-window) (buffer-name)))

(define-minor-mode fringe-hide-mode
  "Hide current buffer fringes leaving one character width margin.
Margin helps avoid having text glued to the window edges.  If you
want to hide only left or right fringe or hide them without adding
margins then use `fringe-hide' function."
  :group fringe-hide :lighter nil
  (fringe-hide (if fringe-hide-mode "both")))

(provide 'fringe-hide)

;;; fringe-hide.el ends here

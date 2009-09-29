;;; source-highlight.el

;; Copyright (C) 2009  kitokitoki

;; Author: kitokitoki <morihenotegami@gmail.com>
;; Keywords: convenience
;; Prefix: sh-

;; This program is free software; you can redistribute it and/or modify
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

;; GNU source-highlight を emacs から利用するための拡張です。

;; Setting sample:

;;(require 'source-highlight)
;;(setq sh-language "php")
;;(setq sh-output-format "html")

;; Change Log

;; 1.0.0: 新規作成

;; TODO documentation

;;; Code:

(defvar sh-language "php")
(defvar sh-output-format "html")

(setq sh-output-buffer-name "*source-highlight*")

(defun sh-source-highlight () 
  (interactive) 
  (unless (executable-find "source-highlight")
    (error "GNU source highlight not found"))
  (sh-kill-buffer-if-exist sh-output-buffer-name)
  (if mark-active 
      (sh-source-highlight-region) 
    (sh-source-highlight-buffer))
  (message "finished."))

(defun sh-source-highlight-buffer ()
  (call-process-region (point-min) (point-max)
                       "source-highlight" nil (get-buffer-create sh-output-buffer-name)
                       nil "-f" sh-output-format "-s" sh-language))

(defun sh-source-highlight-region ()
  (call-process-region (region-beginning) (region-end)
                       "source-highlight" nil (get-buffer-create sh-output-buffer-name)
                       nil "-f" sh-output-format "-s" sh-language))

(defun sh-kill-buffer-if-exist (buf)
  (if (get-buffer buf)
      (kill-buffer buf)))

(provide 'source-highlight)

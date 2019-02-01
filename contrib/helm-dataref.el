;;; helm-dataref.el --- Complete Dataref Keys -*- lexical-binding: t -*-

;; Copyright (C) 2019 Christian Dietrich <stettberger@dokucode.de>

;; Version: 1.0
;; Package-Requires: ((helm "3.0") (cl-lib "0.5") (emacs "24.1"))

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

;;; Code:
(require 'helm)
(require 'cl-lib)

;;; Customizable values
(defgroup helm-dataref nil
  "Dataref libraries for Helm."
  :group 'helm)

(defcustom helm-dataref-find-keys-path
  (concat default-directory "find_keys.py")
  "Path to the find_keys.py program"
  :group 'helm-dataref
  :type  'string
  )

(defcustom helm-dataref-file
  #'TeX-master-file
  "The function is used to find the used the root tex file.

   Default is the TeX master file."
  :group 'helm-dataref
  :type 'function)

(defun helm-dataref-candidates (fn)
  (cl-loop for entry in
           (read
            (shell-command-to-string
             (format "%s --emacs %s"
                     helm-dataref-find-keys-path
                     fn)))
           collect
           (cons
            (format "%s = %s"
                    (propertize (car entry)
                                'face '((:foreground "YellowGreen")))
                    (cdr entry))
            entry)))


(defun helm-dataref--insert (macro)
  `(lambda (candidate)
       (insert
        (format "\\%s{%s}" ,macro (car candidate)))))

(setq helm-dataref-source
      (helm-build-sync-source "Dataref Keys"
        :candidates 'helm-dataref--candidates-alist
        :action `(("\\dref" . ,(helm-dataref--insert "dataref"))
                  )))

(defun helm-dataref(fn)
  "Preconfigured `helm' for dataref keys"
  (interactive)
  (setq helm-dataref--candidates-alist
        (helm-dataref-candidates
         (or fn (funcall helm-dataref-file))))
  (helm-other-buffer 'helm-dataref-source
                     "*Helm Dataref*"))

(provide 'helm-dataref)

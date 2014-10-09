;;; Compiled snippets and support files for `fundamental-mode'
;;; .yas-setup.el support file if any:
;;;
(defun ca-all-asscs (asslist query)
  "returns a list of all corresponding values (like rassoc)"
  (cond
   ((null asslist) nil)
   (t
    (if (equal (cdr (car asslist)) query)
        (cons (car (car asslist)) (ca-all-asscs (cdr asslist) query))
      (ca-all-asscs (cdr asslist) query)))))
;;; Snippet definitions:
;;;
(yas-define-snippets 'fundamental-mode
		     '(("!" "#!/usr/bin/env `(let ((found (ca-all-asscs interpreter-mode-alist major-mode))) (if found (yas/choose-value found) \"\"))`$0" "bang" nil nil nil nil nil nil)
		       ("bash" "#!/bin/bash\n$0" "bash" nil nil nil nil nil nil)
		       ("email" "`(replace-regexp-in-string \"@\" \"@NOSPAM.\" user-mail-address)`" "(user's email)" nil nil nil nil nil nil)
		       ("var" "`comment-start`-*- ${1:var}: ${2:value} -*-`comment-end`" "var" nil nil nil nil nil nil)
		       ("mode" "`comment-start`-*- mode: ${1:mode} -*-`comment-end`" "mode" nil nil nil nil nil nil)
		       ("time" "`(current-time-string)`" "(current time)" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Oct  9 16:35:23 2014

;;-*- Mode: Lisp; Package: CCL -*-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; defobfun-to-defmethod.lisp;; Copyright 1990-1994, Apple Computer, Inc.;; Copyright 1995 Digitool, Inc.;;(in-package :ccl); The function: defobfun-to-defmethod changes instances of:;;    (defobfun (function type) args . body);; to:;;    (defmethod function ((type type) . args) . body);; in a Fred window.;; Queries before each change, if the QUERY arg is non-NIL.; You can answer "Y", "N", or "P" to each query meaning; "Yes", "No", or "Proceed" respectively.; "Proceed" means stop asking and replace the remaining occurrences.(eval-when (:compile-toplevel :load-toplevel :execute)  (export 'defobfun-to-defmethod))(defun defobfun-to-defmethod (&optional (window-or-name (target)) (query nil))  (let* ((w (or (and (typep window-or-name 'window) window-or-name)                (find-window window-or-name)                (error "Can't find window named ~s" window-or-name)))         (mark (fred-buffer w))         pos pos2 str form err         (last-pos 0)         (answer (unless query :proceed)))    (loop      (setq pos (buffer-forward-search mark "(defobfun (" last-pos))      (unless pos (return))      (setq last-pos pos)      (set-selection-range w (- pos 11) pos)      (window-show-cursor w)      (fred-update w)      (when (or (eq answer :proceed) (setq answer (y-or-n "Change? ")))        (set-mark mark (setq pos (1- pos)))   ; just in front of the ending "("        (setq pos2 (buffer-fwd-sexp mark pos))        (multiple-value-setq (form err)                             (ignore-errors                              (values                               (read-from-string                                (setq str (buffer-substring mark pos pos2))))))        (if (or err (not (and (listp form) (cdr form) (null (cddr form)))))          (if err            (cerror "go to next defobfun."                    "Read error on ~s" str)            (cerror "go to next defobfun."                    "Bad first arg to defobfun: ~s" form))          (progn            (setq pos2 (buffer-forward-search mark "(" pos2))            (setq pos (- pos 6))            ; just after "def" in "defobfun"            (let ((fname (string (car form)))                  (class (string-replace (string (cadr form)) "*" ""))                  (no-trailing-space-p (eql (buffer-char mark pos2) #\))))              (buffer-delete mark pos2 pos)              (buffer-insert               mark                (string-downcase                (concatenate 'string                             "method " fname " ((" class " " class ")"                             (if no-trailing-space-p "" " ")))               pos))            (fred-update w)            (or (eq answer :proceed) (setq answer (y-or-n "OK? ")))))))))(defun string-replace (string was sb)  (let ((pos (search was string :test 'char-equal)))    (cond (pos (concatenate 'string                            (subseq string 0 pos)                            sb                            (string-replace                              (subseq string (+ pos (length was))                                     (length string))                             was sb)))          (t string))))(defun y-or-n (format-string &rest args)  (window-select (find-window "Listener"))  (apply #'format t format-string args)  (let ((ch (tyi)))    (prog1 (if (or (eql ch #\y) (eql ch #\Y) (eql ch #\space))             t             (if (or (eql ch #\p) (eql ch #\P))               :proceed))      (terpri))))
;;; -*- package: CC -*-;;;;;;; Extending Fred's Search;;;(in-package "CC")(defun search-selection (inside-toplevel from-extremity forward)  (function    (lambda (window)      (multiple-value-bind (start end)                           (selection-range window)        (if (= start end)            (ed-beep)          (let ((top) (bottom))            (cond (inside-toplevel                   (multiple-value-setq (top bottom)                                        ;; This is somewhat bogus if the                                        ;; insertion point happens to be                                        ;; at the end of a top level sexp.                                        ;; What is needed is a function                                        ;; get-current-top-level-sexp.                                        (ccl::ed-current/next-top-level-sexp window)))                  (t                   (setq top 0                         bottom (buffer-size (fred-buffer window)))))            (let ((from) (to))              (cond (forward                     (setq from (if from-extremity top end)                           to   bottom))                    (t                     (setq from top                           to (if from-extremity bottom start))))              (let* ((buffer   (fred-buffer window))                     (string   (buffer-substring buffer start end))                     (position (buffer-string-pos buffer string                                                  :start from :end to                                                  :from-end (not forward))))                (cond ((or (null position)                           (and (= start position)                                (= end (+ position (length string)))))                       (ed-beep))                      (t                       (set-selection-range window position                                            (+ position (length string)))                       (fred-update window)))))))))))(comtab-set-key ccl::*i-search-comtab* '(:control       #\f) (search-selection nil nil t  ))(comtab-set-key ccl::*i-search-comtab* '(:control       #\b) (search-selection nil nil nil))(comtab-set-key ccl::*i-search-comtab* '(:control       #\t) (search-selection nil t   t  ))(comtab-set-key ccl::*i-search-comtab* '(:control       #\e) (search-selection nil t   nil))(comtab-set-key ccl::*i-search-comtab* '(:control :meta #\f) (search-selection t   nil t  ))(comtab-set-key ccl::*i-search-comtab* '(:control :meta #\b) (search-selection t   nil nil))(comtab-set-key ccl::*i-search-comtab* '(:control :meta #\t) (search-selection t   t   t  ))(comtab-set-key ccl::*i-search-comtab* '(:control :meta #\e) (search-selection t   t   nil))
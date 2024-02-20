; -*- Mode: Lisp; Package: CCL; -*-(in-package :ccl)(let ((*warn-if-redefine* nil)      (*warn-if-redefine-kernel* nil));; just beep and format t if file not found vs. error(defun edit-definition-error (name classes qualifiers file &optional file-not-found)  (ed-beep)  (when (eq t qualifiers)(setq qualifiers nil))  (let ((*print-length* 3)        (*print-level* 2))    (if file      (if file-not-found        (format t "Can't find file ~s containing ~s~@[ with specializers ~s~]~@[ qualifiers ~s~]."                file name classes qualifiers)        (format t "Can't find ~s~@[ with specializers ~s~]~@[ qualifiers ~s~] in file ~s."                name classes qualifiers file))      (format t "There is no source file information for ~s~@[ with specializers ~s~]~@[ qualifiers ~s~]."              name classes qualifiers))))(defun edit-definition-2 (pathname &optional name)  ; pathname isn't. Car is 'variable, a method, 'function, 'class etc.  ; Cdr is the pathname. - only called if source file info  (let (type pos new-window classes qualifiers file-not-found)    (when pathname      (setq type (car pathname)            pathname (cdr pathname))      (typecase type        (method         (setq qualifiers (%method-qualifiers type)               classes (mapcar #'(lambda (s)                                   (if (consp s) s (class-name s)))                               (%method-specializers type))               name (%method-name type)               type 'method)))      (when (and (eq type 'setf)(not (consp name)))        (setq name (list 'setf name)))      (setq new-window             (or (and pathname (pathname-to-window pathname))                (and (stringp pathname)                                            ; does it look like a real pathname ?                     ;(equalp pathname "New")                     ; No, look for a  fred window with no pathname and matching title.                     (my-string-to-window pathname))))      (let ((*gonna-change-pos-and-sel* t)            really-new)        (if new-window          (window-select new-window)          ; don't error if window e.g. "New 1" isnt there any longer          (when (and (or (pathnamep pathname)(and (stringp pathname) (%path-mem ":;" pathname)))                     (or (probe-file pathname)(progn (setq file-not-found t) nil)))            (setq new-window                   (make-instance *default-editor-class*                    :filename pathname                    :window-show nil))            (setq really-new t)))        (when new-window          (unwind-protect            (let ((buf (fred-buffer new-window)))              (setq pos (or (search-for-def buf name type classes qualifiers)                            ; ? do we really want to do this ?                            (search-for-def-dumb buf name type classes qualifiers                                                 0 (buffer-size buf) T))) ; and dumber                          (when pos                (ed-push-mark new-window)                (window-scroll new-window pos)))            (when really-new              (window-select new-window))))))    (when (not pos)      (edit-definition-error name classes qualifiers pathname file-not-found))    (values pos pathname))))
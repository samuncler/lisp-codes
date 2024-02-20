; -*- Mode: Lisp; Package: CCL; -*-(in-package :ccl)(let ((*warn-if-redefine-kernel* nil)      (*warn-if-redefine* nil));; stepping methods works if you haved saved the definitions(defun uncompile-for-stepping (name/def &optional args errchk)  ;(declare (ignore args))  ;; this was once commented out - now its back somewhat improved  (when (symbolp name/def)    (let ((fn (fboundp name/def)))      (when (typep fn 'standard-generic-function)        (let ((foo (if args                      (compute-applicable-methods fn args)                     (generic-function-methods fn))))          ;; install permanently the "interpreted" defs if they can be created from saved lambda's          (if foo (mapcar #'(lambda (meth)                              (let* ((fn (method-function meth)))                                (multiple-value-bind (real-def holder)(find-unencapsulated-definition fn)                                  (let ((new-def (uncompile-for-stepping real-def args errchk)))                                    (if (eq real-def fn)                                      (setf (%method-function meth) new-def)                                      (if (symbolp holder)                                        (setf (symbol-function holder) new-def)))))))                          foo))          (return-from uncompile-for-stepping name/def)))))    ; should refuse to make-evaluated-fn if non-null-env bit  (multiple-value-bind (real-def holder) (find-unencapsulated-definition name/def)    (declare (ignore holder))    (cond ((or (compiled-for-evaluation real-def)               (typep real-def 'interpreted-lexical-closure))           real-def)          (t            (if (logbitp $lfbits-nonnullenv-bit (lfun-bits (closure-function real-def)))             (progn                (when errchk (error "~S was defined in a non empty lexical-environment" name/def))               real-def)             (let ((munched-def (lfun-processed-lambda real-def)))               (or munched-def                                    (let ((idef (lfun-lambda real-def))                         (processed-idef)                         (name (if (symbolp name/def)                                 name/def                                 (lfun-name real-def))))                     (when (not (listp idef))(error "shouldnt ~S" idef))                     (cond ((null idef)                            (if errchk                              (error "Cant find uncompiled definition for ~S" name)                              real-def))                                                     ((setq processed-idef                                  (make-evaluated-function name idef nil))                            ;(set-lfun-lambda processed-idef idef) ; nah                            (set-lfun-processed-lambda real-def processed-idef)                            processed-idef)                           (errchk                            (error "Interpreter cant deal with function ~S" name))                           (t real-def))))))))))(defun uncompile-function (fn)  (or (getf (%lfun-info fn) 'function-lambda-expression )      #+ppc-target  ; we seem to have forgotten to save it on lfun-info in some cases      (if (compiled-for-evaluation fn)        (let ((foo (uvref fn 1))) ; gag          (evalenv-form foo))))))
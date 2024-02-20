;;; -*- package: CC -*-;;;;;;; Interfacing MCL with Think-C;;;(in-package "CC")(export '(*think-c-folder*          *cenv-resource-type*          defcenv          defcmodule          open-cenv          close-cenv          link-cmodule          %make-double          %get-double          %put-double));;;;;;; Global stuff;;;(defvar *think-c-folder*  "think-c:")(defvar *cenvs*  nil)(defvar *cenvs-table*  (make-hash-table))(defvar *cenv-resource-type*  "TCCD")(defvar *cmodules*  nil)(defvar *cmodules-table*  (make-hash-table))(defstruct cenv  name  resource-file  refnum)(defstruct cmodule  name  variables  functions)(defun get-cenv (env-name)  (or (gethash env-name *cenvs-table*)      (error "Unknown C environment ~S ." env-name)))(defun get-cmodule (module-name)  (or (gethash module-name *cmodules-table*)      (error "Unknown C module ~S ." module-name)));;;;;;; CEnv definition;;;(defmacro defcenv (name &key (resource-file (default-resource-file name)))  `(progn     (defvar ,name)     (setf (gethash ',name *cenvs-table*)           (make-cenv            :name ',name            :resource-file ,resource-file))     (pushnew ',name *cenvs*)     ',name))(defun default-resource-file (name)  (merge-pathnames    *think-c-folder*    (symbol-name name)));;;;;;; CModule definition;;;(defmacro defcmodule (name &key variables functions)  `(progn     (defvar ,name)     (setf (gethash ',name *cmodules-table*)           (make-cmodule            :name      ',name            :variables ',variables            :functions ',(mapcar (function car) functions)))     (pushnew ',name *cmodules*)     ,@(mapcar (function                 (lambda (symb)                   `(defvar ,symb)))               variables)     ,@(mapcan (function                 (lambda (spec)                   (apply (function expand-function-spec)                          (cons name spec))))               functions)     ',name))(defun expand-function-spec (loader symbol arguments &optional (result :novalue))  (let ((function-args nil)        (vreflet-args  nil)        (ff-call-args  nil))    (dolist (arg arguments)      (let ((var  (if (keywordp arg) (copy-symbol arg) (first arg)))            (type (if (keywordp arg) arg (second arg))))        (when (eq type :mac)          (setq type :ptr))        (push var function-args)        (when (eq type :lisp)          (push (list var var) vreflet-args)          (setq type :ptr))        (push var  ff-call-args)        (push type ff-call-args)))    (list     `(defvar ,symbol)     `(defun ,symbol ,(nreverse function-args)        (ccl::%vreflet ,vreflet-args          (ff-call ,symbol            :a4 ,loader            ,@ff-call-args ,result))))));;;;;;; The linker;;;(defun open-cenv (env-name)  (let ((env (get-cenv env-name)))    (setf (cenv-refnum env)          (open-resource-file (truename (cenv-resource-file env))))    (let ((res (get-resource *cenv-resource-type* (symbol-name env-name))))      (cond        ((null res)         (error "Can't find the C environment ~A ." env-name))        (t (#_DetachResource res)           (set env-name (%get-ptr res))))))  t)(defun close-cenv (env-name)  (let ((env (get-cenv env-name)))    (#_DisposePtr (symbol-value env-name))    (close-resource-file (cenv-refnum env))    (setf (cenv-refnum env) nil))  t)(defun link (env-name symbol type)  (let ((addr (symbol-value env-name)))    (with-pstrs ((str (symbol-name symbol)))      (let ((addr (ff-call addr :a4 addr :ptr str :a0)))        (if (%null-ptr-p addr)            (error "Undefined C ~A ~A ." type symbol)          (set symbol addr))))))(defun link-cmodule (module-name env-name)  (let ((env (get-cenv env-name))        (module (get-cmodule module-name)))    (cond      ((null (cenv-refnum env))       (error "The C environment ~A is not opened." env-name))      (t       (set module-name (symbol-value env-name))       (dolist (symb (cmodule-variables module)) (link env-name symb "variable"))       (dolist (symb (cmodule-functions module)) (link env-name symb "function")))))  t);;;;;;; ThinkC's doubles;;;(defun (setf %get-double) (data pointer &optional (offset 0))  (%put-double pointer data offset))(defun %make-double (&optional float)  (let ((ptr (#_NewPtr 12)))    (when float      (setf (%get-double ptr) float))    ptr))(defun %get-double (pointer &optional (offset 0))  (let ((ptr (%inc-ptr pointer offset)))    (%put-word ptr (%get-word ptr) 2)    (ccl::%get-x2float (%inc-ptr ptr 2))))(defun %put-double (pointer float &optional (offset 0))  (let ((ptr (%inc-ptr pointer offset)))    (ccl::%float2x (float float) (%inc-ptr ptr 2))    (%put-word ptr (%get-word ptr 2))))(ccl::def-mactype :double  (ccl::make-mactype    :name            :double    :record-size     12    :access-operator '%get-double))
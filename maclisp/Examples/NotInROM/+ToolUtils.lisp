;; -*- package: NotInROM -*-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; +ToolUtils.Lisp;;;; Copyright � 1991 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; Provides ToolBox Utilities Routines;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(eval-when (:compile-toplevel :load-toplevel :execute)  (require    :NotInROM-u)  (in-package :NotInROM));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(deftrap-NotInROM _ScreenRes :none ((scrnHRes (:pointer :signed-integer)) (scrnVRes (:pointer :signed-integer)))  (%put-word scrnHRes (%get-word (%int-to-ptr #$ScrHRes)))  (%put-word scrnVRes (%get-word (%int-to-ptr #$ScrVRes))));;perhaps these 2 should call ReleaseResource, I'm not sure?(deftrap-NotInROM _GetIndString :none ((theString (:string 255)) (strListID :signed-integer) (index :signed-integer))  (with-macptrs ((strList_h (#_GetResource "STR#" strListID)))    (unless (%null-ptr-p strList_h)      (with-dereferenced-handles ((strList_p strList_h))        (let ((num-strings (%get-unsigned-word strList_p)))          (when (and (plusp index) (<= index num-strings))            (%incf-ptr strList_p 2)            (dotimes (i (1- index))              (declare (fixnum i))              (%incf-ptr strList_p (1+ (%get-unsigned-byte strList_p))))            (#_BlockMove strList_p theString (1+ (%get-unsigned-byte strList_p)))))))))(deftrap-NotInROM _GetIndPattern :none ((thePattern (:string 255)) (patListID :signed-integer) (index :signed-integer))  (with-macptrs ((patList_h (#_GetResource "PAT#" patListID)))    (unless (%null-ptr-p patList_h)      (with-dereferenced-handles ((patList_p patList_h))        (let ((num-pats (%get-unsigned-word patList_p)))          (when (and (plusp index) (<= index num-pats))            (%incf-ptr patList_p (+ 2 (* 8 (1- index))))            (#_BlockMove patList_p thePattern #.(ccl::record-field-length :Pattern))))))));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(deftrap-NotInROM _c2pstr :pointer ((cstr (:pointer :character)))  (unless (%null-ptr-p cstr)    (let ((last (%get-byte cstr))          (cur)          (len 0))      (declare (fixnum last cur len)               (dynamic-extent last cur len))      (loop        (when (zerop last) (return))        (incf len)        (setf cur (%get-byte cstr len))        (%put-byte cstr last len)        (setf last cur))      (%put-byte cstr (min len 255))))  cstr)(deftrap-alt-name _c2pstrProc _c2pstr)(deftrap-NotInROM _p2cstr :pointer ((pstr (:string 255)))  (let ((len (%get-unsigned-byte pstr)))    (declare (fixnum len))    (#_BlockMove (%inc-ptr pstr) pstr len)    (%put-byte pstr 0 len))  pstr)(deftrap-alt-name _p2cstrProc _p2cstr);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
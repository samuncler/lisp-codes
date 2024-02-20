;; -*- package: NotInROM -*-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; +SegLoad.Lisp;;;; Copyright � 1992 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; Provides missing Segment Loader Routines;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(eval-when (:compile-toplevel :load-toplevel :execute)  (require    :NotInROM-u)  (in-package :NotInROM));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(eval-when (:compile-toplevel :load-toplevel :execute)    (defconstant traps::$AppParmHandle #xAEC)    (defrecord (IAppFile :pointer)    (vRefNum :signed-integer)    (fType   :OSType)    (versNum :byte)    (unused  :byte)    (fnLen   :unsigned-byte))    (defrecord (AppParm :pointer)    (message :signed-integer)    (count   :signed-integer)    (doclist (:array :IAppFile 0)))  );;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(deftrap-NotInROM _CountAppFiles :none ((message (:pointer :signed-integer)) (count (:pointer :signed-integer)))  (with-macptrs ((appParm_h (%get-ptr (%int-to-ptr #$AppParmHandle))))    (if (plusp (#_GetHandleSize appParm_h))      (progn        (%put-word message (href appParm_h :AppParm.message))        (%put-word count   (href appParm_h :AppParm.count)))      (progn        (%put-word message 0)        (%put-word count   0)))))(defun app-file-offset (index appParm_p)  (let ((appFile-offset #.(ccl::record-field-length :AppParm)))    (with-macptrs ((appFile (%inc-ptr appParm_p appFile-offset)))      (dotimes (i (1- index) appFile-offset)        (declare (fixnum i))        (let ((appFile-size  (+ #.(ccl::record-field-length :IAppFile) (pref appFile :IAppFile.fnLen))))          (when (oddp appFile-size) (incf appFile-size))          (incf appFile-offset appFile-size)          (%incf-ptr appFile appFile-size))))))(deftrap-NotInROM _GetAppFiles :none ((index :signed-integer) (theFile :AppFile))  (with-macptrs ((appParm_h (%get-ptr (%int-to-ptr #$AppParmHandle))))    (when (and (plusp (#_GetHandleSize appParm_h))               (<= index (href appParm_h :AppParm.count)))      (with-dereferenced-handles ((appParm_p appParm_h))        (let ((offset (app-file-offset index appParm_p)))          (with-macptrs ((appFile (%inc-ptr appParm_p offset)))            (setf (pref theFile :AppFile.vRefNum) (pref appFile :IAppFile.vRefNum))            (setf (pref theFile :AppFile.fType)   (pref appFile :IAppFile.fType))            (setf (pref theFile :AppFile.versNum) (pref appFile :IAppFile.versNum))            (#_BlockMove             (%inc-ptr appFile #.(nth-value 0 (field-info :IAppFile :fnLen)))             (%inc-ptr theFile #.(nth-value 0 (field-info :AppFile  :fName)))             (1+ (pref appFile :IAppFile.fnLen)))))))))(deftrap-NotInROM _ClrAppFiles :none ((index :signed-integer))  (with-macptrs ((appParm_h (%get-ptr (%int-to-ptr #$AppParmHandle))))    (when (and (plusp (#_GetHandleSize appParm_h))               (<= index (href appParm_h :AppParm.count)))      (with-dereferenced-handles ((appParm_p appParm_h))        (let ((offset (app-file-offset index appParm_p)))          (with-macptrs ((appFile (%inc-ptr appParm_p offset)))            (setf (pref appFile :IAppFile.fType) 0)))))));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
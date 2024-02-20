(in-package :oou)(oou-provide :Traps-u);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; traps-u.Lisp;;;; Copyright � 1992 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; Utilities for working with trap calls ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :+OSUtils;                  )(export '(on-trap-nz-error trap-nz-echeck with-patched-trap          ));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(eval-when (:compile-toplevel :load-toplevel :execute)    (defmacro on-trap-nz-error (trap-form &rest body)    (let* ((result (gensym))           (trap-call (if (eq 'require-trap (first trap-form))                        (rest trap-form)                        trap-form))           (args (rest trap-call)))      `(let ((,result ,trap-call))         (declare (dynamic-extent ,result)                  (fixnum ,result))         (unless (zerop ,result)           ,@body           (error (MacOS-nz-error-string ',trap-form ',args ,result) ,@args))         0)))    (defmacro trap-nz-echeck (trap-call)    `(on-trap-nz-error ,trap-call))    (defmacro with-patched-trap ((trap-number new-trap-addr &optional (old-trap-addr (gensym))) &body body)    (let ((trap-type (if (plusp (logand #x0800)) #$ToolTrap #$OSTrap)))      `(with-macptrs ((,old-trap-addr (%int-to-ptr (#~NGetTrapAddress ,trap-number ,trap-type))))         (unwind-protect           (progn             (#~NSetTrapAddress (%ptr-to-int ,new-trap-addr) ,trap-number ,trap-type)             ,@body)           (#~NSetTrapAddress (%ptr-to-int ,old-trap-addr) ,trap-number ,trap-type)))))    );;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defun MacOS-nz-error-string (trap-form args result)  (format nil          "mac error code = ~s~%> from trap call: ~s~%>  with arg vals: ~{~%>    ~s = ~~s~}"          result          trap-form          args));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|;;example of patching EraseRect to do nothing. Useful for keeping;; TextEdit from doing an EraseRect before imaging the text.(defpascal dummy-EraseRect (:ptr r :void) (declare (ignore r)))(defparameter *test-w* (make-instance 'window :view-size #@(200 200) :view-font '("Chicago" 12)))(with-focused-view *test-w*     (let* ((topLeft #@(0 0))           (botRight (view-size *test-w*))           (mid (round (+ (point-v topLeft) (point-v botRight)) 2)))      (rlet ((r  :Rect :topLeft topLeft :botRight botRight)             (r1 :Rect :topLeft topLeft :bottom  mid :right (point-h botRight))             (r2 :Rect :top mid :left (point-h topLeft) :botRight botRight))        (#_FillRect r *gray-pattern*)        (#_InsetRect r1 15 15)        (#_InsetRect r2 15 15)        (#_FrameRect r1)        (#_FrameRect r2)        (let ((text1 "Here is normal text edit drawing via _TextBox. Note: it calls EraseRect 1st")              (text2 "Here the EraseRect trap has been patched to do nothing."))          (with-cstrs ((text1_p text1)                       (text2_p text2))        (#_TextBox text1_p (length text1) r1 #$teJustCenter)        (with-patched-trap (#_EraseRect dummy-EraseRect)          (#_TextBox text2_p (length text2) r2 #$teJustCenter)))))))|#
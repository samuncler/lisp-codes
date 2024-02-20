(in-package :oou)(oou-provide :PICT-di);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PICT-di.Lisp;;;; Copyright � 1991 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; PICT and PICT-button dialog items;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :PICT-svm :disable-dim :button-dim)(export '(PICT-di PICT-button-di));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        (defclass PICT-di (PICT-svm dialog-item) ())(defclass PICT-button-di (disable-dim button-dim PICT-di) ());;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|(open-res-file "oou:examples;examples.rsrc");keep the PICT in RAM(setf *test-w*      (make-instance 'dialog        :window-type :document        :color-p t        :view-position :centered        :view-size #@(300 300)        :window-title "PICT demo"        :view-subviews (list (make-instance 'PICT-button-di                               :view-position #@(10 10)                               :PICT-name "Mr. T"                               :dialog-item-action #'(lambda (item) (declare (ignore item)) (ed-beep))                               :view-nick-name :I-pity-the-fool                               ))));spool the PICT off disk (from a PICT file)(setf *test-w*      (make-instance 'dialog        :window-type :document        :color-p t        :view-position :centered        :view-size #@(300 300)        :window-title "PICT demo"        :view-subviews (list (make-instance 'PICT-button-di                               :view-position #@(10 10)                               :PICT-file "oou:examples;MrT.PICT"                               :PICT-storage :disk                               :dialog-item-action #'(lambda (item) (declare (ignore item)) (ed-beep))                               :view-nick-name :I-pity-the-fool                               ))))|#
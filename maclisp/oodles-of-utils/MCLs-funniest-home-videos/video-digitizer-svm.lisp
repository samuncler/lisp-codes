(in-package :oou)(oou-provide :video-digitizer-svm);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; video-digitizer-svm.lisp;;;; Copyright � 1991 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; mixin for adding video digitizing to views;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :video-digitizer :simple-view-ce )(export '(video-digitizer-svm          digitizing-p start-digitizing stop-digitizing grab-one-frame          video-margins digitizer-object           ));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defclass video-digitizer-svm ()  ((digitizer-class        :initarg :digitizer-class)   (digitizer-object       :initarg :digitizer-object                           :accessor digitizer-object)   (dispose-vd-on-remove-p :initarg :dispose-vd-on-remove-p))  (:default-initargs    :digitizer-class 'video-digitizer    :dispose-vd-on-remove-p t    ));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; digitizer control(defmethod digitizing-p ((sv video-digitizer-svm))  (vd-digitizing-p (digitizer-object sv)))(defmethod start-digitizing ((sv video-digitizer-svm))  (with-focused-view (focusing-view sv)    (vd-start-digitizing (digitizer-object sv))))(defmethod stop-digitizing ((sv video-digitizer-svm))  (vd-stop-digitizing (digitizer-object sv)))(defmethod grab-one-frame ((sv video-digitizer-svm))  (with-focused-view (focusing-view sv)    (vd-grab-one-frame (digitizer-object sv))));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defmethod initialize-instance :after ((sv video-digitizer-svm) &rest initargs                                       &key                                       dest-rect-topLeft                                       dest-rect-botRight                                       &allow-other-keys)  (declare (dynamic-extent initargs))  (unless (slot-boundp sv 'digitizer-object)    (setf (digitizer-object sv)          (apply 'make-instance (slot-value sv 'digitizer-class)                 :allow-other-keys t                 initargs))    (multiple-value-bind (topLeft botRight) (video-corners sv)      (unless dest-rect-topLeft        (setf (dest-rect-topLeft (digitizer-object sv)) topLeft))      (unless dest-rect-botRight        (setf (dest-rect-botRight (digitizer-object sv)) botRight)))))(defmethod install-view-in-window :after ((sv video-digitizer-svm) window)  (with-slots (digitizer-object) sv    (vd-init digitizer-object)    (setf (slot-value digitizer-object 'dest-wptr) (wptr window)))  (when (subtypep (type-of window) 'video-wm)    (pushnew sv (slot-value window 'digitizer-subviews))))(defmethod remove-view-from-window :before ((sv video-digitizer-svm))  (when (slot-value sv 'dispose-vd-on-remove-p)    (vd-dispose (digitizer-object sv)))  (let ((w (view-window sv)))    (when (subtypep (type-of w) 'video-wm)      (setf (slot-value w 'digitizer-subviews)            (delete sv (slot-value w 'digitizer-subviews))))))(defmethod video-margins ((sv video-digitizer-svm))  (declare (ignore sv))  (values #@(0 0) #@(0 0)))(defmethod video-corners ((sv video-digitizer-svm))  (multiple-value-bind (topLeft botRight) (focused-corners sv)    (multiple-value-bind (tl-margin br-margin) (video-margins sv)      (values (add-points topLeft tl-margin) (subtract-points botRight br-margin)))))(defmethod view-default-size ((sv video-digitizer-svm))  (add-points (multiple-value-call #'add-points (video-margins sv))              #@(100 100)))(defmethod set-view-size :around ((sv video-digitizer-svm) h &optional v)  (declare (ignore h v))  (erase-view sv)  (with-slots (digitizer-object) sv    (let ((on-p (vd-digitizing-p digitizer-object)))      (when on-p (vd-stop-digitizing digitizer-object))      (call-next-method)      (multiple-value-bind (topLeft botRight) (video-corners sv)        (setf (dest-rect-topLeft digitizer-object)  topLeft)        (setf (dest-rect-botRight digitizer-object) botRight))      (when on-p (vd-start-digitizing digitizer-object)))))(defmethod set-view-position :around ((sv video-digitizer-svm) h &optional v)  (declare (ignore h v))  (with-slots (digitizer-object) sv    (let ((on-p (vd-digitizing-p digitizer-object)))      (when on-p (vd-stop-digitizing digitizer-object))      (call-next-method)      (multiple-value-bind (topLeft botRight) (video-corners sv)        (setf (dest-rect-topLeft  digitizer-object) topLeft)        (setf (dest-rect-botRight digitizer-object) botRight))      (when on-p (vd-start-digitizing digitizer-object)))));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|   examples can be found in the board specific -vd files|#
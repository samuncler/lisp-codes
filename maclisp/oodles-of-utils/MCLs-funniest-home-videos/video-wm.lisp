(in-package :oou)(oou-provide :video-wm);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; video-wm.lisp;;;; Copyright � 1992 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; mixin for making windows video aware;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :video-digitizer-svm :window-ce :records-u )(export '(video-wm video-window video-dialog           ));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defclass video-wm ()  ((digitizer-subviews :initform nil)   (vw-drag-rect       :accessor vw-drag-rect)   )  (:default-initargs    :color-p t    ))(defclass video-window (video-wm window) ())(defclass video-dialog (video-wm dialog) ())(defmethod initialize-instance :after ((w video-wm) &rest initargs &key view-position)  (declare (ignore initargs))  (when (and (vw-GDevice w) (null view-position))    (window-center-on-screen w :specified-GD :GDevice (vw-GDevice w)))  (vw-check-GDevices w)  (setf (vw-drag-rect w) (#_NewPtr (rlength :Rect)))  (when (%null-ptr-p (vw-drag-rect w))    (error "unable to allocate drag Rect for video window.")))(defmethod window-close :after ((w video-wm))  (#_DisposePtr (vw-drag-rect w)))(defmethod add-subviews :after ((w video-wm) &rest subviews)  (declare (ignore subviews))  (vw-check-GDevices w))(defmethod window-drag-rect ((w video-wm))  (with-macptrs ((gd_h      (vw-GDevice w))                 (struct-rgn  (pref (wptr w) :windowRecord.strucRgn)))    (when gd_h      (rlet ((mouse-pos_p :point))        (#_GetMouse mouse-pos_p)        (#_LocalToGlobal mouse-pos_p)        (let* ((win-tl    (href struct-rgn :Region.rgnBBox.topLeft))               (win-br    (href struct-rgn :Region.rgnBBox.botRight))               (mouse-pos (%get-point mouse-pos_p))               (r         (vw-drag-rect w)))                    (with-dereferenced-handles ((gd_p gd_h))            (pset r :Rect (pref gd_p :GDevice.gdRect))            (incf (rref r :Rect.top)    (- (point-v mouse-pos) (point-v win-tl)))            (incf (rref r :Rect.left)   (- (point-h mouse-pos) (point-h win-tl)))            (incf (rref r :Rect.bottom) (- (point-v mouse-pos) (point-v win-br)))            (incf (rref r :Rect.right)  (- (point-h mouse-pos) (point-h win-br)))            (when (eql gd_h (#_GetMainDevice))              (incf (rref r :Rect.top) (#_GetMBarHeight)))            r))))))(defmethod window-hide :before ((w video-wm))  (vw-stop-digitizing  w (vw-on-list w)))(defmethod set-view-position :around ((w video-wm) h &optional v)  (declare (ignore h v))  (let ((on-list (vw-on-list w)))    (prog2     (vw-stop-digitizing  w on-list)     (call-next-method)     (vw-start-digitizing w on-list))))(defmethod set-view-position :after ((w video-wm) h &optional v)  (declare (ignore h v))  (when (window-shown-p w) (vw-check-GDevices w)));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defmethod vw-GDevice ((w video-wm))  (let ((dviews (slot-value w 'digitizer-subviews)))    (when dviews      (vd-GDevice (digitizer-object (first dviews))))))(defmethod vw-on-list ((w video-wm))  (flet ((on-p (v) (when (digitizing-p v) (list v))))    (declare (dynamic-extent #'on-p))    (mapcan #'on-p (slot-value w 'digitizer-subviews))))(defmethod vw-stop-digitizing ((w video-wm) on-list)  (dolist (v on-list) (stop-digitizing v)))(defmethod vw-start-digitizing ((w video-wm) on-list)  (dolist (v on-list) (start-digitizing v)))(defmethod vw-check-GDevices ((w video-wm))  (let ((gd_h (vw-GDevice w)))    (when gd_h      (with-dereferenced-handles ((gd_p gd_h))        (with-macptrs ((gd-rect (pref gd_p :GDevice.gdRect)))          (dolist (v (slot-value w 'digitizer-subviews))            (unless (eql gd_h (vd-GDevice (digitizer-object v)))              (error "digitizer views requiring different GDevices used in the same window."))            (multiple-value-bind (topLeft botRight) (view-global-corners v)              (unless (and (#_PtInRect topLeft  gd-rect)                           (#_PtInRect botRight gd-rect))                (error "digitizer view not on required GDevice."))))))))  t);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|an example can be found in video-example.lisp|#
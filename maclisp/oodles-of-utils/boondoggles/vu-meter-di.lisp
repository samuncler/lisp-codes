(in-package :oou)(oou-provide :vu-meter-di);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; vu-meter-di.Lisp;;;; Copyright � 1991 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; vu-meter dialog item;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(export '(vu-meter-di setting move-setting))(oou-dependencies :QuickDraw-u);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|For now this is pretty much a hack attempt at a vu-meter dialog itemCheckout the source for full details.Initargs :range   A list of the lower & upper setting limits :setting   The initial setting :num-ticks   The number of tick marks on the dial ...   The other initargs control how the dial looks. Their names are somewhat   mnemonic. You'll need to adjust them to your own taste.Methods of Interest setting (di vu-meter-di)   Returns the current dial setting. Use with setf to change it. move-setting (di vu-meter-di) new-setting &optional (delta (slot-value di 'delta))   Changes the setting in increments (of size delta) to a acheive a   cheesy animated effect.|#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defclass vu-meter-di (dialog-item)  ((range-end-l)   (range-end-r)      (setting :initarg :setting)   (critical-setting :initarg :critical-setting)   (num-ticks :initarg :num-ticks)   (tick-size :initarg :tick-size)   (tick-thickness :initarg :tick-thickness)   (arm-indent :initarg :arm-indent)      (arm-base-indent :initarg :arm-base-indent)   (arm-thickness :initarg :arm-thickness)   (frame-thickness :initarg :frame-thickness)   (delta :initarg :delta)   )  (:default-initargs    :view-size  #@(120 60)    :range '(0 100)    :delta 2    :setting 30    :critical-setting 80    :num-ticks 10    :tick-size 8    :tick-thickness #@(2 2)    :arm-indent 15    :arm-base-indent 40    :arm-thickness #@(3 3)    :frame-thickness #@(2 2)    ))(defmethod initialize-instance :after ((di vu-meter-di) &rest initargs &key range)  (declare (ignore initargs))  (setf (slot-value di 'range-end-l) (first range))  (setf (slot-value di 'range-end-r) (second range)))(defmethod view-draw-contents ((di vu-meter-di))  (vu-draw-frame di)  (vu-draw-arm di))(defmethod setting ((di vu-meter-di))  (slot-value di 'setting))(defmethod (setf setting) (new-setting (di vu-meter-di))  (with-focused-view (view-container di)    (without-interrupts      (vu-draw-arm di)     (setf (slot-value di 'setting) new-setting)     (vu-draw-arm di))))(defmethod move-setting ((di vu-meter-di) new-setting &optional (delta (slot-value di 'delta)))  (let ((next-val (setting di)))    (if (> new-setting next-val)      (loop        (incf next-val delta)        (unless (< next-val new-setting)          (return))        (setf (setting di) next-val))      (loop        (decf next-val delta)        (unless (> next-val new-setting)          (return))        (setf (setting di) next-val)))    (setf (setting di) new-setting)))(defmethod vu-draw-frame ((di vu-meter-di))  (with-pen-state (:pnSize (slot-value di 'frame-thickness))    (multiple-value-bind (arc-topLeft arc-botRight arc-center) (vu-arc-corners di)      (let ((left (point-h arc-topLeft))            (bot (- (point-v arc-center) (point-v (slot-value di 'frame-thickness))))            (right (- (point-h arc-botRight) (point-h (slot-value di 'frame-thickness))))            (critical-angle (vu-setting-to-angle di (slot-value di 'critical-setting))))        (rlet ((outer-r :Rect :topLeft arc-topLeft :botRight arc-botRight)               (inner-r :Rect :topLeft arc-topLeft :botRight arc-botRight))          (with-slots (arm-base-indent) di            (#_InsetRect inner-r arm-base-indent arm-base-indent))                    ;background          (with-fore-color (getf (part-color-list di) :body *white-color*)            (#_PaintArc outer-r -90 180))                    ;critical area wedge          (with-fore-color (getf (part-color-list di) :critical *black-color*)            (#_InsetRect outer-r 1 1)            (#_PaintArc outer-r critical-angle (- 90 critical-angle))            (#_InsetRect outer-r -1 -1))                    (with-fore-color (getf (part-color-list di) :arm-base *gray-color*)            (#_PaintArc inner-r -90 180))                    ;outer arc and arm-base arc          (with-fore-color (getf (part-color-list di) :frame *black-color*)            (#_FrameArc outer-r -90 180)            (#_FrameArc inner-r -90 180)))                ;base        (#_MoveTo left bot)        (#_LineTo right bot))))    (vu-draw-ticks di))(defmethod vu-draw-arm ((di vu-meter-di))  (multiple-value-bind (arc-topLeft arc-botRight arc-center) (vu-arc-corners di)    (with-macptrs ((rgn (#_NewRgn)))      (#_OpenRgn)      (rlet ((r :Rect :topLeft arc-topLeft :botRight arc-botRight))        (let ((inset (slot-value di 'arm-indent)))          (#_InsetRect r inset inset)          (#_FrameOval r)          (setf inset (- (slot-value di 'arm-base-indent) inset))          (#_InsetRect r inset inset)          (#_FrameOval r)))      (#_CloseRgn rgn)      (with-clip-rgn rgn        (with-pen-state (:pnMode #$patXor :pnSize (slot-value di 'arm-thickness))          (with-fore-color (getf (part-color-list di) :arm *black-color*)            (#_MoveTo (point-h arc-center) (point-v arc-center))            (vu-line-angle (vu-setting-to-angle di) -4096))))      (#_DisposeRgn rgn))))(defmethod vu-draw-ticks ((di vu-meter-di))  (when (plusp (slot-value di 'num-ticks))    (multiple-value-bind (arc-topLeft arc-botRight arc-center) (vu-arc-corners di)      (with-macptrs ((rgn (#_NewRgn)))        (#_OpenRgn)        (rlet ((r :Rect :topLeft arc-topLeft :botRight arc-botRight))          (#_FrameOval r)          (with-slots (tick-size) di            (#_InsetRect r tick-size tick-size))          (#_FrameOval r))        (#_CloseRgn rgn)        (with-pen-state (:pnSize (slot-value di 'tick-thickness))          (with-clip-rgn rgn            (with-fore-color (getf (part-color-list di) :ticks *black-color*)              (do ((h (point-h arc-center))                   (v (- (point-v arc-center) 2))                   (dtheta (round 180 (slot-value di 'num-ticks)))                   (theta 0 (+ theta dtheta)))                  ((>= theta 180) nil)                (#_MoveTo h v)                (vu-line-angle theta -4096)))))        (#_DisposeRgn rgn)))))(defmethod vu-arc-corners ((di vu-meter-di))  (multiple-value-bind (topLeft botRight) (view-corners di)    (setf botRight (add-points botRight                               (make-point 0 (- (point-v botRight) (point-v topLeft)))))    (values topLeft            botRight            (make-point             (truncate (+ (point-h topLeft) (point-h botRight)) 2)             (truncate (+ (point-v topLeft) (point-v botRight)) 2)))))(defun vu-line-angle (angle dv)  (let ((dh (#_HiWord (#_FixMul (ash dv 16) (#_SlopeFromAngle angle)))))    (#_Line dh dv)))(defmethod vu-setting-to-angle ((di vu-meter-di) &optional (setting (setting di)))  (with-slots (range-end-l range-end-r) di    (- (round (* 180 (/ (- setting range-end-l) (- range-end-r range-end-l)))) 90)))#|(progn  (setf *test-w*        (make-instance 'dialog                       :window-type :document                       :view-position :centered                       :view-size #@(200 100)                       :window-title "vu demo"                       :color-p t))  (with-focused-view *test-w* (#_BackPat *gray-pattern*))  (invalidate-view *test-w* t)  (add-subviews *test-w* (make-dialog-item 'vu-meter-di                                           #@(20 20)                                           #@(120 60)                                           "totally awesome static text"                                           #'(lambda (item) (declare (ignore item)) (ed-beep))                                           :view-nick-name :butt                                           :tick-size 8                                           :arm-indent 15                                           :arm-base-indent 40                                           :part-color-list '(:critical #.*red-color* :ticks #.*black-color*)                                           )));(move-setting (view-named :butt *test-w*) (random 100))|#
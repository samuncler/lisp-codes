(in-package :oou)(oou-provide :3d-look-svm);*****************************************************************                                    ;; Copyright � 1995 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; an iconbar on a border of a window; ;; Changes (worth to be mentioned):; ------------------------------; none ;;*****************************************************************;*****************************************************************(oou-dependencies )(export '(          ));----------------------------------------------------------------------------(defun make-gray-color (percent)  (let ((color-part (round (* (/ 65535 100) percent))))    (make-color color-part color-part color-part)))(defun draw-up-rect (top-left bottom-right light-color dark-color)  (let* ((h1 (point-h top-left))         (v1 (point-v top-left))         (h2 (point-h bottom-right))         (v2 (point-v bottom-right)))    (with-fore-color light-color      (#_moveto  h1 v1)      (#_lineto  h1 v2))    (with-fore-color dark-color      (#_moveto  h2 v1)      (#_lineto  h2 v2)      (#_lineto  h1 v2))    (with-fore-color light-color      (#_moveto  h1 v1)      (#_lineto  h2 v1))))(defmethod draw-point (h v color)  (with-fore-color color    (#_MoveTo h v)    (#_Line 0 0)));---------------------------------------------------------------------------(defclass 3d-effect ()  ((frame :initform (make-gray-color 30)          :initarg :frame          :accessor frame)   (frame-corner :initform *tool-back-color*                 :initarg :frame-corner                 :accessor frame-corner)   (effect-frame-one-top-left :initform *white-color*                              :initarg :effect-frame-one-top-left                              :accessor effect-frame-one-top-left)   (effect-frame-one-bottom-right :initform (make-gray-color 72)                                  :initarg :effect-frame-one-bottom-right                                  :accessor effect-frame-one-bottom-right)   (effect-frame-one-bottom-right-corner :initform (make-gray-color 64)                                         :initarg :effect-frame-one-bottom-right-corner                                         :accessor effect-frame-one-bottom-right-corner)   (effect-frame-two-top-left :initform (make-gray-color 93)                              :initarg :effect-frame-two-top-left                              :accessor effect-frame-two-top-left)   (effect-frame-two-bottom-right :initform (make-gray-color 81)                                  :initarg :effect-frame-two-bottom-right                                  :accessor effect-frame-two-bottom-right)   (back :initform *tool-back-color*         :initarg :back         :accessor back)))(defmethod draw-frame ((effect 3d-effect) (view simple-view))  (with-slots (frame frame-corner) effect    (with-focused-view view      (with-fore-color frame        (#_MoveTo 1 0)        (#_Line (- (view-width view) 3) 0)        (#_MoveTo 0 1)        (#_Line 0 (- (view-height view) 3))        (#_MoveTo 1 (- (view-height view) 1))        (#_Line (- (view-width view) 3) 0)        (#_MoveTo (- (view-width view) 1) 1)        (#_Line 0 (- (view-height view) 3)))      (draw-point 0 0 frame-corner)      (draw-point (1- (view-width view)) (1- (view-height view)) frame-corner)      (draw-point 0 (1- (view-height view)) frame-corner)      (draw-point (1- (view-width view)) 0 frame-corner))))(defmethod draw-effect-frame-one ((effect 3d-effect) (view simple-view))  (with-slots (effect-frame-one-top-left effect-frame-one-bottom-right effect-frame-one-bottom-right-corner back) effect    (with-focused-view view      (draw-up-rect #@(1 1) (subtract-points (view-size view) #@(2 2))                    effect-frame-one-top-left                    effect-frame-one-bottom-right)      (draw-point 1 1 effect-frame-one-top-left)      (draw-point (- (view-width view) 2) (- (view-height view) 2) effect-frame-one-bottom-right-corner)      (draw-point 1 (- (view-height view) 2) back)      (draw-point (- (view-width view) 2) 1 back))))(defmethod draw-effect-frame-two ((effect 3d-effect) (view simple-view))  (with-slots (effect-frame-one-top-left effect-frame-one-bottom-right effect-frame-one-bottom-right-corner effect-frame-two-top-left effect-frame-two-bottom-right back) effect    (with-focused-view view      (draw-up-rect #@(2 2) (subtract-points (view-size view) #@(3 3))                           effect-frame-two-top-left                           effect-frame-two-bottom-right)      (draw-point 2 2 effect-frame-one-top-left)      (draw-point (- (view-width view) 3) (- (view-height view) 3) effect-frame-one-bottom-right)      (draw-point 2 (- (view-height view) 3) back)      (draw-point (- (view-width view) 3) 2 back))))(defmethod draw-inner-corners ((effect 3d-effect) (view simple-view))  (with-slots (effect-frame-two-top-left effect-frame-two-bottom-right back) effect    (with-focused-view view      (draw-point 3 3 effect-frame-two-top-left)      (draw-point (- (view-width view) 4) (- (view-height view) 4) effect-frame-two-bottom-right)      (draw-point 3 (- (view-height view) 4) back)      (draw-point (- (view-width view) 4) 3 back))))              (defmethod draw-3d-effect ((effect 3d-effect) (view simple-view))  (with-focused-view view    (draw-frame effect view)    (draw-effect-frame-one effect view)    (draw-effect-frame-two effect view)    (draw-inner-corners effect view)))(defmethod draw-background ((effect 3d-effect) (view simple-view))  (with-focused-view view    (rlet ((rect :rect                  :topleft #@(1 1)                  :botright (subtract-points (view-size view) #@(1 1))))      (with-back-color (back effect)        (#_eraserect rect)))))(defmethod draw-background ((effect null) (view simple-view))  (with-focused-view view    (rlet ((rect :rect                  :topleft #@(1 1)                  :botright (subtract-points (view-size view) #@(1 1))))      (with-back-color *white-color*        (#_eraserect rect)))))(defmethod draw-3d-effect ((effect null) (view simple-view))  nil);--------------------------------------------------------------------------------------------; some predefined 3d-effects(defparameter *3d-up-effect*   (make-instance '3d-effect    :back *tool-back-color*    :frame (make-gray-color 30)    :frame-corner *tool-back-color*    :effect-frame-one-top-left *white-color*    :effect-frame-one-bottom-right (make-gray-color 72)    :effect-frame-one-bottom-right-corner (make-gray-color 64)    :effect-frame-two-top-left (make-gray-color 93)    :effect-frame-two-bottom-right (make-gray-color 81)))(defparameter *3d-up-effect-powerbook*   (make-instance '3d-effect    :back *light-gray-color*    :frame (make-gray-color 30)    :frame-corner *light-gray-color*    :effect-frame-one-top-left *white-color*    :effect-frame-one-bottom-right (make-gray-color 51)    :effect-frame-one-bottom-right-corner (make-gray-color 45)    :effect-frame-two-top-left (make-gray-color 93)    :effect-frame-two-bottom-right (make-gray-color 69)))(defparameter *3d-button-down-effect*   (make-instance '3d-effect    :back (make-gray-color 48)    :frame (make-gray-color 0)    :frame-corner *tool-back-color*    :effect-frame-one-top-left (make-gray-color 0)    :effect-frame-one-bottom-right *white-color*    :effect-frame-one-bottom-right-corner *white-color*    :effect-frame-two-top-left (make-gray-color 45)    :effect-frame-two-bottom-right (make-gray-color 51)))(defparameter *3d-down-effect*   (make-instance '3d-effect    :back (make-gray-color 78)        :frame *tool-back-color*    :frame-corner *tool-back-color*    :effect-frame-one-top-left (make-gray-color 30)    :effect-frame-one-bottom-right *white-color*    :effect-frame-one-bottom-right-corner *white-color*    :effect-frame-two-top-left (make-gray-color 77)    :effect-frame-two-bottom-right (make-gray-color 99)))#|(defmethod draw-down ((view 3d-look-svm))  (with-focused-view view    (let* ((lighter (lighter-color view))           (light (light-color view))           (dark (dark-color view))           (darker (darker-color view))           (frame (frame-color view))           (size (view-size view)))      (cond ((eq (effect-depth view) 1)             (draw-down-rect #@(0 0) (subtract-points size #@(1 1))                            frame                           frame)             (draw-down-rect #@(1 1) (subtract-points size #@(2 2))                             lighter                             darker))            (t              (draw-down-rect  #@(0 0) (subtract-points size #@(1 1))                               light                               darker)             (draw-down-rect  #@(1 1) (subtract-points size #@(2 2))                              lighter                               dark))))))(defmethod draw-frame-up ((view 3d-look-svm))  (with-focused-view view    (let* ((lighter (lighter-color view))           (dark (dark-color view))           (size (view-size view)))      (draw-up-rect  #@(0 0) (subtract-points size #@(1 1))                      lighter                      dark)      (draw-up-rect  #@(1 1) (subtract-points size #@(2 2))                     dark                     lighter))))(defmethod draw-frame-down ((view 3d-look-svm))  (with-focused-view view    (let* ((lighter (lighter-color view))           (dark (dark-color view))           (size (view-size view)))      (draw-up-rect  #@(0 0) (subtract-points size #@(1 1))                      dark                     lighter)      (draw-up-rect  #@(1 1) (subtract-points size #@(2 2))                     lighter                      dark))))|#;---------------------------------------------------------------------------(defclass 3d-look-svm ()  ((3d-effect :initform *3d-up-effect*    :initarg :3d-effect    :accessor 3d-effect)))(defmethod (setf 3d-effect) :around (new-value (view 3d-look-svm))  (let ((old-value (slot-value view '3d-effect)))    (call-next-method)    (unless (eq new-value old-value)      (ccl::force-view-draw-contents view)      (validate-view view))))(defmethod view-draw-contents :around ((view 3d-look-svm))  (when (wptr view)    (draw-background (3d-effect view) view)    (call-next-method)    (draw-3d-effect (3d-effect view) view)));----------------------------------------------------------------------------#|(defparameter *3d-strange-effect*   (make-instance '3d-effect    :back (make-gray-color 78)        :frame (make-gray-color 50)    :frame-corner *tool-back-color*    :effect-frame-one-top-left (make-gray-color 30)    :effect-frame-one-bottom-right *white-color*    :effect-frame-one-bottom-right-corner *white-color*    :effect-frame-two-top-left (make-gray-color 77)    :effect-frame-two-bottom-right (make-gray-color 99)))(defclass 3d-view (3d-look-svm view)  ())(defmethod view-click-event-handler ((view 3d-view) where)  (declare (ignore where))  (let ((next-look (if (eq (3d-effect view) *3d-strange-effect*)                     *3d-up-effect-powerbook*                     *3d-strange-effect*)))    (setf (3d-effect view) next-look)))  (make-instance 'window  :window-title "click views"  :window-type :document  :back-color *tool-back-color*  :view-size #@(160 160)  :view-position :centered  :view-subviews  (list (make-instance '3d-view          ;:view-size #@(60 60)          :view-size #@(30 25)          :view-position #@(45 45))))|#
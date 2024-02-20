(in-package :oou)(oou-provide :arrow-di);*****************************************************************                                    ;; Copyright � 1992 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; a simple button with an arrow inside ; ;; Changes (worth to be mentioned):; ------------------------------; none ; ;*****************************************************************;***************************************************************** (oou-dependencies :QuickDraw-u                              :unibas-macros                              :unibas-cursors                              :unibas-button-di                              :simple-view-ce                              :highlight)(export '(arrow-di arrow-width arrow-direction arrow-offset               ));---------------------------------------------------------------------------(defclass arrow-di (unibas-button-dialog-item)   ((arrow-width :initform 8 ;should always be even                           :initarg :arrow-width                           :accessor arrow-width)     (arrow-height :initform 11                            :initarg :arrow-height                            :accessor arrow-height)     (arrow-thickness :initform 3 ; should always be odd                                  :initarg :arrow-thickness                                  :accessor arrow-thickness)     (arrow-direction :initform :up                                 :initarg :arrow-direction                                 :accessor arrow-direction)     (arrow-offset :initform 0                            :initarg :arrow-offset                            :accessor arrow-offset)     (enabled-p :initform t                       :initarg :enabled-p                       :accessor enabled-p)))(defmethod view-cursor ((self arrow-di) where)   (declare (ignore where))   (if (enabled-p self)      (call-next-method)      *arrow-cursor*))(defmethod view-click-event-handler ((self arrow-di) where)   (declare (ignore where))   (when (enabled-p self)       (call-next-method)))(defmethod (setf enabled-p) :before (new-value (self arrow-di))    (when (neq new-value (enabled-p self))       (invalidate-view self)))(defmethod view-draw-contents ((self arrow-di))   (let ((pen-pattern (if (enabled-p self)                                   *black-pattern*                                   *gray-pattern*)))      (with-pen-pattern (pen-pattern (view-container self))           (view-frame-with-shade self)          (with-slots (arrow-width arrow-direction arrow-offset arrow-height arrow-thickness) self              (let* ((vertical-space (- (view-height self) arrow-height 1))                        (horizontal-space (- (view-width self) arrow-height 3))                        (horizontal-middle (round (- (view-width self) 2) 2))                        (vertical-middle (round (- (view-height self) 2) 2))                        (width 0))                 (case arrow-direction                    (:up (Move-To self horizontal-middle (- (round vertical-space 2) arrow-offset))                           (loop                              (Line self width 0)                              (incf width)                              (Move self (- width) 1)                              (incf width)                              (when (> width arrow-width) (return)))                           (let ((topleft (make-point (- horizontal-middle (round (1- arrow-thickness) 2))                                                                     (point-v (pen-position self))))                                   (bottomright (make-point (+ horizontal-middle (round arrow-thickness 2))                                                                            (+ (point-v (pen-position self))                                                                                (- arrow-height (1+ (round arrow-width 2)))))))                               (fill-rect self pen-pattern topleft bottomright)))                    (:down (Move-To self horizontal-middle                                                (+ (- (view-height self) (round vertical-space 2) 2)                                                   arrow-offset))                               (loop                                  (Line self width 0)                                  (incf width)                                  (Move self (- width) -1)                                  (incf width)                                  (when (> width arrow-width) (return)))                               (let ((topleft (make-point (- horizontal-middle (round (1- arrow-thickness) 2))                                                                         (- (1+ (point-v (pen-position self)))                                                                             (- arrow-height (1+ (round arrow-width 2))))))                                       (bottomright (make-point (+ horizontal-middle (round arrow-thickness 2))                                                                                (1+ (point-v (pen-position self))))))                                   (fill-rect self pen-pattern topleft bottomright)))                    (:left (Move-To self                                              (+ (round horizontal-space 2)                                                  1                                                 arrow-offset)                                             vertical-middle)                             (loop                                (Line self 0 width)                                (incf width)                                (Move self 1 (- width))                                (incf width)                                (when (> width arrow-width) (return)))                             (let ((topleft (make-point (point-h (pen-position self))                                                                       (- vertical-middle (round (1- arrow-thickness) 2))))                                     (bottomright (make-point (+ (point-h (pen-position self))                                                                                  (- arrow-height (1+ (round arrow-width 2))))                                                                              (+ vertical-middle (1+ (round (1- arrow-thickness) 2))))))                                (fill-rect self pen-pattern topleft bottomright)))                    (:right (Move-To self                                               (- (view-width self) 2 (round horizontal-space 2)                                                  arrow-offset)                                              vertical-middle)                               (loop                                  (Line self 0 width)                                  (incf width)                                  (Move self -1 (- width))                                  (incf width)                                  (when (> width arrow-width) (return)))                               (let ((topleft (make-point (- (point-h (pen-position self))                                                                             (- arrow-height (1+ (round arrow-width 2))))                                                                         (- vertical-middle (round (1- arrow-thickness) 2))))                                       (bottomright (make-point (1+ (point-h (pen-position self)))                                                                                (+ vertical-middle (1+ (round (1- arrow-thickness) 2))))))                                  (fill-rect self pen-pattern topleft bottomright)))                                        ))))))     (defmethod view-invert ((self arrow-di))   (when (wptr self)       (invert-rect  self #@(2 2) (subtract-points (view-size self) #@(3 3)))       (with-pen-pattern (*white-pattern* (view-container self))           (view-frame-with-shade self))       (frame-rect self #@(0 0) (subtract-points (view-size self) #@(1 1)))));----------------------------------------------------------------------------#|(make-instance 'window    :view-size #@(200 100)    :view-position '(:top 40)    :window-type :document    :window-title "Up and Down Arrow"    :view-subviews    (list (make-instance 'arrow-di                :view-size #@(20 20) ;should always be even                :view-position #@(25 20)                :arrow-direction :up                :arrow-width 8                :dialog-item-action #'(lambda (di)                                                       (setf (enabled-p di) (not (enabled-p di)))                                                      (view-draw-contents di)))            (make-instance 'arrow-di                :view-size #@(20 20)                :view-position #@(155 20)                :arrow-direction :down                :dialog-item-action #'(lambda (di)                                                       (setf (enabled-p di) (not (enabled-p di)))                                                      (view-draw-contents di)))            (make-instance 'arrow-di                :view-size #@(20 20)                :view-position #@(25 60)                :arrow-direction :left                :dialog-item-action #'(lambda (di)                                                       (setf (enabled-p di) (not (enabled-p di)))                                                      (view-draw-contents di)))            (make-instance 'arrow-di                :view-size #@(20 20)                :view-position #@(155 60)                :arrow-direction :right                :dialog-item-action #'(lambda (di)                                                       (setf (enabled-p di) (not (enabled-p di)))                                                      (view-draw-contents di)))))            |#
(in-package :oou)(oou-provide :autoscrollable-dim);*****************************************************************                                    ;; Copyright � 1991-96 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; a dialog-item that can scroll. It is typically called by a subview that needs; a autoscroll-mechanisms ; ;; Changes (worth to be mentioned):; ------------------------------; none ;;*****************************************************************;*****************************************************************(oou-dependencies :simple-view-ce                  :draggable-dim                  ) (export '());------------------------------------------------------------------------(defclass autoscrollable-dim ()  ((autoscroll-area :initform 15                    :initarg :autoscroll-area                    :accessor autoscroll-area)   (scroll-amount :initform 5                  :initarg :scroll-amount                  :accessor scroll-amount)   (autoscroll-start-delay :initform 0.2                           :initarg :autoscroll-start-delay                           :accessor autoscroll-start-delay)   (auto-scroll-start-time :initform 0                           :accessor auto-scroll-start-time)   (last-auto-scroll-part :initform nil                          :accessor last-auto-scroll-part)))(defmethod do-autoscroll ((self autoscrollable-dim) scroll-direction initiator)  (declare (ignore initiator))   (with-slots (scroll-amount) self    (case scroll-direction      (:up (offset-view-scroll-position self 0 (* scroll-amount -1)))      (:fast-up (offset-view-scroll-position self 0 (* scroll-amount -1 4)))      (:down (offset-view-scroll-position self 0 scroll-amount ))      (:fast-down (offset-view-scroll-position self 0 (* scroll-amount 4)))      (:left (offset-view-scroll-position self (* scroll-amount -1) 0))      (:fast-left (offset-view-scroll-position self (* scroll-amount -1 4) 0))      (:right (offset-view-scroll-position self scroll-amount 0))      (:fast-right (offset-view-scroll-position self (* scroll-amount 4) 0)))))(defmethod in-auto-scroll-part ((self autoscrollable-dim) global-position)  (let ((last-part (last-auto-scroll-part self)))    (when (null last-part)      (setf (auto-scroll-start-time self)            (+ (get-internal-run-time)               (* (autoscroll-start-delay self) internal-time-units-per-second))))    (setf (last-auto-scroll-part self) (get-auto-scroll-part self global-position))    (if (> (get-internal-run-time)  (auto-scroll-start-time self))      (last-auto-scroll-part self)      nil)))#|old version      (defmethod get-auto-scroll-part ((self autoscrollable-dim) global-position)   (when (wptr self)    (with-slots (autoscroll-area) self      (let* ((top (point-v (add-points (if (typep self 'window)                                         (view-top-left self)                                         (view-to-global self (view-top-left self)))                                       (view-scroll-position self))))             (left (point-h (add-points (if (typep self 'window)                                          (view-top-left self)                                          (view-to-global self (view-top-left self)))                                        (view-scroll-position self))))             (bottom (point-v (add-points (if (typep self 'window)                                            (view-bottom-right self)                                            (view-to-global self (view-bottom-right self)))                                          (view-scroll-position self))))             (right (point-h (add-points (if (typep self 'window)                                           (view-bottom-right self)                                           (view-to-global self (view-bottom-right self)))                                         (view-scroll-position self))))             (global-h (point-h global-position))             (global-v (point-v global-position))             (part (cond ((and (< global-v top)                               (> global-v (- top autoscroll-area))                               (> global-h left)                               (< global-h right))                          (if (< global-v (- top (round autoscroll-area 2)))                            :fast-up                            :up))                         ((and (> global-v bottom)                               (< global-v (+ bottom autoscroll-area))                               (> global-h left)                               (< global-h right))                           (if (> global-v (+ bottom (round autoscroll-area 2)))                            :fast-down                            :down))                         ((and (< global-h left)                               (> global-h (- left autoscroll-area))                               (< global-v bottom)                               (> global-v top))                          (if (< global-h (- left (round autoscroll-area 2)))                            :fast-left                            :left))                         ((and (> global-h right)                               (< global-h (+ right autoscroll-area))                               (< global-v bottom)                               (> global-v top))                          (if (> global-h (+ right (round autoscroll-area 2)))                            :fast-right                            :right)))))         part))))|#(defmethod get-auto-scroll-part ((self autoscrollable-dim) global-position)   (when (wptr self)    (with-slots (autoscroll-area) self      (let* ((top (point-v (add-points (global-view-position self)                                       (view-scroll-position self))))             (left (point-h (add-points (global-view-position self)                                        (view-scroll-position self))))             (bottom (point-v (add-points (global-bottom-right self)                                          (view-scroll-position self))))             (right (point-h (add-points (global-bottom-right self)                                         (view-scroll-position self))))             (global-h (point-h global-position))             (global-v (point-v global-position))             (part (cond ((and (< global-v top)                               (> global-v (- top autoscroll-area))                               (> global-h left)                               (< global-h right))                          (if (< global-v (- top (round autoscroll-area 2)))                            :fast-up                            :up))                         ((and (> global-v bottom)                               (< global-v (+ bottom autoscroll-area))                               (> global-h left)                               (< global-h right))                           (if (> global-v (+ bottom (round autoscroll-area 2)))                            :fast-down                            :down))                         ((and (< global-h left)                               (> global-h (- left autoscroll-area))                               (< global-v bottom)                               (> global-v top))                          (if (< global-h (- left (round autoscroll-area 2)))                            :fast-left                            :left))                         ((and (> global-h right)                               (< global-h (+ right autoscroll-area))                               (< global-v bottom)                               (> global-v top))                          (if (> global-h (+ right (round autoscroll-area 2)))                            :fast-right                            :right)))))         part))))(defmethod hide-drag-rect-p ((self autoscrollable-dim) (draggable-view draggable-dim) global-position)  (or (call-next-method)      (get-auto-scroll-part self global-position)))(defmethod draggable-dim-is-above ((self autoscrollable-dim) (draggable-view draggable-dim) global-position)  (let ((scroll-direction (in-auto-scroll-part self global-position)))    (when scroll-direction       (do-autoscroll self scroll-direction draggable-view))));------------------------------------------------------------------------(defclass autoscrollable-fred-mixin (autoscrollable-dim)  ((scroll-direction :initform :in-thumb                     :accessor scroll-direction)   ))(defmethod do-autoscroll ((self autoscrollable-fred-mixin) scroll-direction initiator)  (declare (ignore initiator))  (when scroll-direction    (case scroll-direction      (:up (do-vscroll self :in-up-button))      (:fast-up (do-vscroll self :in-fast-up-button))      (:down (do-vscroll self :in-down-button))      (:fast-down (do-vscroll self :in-fast-down-button))      (:left (do-hscroll self :in-up-button))      (:fast-left (do-hscroll self :in-fast-up-button))      (:right (do-hscroll self :in-down-button))      (:fast-right (do-hscroll self :in-fast-down-button)))))          (defmethod do-hscroll ((self autoscrollable-fred-mixin) part)  (when part    (setf (scroll-direction self) :horizontal)    (set-fred-hscroll self                      (max 0                           (min (if (eq part :in-thumb)                                  (scroll-bar-setting (h-scroller self))                                  (+ (fred-hscroll self)                                     (case part                                       (:in-up-button -8)                                       (:in-fast-up-button -32)                                       (:in-down-button  8)                                       (:in-fast-down-button 32)                                       (:in-page-up (- (ash (view-height self) -1)))                                       (:in-page-down (ash (view-height self) -1)))))                                (- (ccl::frec-hmax (frec self)) 20))))    (fred-update self)))(defmethod do-vscroll ((self autoscrollable-fred-mixin) part)  (when part    (let* ((mark (fred-display-start-mark self))           (buffer (fred-buffer self))           (frec (frec self))           (vsize (point-v (ccl::frec-full-lines frec)))           (h (point-h (ccl::frec-pos-point frec mark)))           (new-pos (if (eq part :in-thumb)                      (buffer-line-start buffer (scroll-bar-setting (v-scroller self)))                      (buffer-line-start buffer mark                                         (case part                                           (:in-up-button -1)                                           (:in-fast-up-button -7)                                           (:in-down-button 1)                                           (:in-fast-down-button 7)                                           (:in-page-up (ccl::find-frec-prev-page frec mark))                                           (:in-page-down                                             (or   (ccl::frec-point-pos frec (make-point h vsize))                                                  (buffer-size buffer))))))))      (unless (= new-pos (buffer-position mark))        (setf (scroll-direction self) part)        (set-mark mark new-pos)        (fred-update self)        ))))(defclass autoscrollable-fred-window (autoscrollable-fred-mixin fred-window)  ())
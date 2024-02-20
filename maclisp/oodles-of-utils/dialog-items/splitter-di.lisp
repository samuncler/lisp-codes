(in-package :oou)(oou-provide :splitter-di);*****************************************************************                                    ;; Copyright � 1991-96 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; a simple-view to split two views; ;; Changes (worth to be mentioned):; ------------------------------; 11/96  Dieter : drag modified;;*****************************************************************;*****************************************************************(require :QuickDraw)(oou-dependencies :unibas-macros                  :unibas-cursors                  :simple-view-ce                  :view-ce)(export '(view-splitter direction window splitted-views min-size           set-view-splitter-correct-position));---------------------------------------------------------------------------(defclass view-splitter (simple-view)  ((direction :initarg :direction               :initform :vertical              :reader direction)   (splitted-views :initarg :splitted-views                   :initform nil                    :accessor splitted-views)   (min-size :initform 40             :initarg :min-size             :accessor min-size)   (offset :initform 0           :initarg :offset           :accessor offset)   (after-split-function :initform nil                         :initarg :after-split-function                         :accessor after-split-function))  (:default-initargs :view-size #@(16 5)))(defmethod view-draw-contents ((splitter view-splitter))  (let* ((topleft (view-position splitter))         (bottomright (add-points topleft (view-size splitter))))    (rlet ((r :rect :topleft topleft :botright bottomright))      (#_FillRect :ptr r :ptr *black-pattern*))))(defmethod view-cursor ((self view-splitter) point)  (declare (ignore point))  *full-hand-cursor*)(defmethod view-click-event-handler ((splitter view-splitter) where)  (declare (ignore where))  (multiple-value-bind (s-tl s-br) (view-splitter-corners splitter)    (let* ((window (view-window splitter))           (wait-ticks (max 1 (floor internal-time-units-per-second 30)))           (mouse-pos (view-mouse-position window))           min-pos max-pos drawn time pos pos-accessor)      (case (direction splitter)        (:vertical         (setf min-pos (1+ (point-v s-tl))               max-pos (- (point-v s-br) 2)               pos (point-v mouse-pos)               pos-accessor #'point-v))        (:horizontal         (setf min-pos (1+ (point-h s-tl))               max-pos (- (point-h s-br) 2)               pos (point-h mouse-pos)               pos-accessor #'point-h )))      (labels ((draw-line (pos)                 (draw-outlines splitter (corrected-pos pos))                 (setf drawn (not drawn)                       time (get-internal-run-time)))               (corrected-pos (pos)                 (cond ((in-reduce-to-zero-area-p splitter pos)                        (if (< pos (first-view-border splitter))                          (first-view-pos splitter)                          (second-view-border splitter)))                       (t                        (min max-pos (max min-pos pos))))))        (declare (dynamic-extent draw-line))        (with-focused-view window          (with-pen-saved            (#_PenPat :ptr *gray-pattern*)            (#_PenMode :word (position :srcxor *pen-modes*))            (draw-line pos)            (unwind-protect              (loop                (unless (mouse-down-p) (return))                (let* ((new-mouse (view-mouse-position window))                       (new-pos (funcall pos-accessor new-mouse)))                  (unless (or (eql mouse-pos new-mouse)                              (<= (get-internal-run-time) (+ time wait-ticks)))                    (when (and drawn                                (not (eql new-pos pos)))                      (draw-line pos))                    (setf pos new-pos                           mouse-pos new-mouse)                    (when (not drawn)                      (draw-line pos)))))              (when drawn                 (draw-line pos)))))        (split-views splitter (corrected-pos pos))))))(defmethod draw-outlines ((splitter view-splitter) pos)  (let ((window (view-window splitter)))    (with-focused-view window      (multiple-value-bind (topleft bottomright) (view-splitter-corners splitter)        (case (direction splitter)          (:vertical           (let ((v-correction (round (view-height splitter) 2)))             (#_MoveTo (point-h bottomright) (- pos v-correction))             (#_LineTo (point-h topleft) (- pos v-correction))             (#_MoveTo (point-h bottomright) (+ pos v-correction))             (#_LineTo (point-h topleft) (+ pos v-correction))))          (:horizontal           (let ((h-correction (round (view-width splitter) 2)))             (#_MoveTo (- pos h-correction) (point-v bottomright))             (#_LineTo (- pos h-correction) (point-v topleft))             (#_MoveTo (+ pos h-correction) (point-v bottomright))             (#_LineTo (+ pos h-correction) (point-v topleft)))))))))(defmethod show-subview :before ((self view) (splitter view-splitter) &optional pos)  (declare (ignore pos))  (set-view-splitter-correct-position splitter))(defmethod install-view-in-window :before ((splitter view-splitter) window)  (declare (ignore window))   (set-view-splitter-correct-position splitter))(defmethod view-splitter-correct-position ((splitter view-splitter))  (with-slots (direction splitted-views offset) splitter    (cond (splitted-views           (case direction             (:vertical              (make-point (+ (max (view-right (car splitted-views))                                  (view-right (cadr splitted-views)))                             (- (view-width splitter))                             offset)                          (+ (first-view-border splitter)                             (round (- (second-view-pos splitter)                                       (first-view-border splitter)                                       (view-height splitter))                                    2))))             (:horizontal              (make-point (+ (first-view-border splitter)                             (round (- (second-view-pos splitter)                                       (first-view-border splitter)                                       (view-width splitter))                                    2))                          (+ (max (view-bottom (car splitted-views))                                  (view-bottom (cadr splitted-views)))                             (- (view-height splitter))                             offset)))))          (t           (hide-subview (view-container splitter) splitter)           #@(-100 -100)))))(defmethod set-view-splitter-correct-position ((splitter view-splitter))  (set-view-position splitter (view-splitter-correct-position splitter)))(defmethod view-splitter-corners ((splitter view-splitter))  (with-slots (direction min-size splitted-views) splitter    (when splitted-views      (let ((first-view (first-view splitter))            (second-view (second-view splitter)))        (case direction          (:vertical           (values (make-point (- (view-left first-view) 2)                               (+ (view-top  first-view)                                  min-size))                   (make-point (view-right splitter)                               (max (- (view-bottom second-view)                                       min-size)                                    min-size))))          (:horizontal           (values (make-point (+ (view-left first-view)                                  min-size)                               (view-top first-view))                   (make-point (max (- (view-right second-view)                                       min-size)                                    min-size)                               (view-bottom splitter)))))))))(defmethod split-views ((self view-splitter) pos)  (with-slots (direction after-split-function) self    (let* ((first-view (first-view self))           (second-view (second-view self))           (view-at-pos (if (< pos (first-view-border self))                          first-view                          second-view)))      (cond ((in-reduce-to-zero-area-p self pos)             (reduce-subview-to-zero view-at-pos))            (t             (let ((delta-h (- (view-left self) pos))                   (delta-v (- (view-top self) pos))                   (window (view-window self)))               (case direction                 (:vertical                  (set-view-size first-view (view-width first-view) (- (view-height first-view) delta-v))                  (set-view-position second-view (view-left second-view) (- (view-top second-view) delta-v))                  (set-view-size second-view (view-width second-view) (+ (view-height second-view) delta-v)))                 (:horizontal                  (set-view-size first-view (- (view-width first-view) delta-h) (view-height first-view))                  (set-view-position second-view (- (view-left second-view) delta-h) (view-top second-view))                  (set-view-size second-view (+ (view-width second-view) delta-h) (view-height second-view))))               (map-subviews window #'set-view-splitter-correct-position 'view-splitter)               (when after-split-function                 (funcall after-split-function self))))))))(defmethod first-view ((splitter view-splitter))  (with-slots (direction splitted-views) splitter    (case direction       (:vertical (if (<= (view-top (car splitted-views))                         (view-top (cadr splitted-views)))                   (car splitted-views)                   (cadr splitted-views)))      (:horizontal (if (<= (view-left (car splitted-views))                           (view-left (cadr splitted-views)))                     (car splitted-views)                     (cadr splitted-views))))))(defmethod second-view ((splitter view-splitter))  (with-slots (direction splitted-views) splitter    (case direction      (:vertical (if (> (view-top (car splitted-views))                        (view-top (cadr splitted-views)))                   (car splitted-views)                   (cadr splitted-views)))      (:horizontal (if (> (view-left (car splitted-views))                          (view-left (cadr splitted-views)))                     (car splitted-views)                     (cadr splitted-views))))))(defmethod first-view-pos ((splitter view-splitter))  (case (direction splitter)    (:vertical     (view-top (first-view splitter)))    (:horizontal     (view-left (first-view splitter)))))(defmethod first-view-border ((splitter view-splitter))  (case (direction splitter)    (:vertical     (view-bottom (first-view splitter)))    (:horizontal     (view-right (first-view splitter)))))(defmethod second-view-pos ((splitter view-splitter))  (case (direction splitter)    (:vertical     (view-top (second-view splitter)))    (:horizontal     (view-left (second-view splitter)))))(defmethod second-view-border ((splitter view-splitter))  (case (direction splitter)    (:vertical     (view-bottom (second-view splitter)))    (:horizontal     (view-right (second-view splitter)))))(defmethod in-reduce-to-zero-area-p ((splitter view-splitter) pos)  (let ((reduction-width 15))    (or (< (- pos (first-view-pos splitter)) reduction-width)        (< (- (second-view-border splitter) pos) reduction-width))))(defmethod reduce-subview-to-zero ((self simple-view))  (ed-beep)  (ed-beep));---------------------------------------------------------------------------                    #|(let* ((topleft (make-instance 'sequence-dialog-item                  :view-size #@(150 80)                  :view-position #@(10 10)                  :table-sequence '(aa bb cc)))       (bottomleft (make-instance 'sequence-dialog-item                     :view-size #@(166 100)                     :view-position #@(20 100)))       (bottomright (make-instance 'sequence-dialog-item                      :view-size #@(150 100)                      :view-position #@(200 110)))       (window (make-instance 'window                 :window-type :document                 :view-size #@(400 250)                 :view-position :centered                 :window-title "A Window with Splitters"                 :view-subviews                 (list topleft bottomleft bottomright))))  (add-view-splitter window (list :vertical (list topleft bottomleft)))  (add-view-splitter window (list :horizontal (list bottomleft bottomright)                                   80                                   #@(10 20)                                  nil                                  #'(lambda (splitter)                                      (format t                                              "~A splitted"                                              (splitted-views splitter))))))(let* ((topleft (make-instance 'sequence-dialog-item                  :view-size #@(150 80)                  :view-position #@(10 10)                  :table-sequence '(aa bb cc)))       (bottomleft (make-instance 'sequence-dialog-item                     :view-size #@(166 100)                     :view-position #@(20 100)))       (bottomright (make-instance 'sequence-dialog-item                      :view-size #@(150 100)                      :view-position #@(200 110))))  (make-instance 'window                 :window-type :document                 :view-size #@(400 250)                 :view-position :centered                 :window-title "A Window with Splitters"                 :view-subviews                 (list topleft bottomleft bottomright))  (insert-view-splitter topleft bottomleft :direction :vertical)  (insert-view-splitter bottomleft bottomright                         :direction :horizontal                         :view-min-size 80                         :splitter-size #@(10 20)                        :after-split-function #'(lambda (splitter)                                                  (format t                                                          "~A splitted"                                                          (splitted-views splitter))))) |#
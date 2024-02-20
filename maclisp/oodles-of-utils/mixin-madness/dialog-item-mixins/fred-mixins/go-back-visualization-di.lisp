(in-package :oou)(oou-provide :go-back-visualization-di);*****************************************************************                                    ;; Copyright � 1996 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; visualization for the go-back-to-last-edit-mark feature ;; Changes (worth to be mentioned):; ------------------------------; none ;;*****************************************************************;*****************************************************************(oou-dependencies  ) (export '(          ));-----------------------------------------------------------------(defclass go-back-visualization-di (color-svm view)  ((go-back-rect :initform (make-record :rect :left 0 :right 4)                 :accessor go-back-rect))  (:default-initargs     :view-nick-name :go-back-visualization-di))(defmethod install-view-in-window :after ((view go-back-visualization-di) (win window))  (declare (ignore initargs))  (setf (back-color view) (get-back-color win)))(defmethod view-click-event-handler ((view go-back-visualization-di) where)   (when (point-in-rect-p (go-back-rect view) where)    (let ((fred (main-fred-item (view-window view))))      (go-back-to-last-edit-mark fred)      (fred-update fred))))(defmethod view-cursor ((view go-back-visualization-di) where)   (cond ((point-in-rect-p (go-back-rect view) where)         *right-hand-cursor*)        (t *arrow-cursor*)))  (defmethod new-v-pos ((view go-back-visualization-di))  (let* ((fred (main-fred-item (view-window view)))         (last-edit-start-mark (car (last-edit-mark fred)))         (scroll-height (- (view-height view) 47))         (buffer-size (buffer-size (fred-buffer fred)))         (percentage (if (zerop buffer-size)                                 0                                 (round (* (/ last-edit-start-mark buffer-size) 100))))         (thumb-offset (* 0.15 percentage)))    (round (+ 16               7.5               (- thumb-offset)              (/ (* scroll-height percentage) 100)))))(defmethod draw-go-back-rect ((view go-back-visualization-di) &optional (v-pos (new-v-pos view)))  (rset (go-back-rect view) :rect.top (- v-pos 6))  (rset (go-back-rect view) :rect.bottom (+ v-pos 6))  (with-focused-view view    (with-pen-mode (:PatXOr view)      (fill-rect view *black-pattern* 0 (- v-pos 6) 2 (+ v-pos 6)))))          (defmethod update-go-back-rect ((view go-back-visualization-di))  (let* ((new-v-pos (new-v-pos view))         (old-v-pos (+ 6 (rref (go-back-rect view) :rect.top))))    (unless (= new-v-pos old-v-pos)      (erase-rect view 0 (- old-v-pos 6) 2 (+ old-v-pos 6))      (draw-go-back-rect view new-v-pos))))(defmethod view-draw-contents :after ((view go-back-visualization-di))   (draw-go-back-rect view))(defmethod set-view-size :before ((view go-back-visualization-di) h &optional v)  (declare (ignore h v))  (erase-view view))#|for an example see'oodles-of-utils:mixin-madness:dialog-item-mixins:fred-mixins:go-back-fred-mixin.lisp"|#
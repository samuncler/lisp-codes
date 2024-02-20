(in-package :oou)(oou-provide :scrollable-sequence-di);*******************************************************************                                    ;; Copyright � 1991-96 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; a sequence-dialog-item with a vertical scrollbar; ;; Changes (worth to be mentioned):; ------------------------------; none ;;*******************************************************************;*******************************************************************(oou-dependencies :scrollable-view                              )(export '(scrollable-sequence-di));----------------------------------------------------------------------------(defclass embedded-sequence-di (sequence-dialog-item) ()  (:default-initargs    :table-vscrollp nil    :table-hscrollp nil))(defmethod view-activate-event-handler :before ((self embedded-sequence-di))    (when (and (view-container self)                     (view-named :real-view (view-container self))                     (view-named :v-scroller (view-container self)))        (adjust-table-and-scrollbar self)))(defmethod adjust-table-and-scrollbar ((self embedded-sequence-di))   (when (and (view-size self)                     (cell-size self))       (let ((new-cell-size (make-point (view-width self)                                                            (point-v (cell-size self)))))          (unless (= (cell-size self) new-cell-size)             (set-cell-size self new-cell-size))))   (when (view-window self)       (let ((v-scroller (view-named :v-scroller (view-container self)))               (visible-length (point-v (visible-dimensions self))))          (setf (sb-max v-scroller)                    (max (- (point-v (table-dimensions self))                                visible-length)                            (or (sb-min v-scroller)                                  0)))          (setf (sb-page-size v-scroller)                   visible-length)          (setf (sb-setting v-scroller) (point-v (scroll-position self))))))(defmethod set-view-size :after ((self embedded-sequence-di) h &optional v)    (declare (ignore h v))   (adjust-table-and-scrollbar self))(defmethod set-table-sequence :after ((self embedded-sequence-di) sequence)   (declare (ignore sequence))   (scroll-to-cell self 0)   (adjust-table-and-scrollbar self)   (invalidate-view self));----------------------------------------------------------------------------(defclass scrollable-sequence-di (color-svm vertical-scrollable-view)   ()   (:default-initargs      :view-class 'embedded-sequence-di     :back-color *white-color*     :v-scroll-action      #'(lambda (item part)           (declare (ignore part))           (let ((table (sb-scrollee item))                   (new-position (sb-setting item)))              (when new-position                  (scroll-to-cell table                                           (point-h (scroll-position table))                                           new-position))))     :init-function      #'(lambda (view real-view h-scroller v-scroller)           (declare (ignore view h-scroller))           (setf (sb-max v-scroller)                    (point-v (table-dimensions real-view)))           (setf (sb-scroll-size v-scroller) 1))));----------------------------------------------------------------------------#|(make-instance 'unibas-paned-window    :window-title "Scroll the table"    :view-size #@(100 200)    :view-position :centered    :subview-description    (list (list (make-instance 'scrollable-sequence-di                        :view-size #@(50 150)                        :view-position #@(5 5)                        :view-initargs '(:table-sequence                                                   (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20                                                     21 22 23 24 25 26 27 28 29 30)))                    :adjust-h-v                    :stick-on-topleft)))|#
(in-package :oou)(oou-provide :droppable-window);*****************************************************************                                    ;; Copyright � 1991 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; A window with drag and drop.; ;; Changes (worth to be mentioned):; ------------------------------; none ;;*****************************************************************;*****************************************************************(oou-dependencies :special-events-dim                              :droppable-dim                              )(export '(droppable-window));--------------------------------------------------------------------------(defclass droppable-window (droppable-dim special-events-dim window)   ())(defmethod pre-drag-hilite ((di droppable-window) hilite-flag)    (declare (ignore hilite-flag))    nil)(defmethod draggable-p ((self droppable-window) &optional view-position)    "a window is only draggable through a click into the drag region"   (multiple-value-bind (win part) (window-at-position (view-to-global self view-position))       (declare (ignore win))       (= part 4)))(defmethod view-cursor ((self droppable-window) where)   (declare (ignore where))   *arrow-cursor*)(defmethod draggable-view-enters ((self drop-target-dim) (droppable-view droppable-window) global-mouse-pos)    (declare (ignore droppable-view global-mouse-pos))    (with-focused-view self         (hilite-view self t)))#|(defclass test-drag-window (droppable-window)   ()   (:default-initargs     :window-title "Droppable Window"     :view-size #@(250 150)     :view-position '(:top 100)     :drag-action-fn #'(lambda (di) (declare (ignore di)) (print "drag"))))(defmethod view-click-event-handler ((self test-drag-window) where)   (declare (ignore where))   (ed-beep))(defmethod window-drag-event-handler :after ((self test-drag-window) global-position)   (declare (ignore global-position))   (format t "~%'~A' was dragged around" (window-title self)))(make-instance 'test-drag-window)(defclass target-win (drop-target-dim window)   ()   (:default-initargs      :window-title "Target Window"     :view-size #@(180 100)))(defmethod dropped ((self target-win) droppable-window offset where)   (declare (ignore offset where))   (format t "~%'~A' has been dropped on '~A'"                 (window-title droppable-window)                (window-title self)))(make-instance 'target-win)|#
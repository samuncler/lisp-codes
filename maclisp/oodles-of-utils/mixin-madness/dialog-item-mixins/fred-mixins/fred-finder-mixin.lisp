(in-package :oou)(oou-provide :fred-finder-mixin);******************************************************************************                                    ;; Copyright � 1995 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; a mixin for receiving drags from outside MCL;; Changes (worth to be mentioned):; ------------------------------; April 1995  Dieter : Modifications for MCL 3.0;;*******************************************************************************;*******************************************************************************(oou-dependencies :receive-finder-drags                  :scrollable-fred-di) (export '(          ));-------------------------------------------------------------------------------;-------------------------------------------------------------------------------(defclass fred-receive-finder-drags-mixin (receive-finder-drags-mixin)  ())(defmethod view-drag-hilite :around ((view fred-receive-finder-drags-mixin) hilite &optional arg1 arg2)  (declare (ignore hilite arg1 arg2))  (draw-dummy-cursor view)  (setf (dummy-cursor-pos view) nil)  (call-next-method)  (draw-dummy-cursor view))(defmethod draggable-dim-is-above :around ((self fred-receive-finder-drags-mixin) (flavor-type (eql :|hfs |)) global-position)  (declare (ignore flavor-type where))  (if (in-text-area self (global-to-view self global-position))    (adjust-dummy-cursor self nil global-position)    (call-next-method)))(defmethod draggable-dim-is-above :around ((self fred-receive-finder-drags-mixin) (flavor-type (eql :|TEXT|)) global-position)  (declare (ignore flavor-type where))  (if (in-text-area self (global-to-view self global-position))    (adjust-dummy-cursor self nil global-position)    (call-next-method)))(defmethod draggable-view-enters :around ((self fred-receive-finder-drags-mixin) (flavor-type (eql :|hfs |)) global-mouse-pos)    (declare (ignore global-mouse-pos flavor-type))    (setf (dummy-cursor-pos self) nil)     (draw-dummy-cursor self)    (call-next-method))(defmethod draggable-view-enters :around ((self fred-receive-finder-drags-mixin) (flavor-type (eql :|TEXT|)) global-mouse-pos)    (declare (ignore global-mouse-pos flavor-type))    (setf (dummy-cursor-pos self) nil)     (draw-dummy-cursor self)    (call-next-method))(defmethod draggable-view-leaves :around ((self fred-receive-finder-drags-mixin) (flavor-type (eql :|hfs |)) global-mouse-pos)    (declare (ignore flavor-type global-mouse-pos))    (draw-dummy-cursor self)    (setf (dummy-cursor-pos self) nil)    (call-next-method))(defmethod draggable-view-leaves :around ((self fred-receive-finder-drags-mixin) (flavor-type (eql :|TEXT|)) global-mouse-pos)    (declare (ignore flavor-type global-mouse-pos))    (draw-dummy-cursor self)    (setf (dummy-cursor-pos self) nil)    (call-next-method))(defmethod dropped ((view fred-receive-finder-drags-mixin) (str string) offset where)  (declare (ignore offset))  (draw-dummy-cursor view)  (setf (dummy-cursor-pos view) nil)  (setf where (global-to-view view where))  (let* ((buff (fred-buffer view)))    (cond ((in-selection view where)           (multiple-value-bind (sel-start sel-end) (selection-range view)             (buffer-delete buff sel-start sel-end)))          (t            (collapse-selection view t)           (set-mark buff (fred-point-position view where))))    (let* ((start (buffer-position buff))           (hpos (fred-hpos view start)))      (when (< hpos 10)        (set-fred-hscroll view (max (+ (fred-hscroll view)  hpos -10) 0)))      (buffer-insert buff str)      (set-selection-range view start (buffer-position buff))))  (fred-update view)  t)(defmethod dropped ((view fred-receive-finder-drags-mixin) (path pathname) offset where)  (declare (ignore offset))  (let* ((buff (fred-buffer view))         (new-pos (min (fred-point-position view (global-to-view view where))                       (buffer-size buff))))    (setf (dummy-cursor-pos view) nil)    (collapse-selection view t)    (fred-update view)    (set-mark buff new-pos)    (cond ((directoryp path)           (buffer-insert buff (namestring path) new-pos))          ((string-equal (pathname-type path) "ps")           (if (and (or (option-key-p)                        (command-key-p))                    (probe-file path))             (buffer-insert-file buff path new-pos)                          (buffer-insert buff (namestring path) new-pos)))          ((and (probe-file path)                (or (eq (mac-file-type path) :|TEXT|)                    (eq (mac-file-type path) :|ttro|)))           (if (or (option-key-p)                   (command-key-p))             (buffer-insert buff (namestring path) new-pos)             (buffer-insert-file buff path new-pos)))          (t (buffer-insert buff (namestring path) new-pos)))    (set-selection-range view new-pos (selection-range view))    (fred-update view)    t))#|(defclass my-fred-item (drag-and-drop-fred-mixin fred-receive-finder-drags-mixin fred-item)    ())(defclass receive-finder-drags-window (window drag-&-drop-window-mixin)  ())(make-instance 'receive-finder-drags-window     :view-size #@(400 300)     :view-subviews (list (setf fff (make-instance 'scrolling-fred-view                                              :fred-item-class 'my-fred-item                                              :allow-returns t                                              :view-position #@(50 50)                                              :view-size #@(300 200)))))|#
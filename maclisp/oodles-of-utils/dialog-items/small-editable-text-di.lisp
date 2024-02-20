(in-package :oou)(oou-provide :small-editable-text-di);----------------------------------------------------------------------------------                                 ;; Copyright � 1991 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; ;; Changes (worth to be mentioned):; ------------------------------;;-----------------------------------------------------------------------------------;-----------------------------------------------------------------------------------(oou-dependencies :simple-view-ce                  :real-pop-up-menu                  :font-info                  :layout-system                  )(export '(embedded-editable-text-dialog-item-mixin small-editable-text-di          default-embedded-editable-text-di          ));----------------------------------------------------------------------------------(defclass insertion-menu-item (menu-item)  ((insertion-text :initform ""                   :accessor insertion-text                   :initarg :insertion-text)   (editable-text-di :initform nil                     :initarg :editable-text-di                     :accessor editable-text-di))  (:default-initargs     :menu-item-action    #'(lambda (menu-item)        (insert-new-text (or (insert-in-view menu-item)                             (editable-text-di menu-item))                         (insertion-text menu-item)))))(defmethod menu-item-action ((self insertion-menu-item))  (funcall (menu-item-action-function self) self))(defmethod insert-in-view ((self insertion-menu-item))  nil);-----------------------------------------------------------------------------------(defclass embedded-editable-text-dialog-item-mixin ()  ((small-draw-outline :initform t                       :initarg :small-draw-outline                       :accessor small-draw-outline)   (old-modcnt :initform nil               :accessor old-modcnt))  (:default-initargs     :view-font '("Geneva" 9)    :text-edit-sel-p nil    :draw-outline nil))(defmethod view-cursor :around ((self embedded-editable-text-dialog-item-mixin) where)  (if (in-point-area (view-container self) (view-to-container self where))    *full-hand-cursor*    (call-next-method)))(defmethod draw-point ((self embedded-editable-text-dialog-item-mixin))  (let ((container (view-container self)))    (when container      (with-pen-pattern ((view-pattern container) container)        (with-slots (point-radius) container          (multiple-value-bind (center-h center-v) (center-of-point container)            (paint-oval container                        (make-point (round (- center-h point-radius))                                    (round (- center-v point-radius)))                        (make-point (round (+ center-h point-radius))                                    (round (+ center-v point-radius))))))))))                      (defmethod fred-update :after ((self embedded-editable-text-dialog-item-mixin))  (draw-point self))(defmethod view-draw-contents :after ((self embedded-editable-text-dialog-item-mixin))  (let ((container (view-container self)))    (when (wptr self)      (with-focused-view container        (when (small-draw-outline self)          (with-pen-pattern ((view-pattern container) container)            (frame-rect container                         (subtract-points (view-top-left self) #@(3 1))                        (add-points (view-bottom-right self) #@(1 1))))))      (draw-point self))))(defmethod fred-blink-position ((self embedded-editable-text-dialog-item-mixin))    nil)(defmethod initialize-instance :after ((self embedded-editable-text-dialog-item-mixin) &rest initargs)  (declare (ignore initargs))  (setf (old-modcnt self) (buffer-modcnt (fred-buffer self))))(defmethod fred-update :before ((self embedded-editable-text-dialog-item-mixin))   (when (and (wptr self)             (/= (old-modcnt self) (buffer-modcnt (fred-buffer self))))    (adjust-view-sizes (view-container self) self))  (setf (old-modcnt self) (buffer-modcnt (fred-buffer self))))(defclass default-embedded-editable-text-di (embedded-editable-text-dialog-item-mixin editable-text-dialog-item)  ());------------------------------------------------------------------------------------(defclass small-editable-text-di (layout-mixin view)  ((editable-text-class :initform 'default-embedded-editable-text-di                        :initarg :editable-text-class                        :accessor editable-text-class)   (menu-class :initform 'real-pop-up-menu               :initarg :menu-class               :accessor menu-class)   (pop-up-menu :initform nil                :accessor pop-up-menu                :initarg :pop-up-menu)   (clear-text :initform nil               :accessor clear-text               :initarg :clear-text)   (before-method :initform nil                  :accessor before-method                  :initarg :before-method)   (after-method :initform nil                 :accessor after-method                 :initarg :after-method)   (border :initform 3           :accessor border           :initarg :border)   (point-radius :initform 2.5                 :accessor point-radius                 :initarg :point-radius)   (items :initform nil          :accessor items          :initarg :items)   (view-pattern :initform *black-pattern*                 :accessor view-pattern                 :initarg :view-pattern)   (max-width :initform 100              :accessor max-width              :initarg :max-width)   (margin :initform 15              :accessor margin              :initarg :margin)   (adjust-size-p :initform t                  :accessor adjust-size-p                  :initarg :adjust-size-p)))(defmethod initialize-instance :after ((self small-editable-text-di) &rest initargs)  (declare (ignore initargs))  (with-slots (border editable-text-class menu-class pop-up-menu max-width margin adjust-size-p) self    (let* ((menu (or pop-up-menu                     (make-instance menu-class                       :menu-items (items self))))           (editable-text (make-instance editable-text-class                            :view-nick-name :editable-text)))      (set-view-size editable-text max-width (font-line-height (view-font editable-text)))      (setf pop-up-menu menu)      (adjust-view-sizes self editable-text)      (labels ((set-action-function (menu)                 (dolist (menu-item (menu-items menu))                   (if (typep menu-item 'menu)                     (set-action-function menu-item)                     (setf (editable-text-di menu-item) self)))))        (set-action-function menu))      (setf (layout self)            (:vbox ()                   1                    (:hbox ()                          border                          (:fbox (:width :filler :height :filler) editable-text)                          border)                   1)))))(defmethod adjust-view-sizes ((self small-editable-text-di) editable-text)  (when (adjust-size-p self)    (with-slots (adjust-size-p max-width margin border) self      (let ((new-size (add-points (make-point (+ margin (- (+ (fred-hpos editable-text (buffer-size (fred-buffer editable-text)))                                                              (fred-hscroll editable-text))                                                           (ccl::fr.margin (frec editable-text))))                                              (fr-line-height editable-text 0))                                  (make-point (* border 2) 3))))        (unless (eq new-size (view-size self))          (set-view-size self new-size)          (set-fred-hscroll editable-text 0))))))(defmethod view-click-event-handler :around ((self small-editable-text-di) where)  (if (in-point-area self where)    (progn      (set-current-key-handler (view-window self) (view-named :editable-text self) nil)      (menu-select (pop-up-menu self) self))    (call-next-method)))(defmethod in-point-area ((self small-editable-text-di) where)  (with-slots (point-radius) self    (multiple-value-bind (center-h center-v) (center-of-point self)      (and (<= (point-h where) (+ center-h point-radius))           (>= (point-h where) (- center-h point-radius))           (<= (point-v where) (+ center-v point-radius))           (>= (point-v where) (- center-v point-radius))))))(defmethod center-of-point ((self small-editable-text-di))  (with-slots (border point-radius) self    (values (- (view-width self) border point-radius 1)            (+ 1 point-radius 1))))(defmethod insert-new-text ((di small-editable-text-di) new-text)  (let* ((editable-text (view-named :editable-text di))         (fred-buffer (fred-buffer editable-text)))    (when (before-method di)      (funcall (before-method di) di new-text))    (when (or (and (clear-text di)                   (not (option-key-p)))              (and (not (clear-text di))                   (option-key-p)))      (buffer-delete fred-buffer 0 t))    (multiple-value-bind (start-pos end-pos) (selection-range editable-text)      (when (/= start-pos end-pos)        (buffer-delete fred-buffer  start-pos end-pos)        (set-mark fred-buffer start-pos)))    (buffer-insert fred-buffer new-text)    (adjust-view-sizes di editable-text)    (when (after-method di)      (funcall (after-method di) di new-text))    (fred-update editable-text)))(defmethod (setf items) :after (newvalue (self small-editable-text-di))  (let ((menu (pop-up-menu self)))    (when (menu-items menu)      (apply #'remove-menu-items menu (menu-items menu)))    (apply  #'add-menu-items menu newvalue)    (labels ((set-action-function (menu)               (dolist (menu-item (menu-items menu))                 (if (typep menu-item 'menu)                   (set-action-function menu-item)                   (setf (editable-text-di menu-item) self)))))      (set-action-function menu))))#|(defclass test-window (layout-mixin window)   ());the items should be of class 'insertion-menu-item(let* ((pop-up-menu (make-instance 'real-pop-up-menu                      :menu-items (list (make-instance 'insertion-menu-item                                          :menu-item-title "insert 'Hello'"                                          :insertion-text "Hello ")                                        (make-instance 'insertion-menu-item                                          :menu-item-title "insert 'World'"                                          :insertion-text "World"))))       (small-editable-text-di  (make-instance 'small-editable-text-di                                  :border 3                                  :after-method #'(lambda (editable-text-di inserted-text)                                                    (declare (ignore inserted-text))                                                    (if (string= (dialog-item-text                                                                   (view-named :editable-text editable-text-di))                                                                 "Hello World")                                                      (setf (clear-text editable-text-di) t)                                                      (setf (clear-text editable-text-di) nil)))                                  :clear-text nil                                  :pop-up-menu pop-up-menu))       (pop-up-menu-2 (make-instance 'real-pop-up-menu                        :menu-items (list (make-instance 'insertion-menu-item                                            :menu-item-title "insert 'Hello'"                                            :insertion-text "Hello ")                                          (make-instance 'insertion-menu-item                                            :menu-item-title "insert 'World'"                                            :insertion-text "World"))))       (small-editable-text-di-2  (make-instance 'small-editable-text-di                                  :border 3                                  :adjust-size-p nil                                  :clear-text nil                                  :pop-up-menu pop-up-menu-2))       )   (make-instance 'test-window      :window-title "Small-editable-text-di"      :view-size #@(250 100)      :view-position :centered      :layout      (:vbox ()           (:hbox (:height 20))           (:hbox ()                  (:hbox (:width 20))                  (:hbox (:width (view-width small-editable-text-di) :height (view-height small-editable-text-di)) small-editable-text-di)                  (:hbox (:width 20)))           (:hbox (:height 10))           (:hbox ()                  (:hbox (:width 20))                  (:fbox (:height (view-height small-editable-text-di)) small-editable-text-di-2)                  (:hbox (:width 20)))           (:hbox (:height 20)))))|#
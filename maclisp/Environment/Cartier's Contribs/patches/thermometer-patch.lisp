;;; -*- package: CCL -*-;;;;;;; Adding color patterns to thermometers;;;(in-package "CCL")(eval-when (:compile-toplevel :load-toplevel :execute)  (export '(thermometer thermometer-pattern thermometer-fill-pattern            thermometer-color-pattern-p            thermometer-value-function thermometer-max-value-function            thermometer-value thermometer-max-value            thermometer-direction thermometer-length thermometer-width            thermometer-update-values            thermo-window thermo-update-function             add-thermo-update-function remove-thermo-update-function            gc-thermometer file-thermometer)))(defclass thermometer (simple-view)  ((pattern :initarg :pattern             :initform *black-pattern*            :accessor thermometer-pattern)   (fill-pattern :initarg :fill-pattern                 :initform *white-pattern*                 :accessor thermometer-fill-pattern)   (color-pattern-p :initarg :color-pattern-p                    :initform nil                    :accessor thermometer-color-pattern-p)   (value-function :initarg :value-function :initform nil                   :accessor thermometer-value-function)   (max-value-function :initarg :max-value-function :initform nil                       :accessor thermometer-max-value-function)   (value :initarg :value :initform 0          :reader thermometer-value :writer (setf thermometer-value-slot))   (max-value :initarg :max-value :initform 100              :reader thermometer-max-value :writer (setf thermometer-max-value-slot))   (direction :initarg :direction :initform :vertical              :accessor thermometer-direction)   (length :initarg :length :initform 100           :reader thermometer-length :writer (setf thermometer-length-slot))   (width :initarg :width :initform 16          :reader thermometer-width :writer (setf thermometer-width-slot))))(defmethod view-draw-contents ((self thermometer))  (let* ((pos (view-position self))         (size (view-size self))         (lr (add-points pos size))         (direction (thermometer-direction self)))    (with-pen-saved      (#_PenPat *black-pattern*)      (#_PenMode #$PatCopy)      (rlet ((rect :rect :topLeft pos :botRight lr))        (#_FrameRect rect)        (setq pos (add-points pos #@(1 1))              lr (subtract-points lr #@(1 1)))        (setf (rref rect :rect.topLeft) pos              (rref rect :rect.botRight) lr)        (let* ((values (list (thermometer-value self)))               (patterns (list (thermometer-pattern self)))               (color-p (thermometer-color-pattern-p self))               (max-value (thermometer-max-value self))               (length (thermometer-length self))               (vertical? (eq direction :vertical))               (left (point-h pos))               (right (point-h lr))               (top (point-v pos))               (bottom (point-v lr))               (start (if vertical? bottom left))               (total 0)               pattern patterns-list)          (declare (dynamic-extent values patterns))          (declare (list values patterns))          (declare (fixnum left right top bottom start length))          (if (listp (car values)) (setq values (car values)))          (if (listp (car patterns)) (setq patterns (car patterns)))          (setq patterns-list patterns)          (flet ((limit (value min max)                   (max min (min max value))))            (dolist (value values)              (setq pattern (pop patterns-list))              (if (null patterns-list) (setq patterns-list patterns))              (let* ((pixels (limit                              (muldiv (incf total value) length max-value)                              0 length))                     (split (if vertical?                              (- bottom pixels)                              (+ left pixels))))                (declare (fixnum pixels split))                (if vertical?                  (setf (rref rect :rect.topLeft)                        (make-point left                                    (limit split                                            top                                           (limit (1- start) top bottom)))                        (rref rect :rect.botRight)                        (make-point right (limit start top bottom)))                  (setf (rref rect :rect.botRight)                        (make-point (limit split                                            (limit (1+ start) left right)                                           right)                                    bottom)                        (rref rect :rect.topLeft)                        (make-point (limit start left right) top)))                (if color-p                    (#_FillCRect rect pattern)                  (#_FillRect rect pattern))                (setq start split))))          (if vertical?            (setf (rref rect :rect.topLeft) pos                  (rref rect :rect.botRight) (make-point right start))            (setf (rref rect :rect.topLeft) (make-point start top)                  (rref rect :rect.botRight) lr))          (if color-p              (#_FillCRect rect (thermometer-fill-pattern self))            (#_FillRect rect (thermometer-fill-pattern self))))))))
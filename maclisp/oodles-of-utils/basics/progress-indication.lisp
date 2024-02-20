(in-package :oou)(oou-provide :progress-indication);*****************************************************************                                    ;; Copyright � 1991 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Authors: Matthew Cornell;               Dieter Holz;;  Defines with-progress-indication and progress-step which provide a; uniform way to note incremental progress during long operations. Fondly; inspired by Symbolics' noting-progress mechanism.;; You have permission to use this file but not to charge for its use, and you; must include this notice. Copyright 1991 Matthew Cornell.;; Send comments, questions, and fixes to cornell@cs.umass.edu.;; Changes (worth to be mentioned):; ------------------------------; none ;;*****************************************************************;*****************************************************************(eval-when (:compile-toplevel :load-toplevel :execute)  )(export '(WITH-PROGRESS-INDICATION PROGRESS-STEP));--------------------------------------------------------------------------------------#|(defun progress-step (step-num &optional step-text)  "progress-step     step-num &optional step-textVisually indicates step number STEP-NUM has taken place. STEP-TEXT, ifpassed, is drawn too. Use nil for STEP-NUM to update just STEP-TEXT and notthe visual indicator."  ;;  )|#(defmacro with-progress-indication ((num-steps title) form)  "with-progress-indication     ((num-steps title) form)Executes FORM with a visual indication of percent done. NUM-STEPS is thetotal number of steps the task will take and is an integer. TITLE is astring used to label the entire task. During FORM's execution calls toprogress-step can be made."  ;;  ;; Eval-time expansion.  ;;  (let ((dialog-var (gensym "dialog-"))        (results-var (gensym "result-"))        )    ;;    ;; Run-time expansion.    ;;    `(let* ((,dialog-var (make-instance 'progress-dialog                                        :num-steps ,num-steps :title ,title))            ,results-var            )       (labels ((progress-step (step-num &optional step-text)                 (set-step ,dialog-var step-num step-text))                )         ;;         (unwind-protect           (setf ,results-var (multiple-value-list ,form))           (progn (window-close ,dialog-var)                  (values-list ,results-var)))))));;;;;; The pi-box-dialog-item class.;;;(defclass pi-box-dialog-item (dialog-item)  ())(defmethod view-contains-point-p  ((item pi-box-dialog-item)                                   point)  (declare (ignore point))  ;;  nil)(defmethod view-draw-contents ((item pi-box-dialog-item))  "Draws a box around ITEM."  ;;  (let* ((topleft (view-position item))         (bottomright (add-points topleft (view-size item))))    (rlet ((r :rect :topleft topleft              :bottomright bottomright))      (#_FrameRect :ptr r))));;;;;; The progress-dialog-item class.;;;(defclass progress-dialog-item (pi-box-dialog-item)  ((num-steps    :accessor progress-num-steps    :initarg :progress-num-steps)   (current-step    :accessor progress-current-step    :initform -1)   )  )(defmethod initialize-instance :after ((item progress-dialog-item)                                     &key progress-num-steps)  (unless progress-num-steps    (error ":progress-num-steps initarg required.")))(defmethod view-draw-contents :after ((item progress-dialog-item))  "Draws the percentage indicator based on progress-num-steps andprogress-current-step."  ;;  (let* ((width (point-h (view-size item)))         (height (point-v (view-size item)))         (step-width (/ width (progress-num-steps item)))         (right (round (* (1+ (progress-current-step item)) step-width)))         )    (fill-rect item *gray-pattern* 1 1 (1- right) (1- height))))(defmethod set-step ((item progress-dialog-item)                     (new-step integer)                     &optional step-text)  (declare (ignore step-text))  ;;  (when (>= new-step (progress-num-steps item))    (error "New-step (~S) >= declared number of steps (~S)."           new-step (progress-num-steps item)))  ;;  (setf (progress-current-step item) new-step)  (view-draw-contents item));;;;;; The progress-dialog class.;;;(defclass progress-dialog (dialog)  ()  (:default-initargs    :WINDOW-TYPE :DOUBLE-EDGE-BOX :VIEW-POSITION '(:TOP 60)    :VIEW-SIZE #@(302 64) :CLOSE-BOX-P NIL    :VIEW-FONT '("Chicago" 12 :SRCOR :PLAIN)))(defmethod initialize-instance :after ((dialog progress-dialog)                                     &key num-steps title)  (unless num-steps    (error ":num-steps initarg required."))  (unless title    (error ":title initarg required."))  ;;  ;; Add the items, initialize 'title-text-item and 'progress-item.  ;;  (add-subviews dialog                (MAKE-DIALOG-ITEM                 'STATIC-TEXT-DIALOG-ITEM #@(3 1) #@(293 16) title)                (MAKE-DIALOG-ITEM                 'STATIC-TEXT-DIALOG-ITEM #@(3 20) #@(293 22)                 "" NIL :VIEW-NICK-NAME 'step-text-item                 :view-font '("Helvetica" 9 :plain))                (MAKE-DIALOG-ITEM                 'progress-dialog-item #@(3 48) #@(296 12)                 "" NIL :VIEW-NICK-NAME 'progress-item                 :progress-num-steps num-steps)))(defmethod set-step ((dialog progress-dialog)                     (new-step (eql nil))   ;note! More specific than integer                     &optional step-text)  (when step-text    (set-dialog-item-text (view-named 'step-text-item dialog)                          step-text)))(defmethod set-step ((dialog progress-dialog)                     (new-step integer)                     &optional step-text)  (when step-text    (set-dialog-item-text (view-named 'step-text-item dialog)                          step-text))  (set-step (view-named 'progress-item dialog) new-step))#|;;; Example:(let* ((windows (windows))       (len (length windows))       )  (with-progress-indication (len "Windows Demo")    (progn      (progress-step nil "Setting up")      (sleep .5)      (dotimes (count len)        (progress-step count (format nil "~A" (elt windows count)))        (sleep 1))      (progress-step nil "Cleaning up")      (sleep .5))))|#
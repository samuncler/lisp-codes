(in-package :oou);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;hier-menu-demo.lisp;;;; Copyright � 1992 University of Toronto, Department of Computer Science;; All Rights Reserved;;;; author: Mark A. Tapia;;;; A demonstration of hierarchical marking menus;;;; To use this demonstration, first load "init-menus.lisp" and "make-menus.lisp";; and then evaluate the form:;;  (menus::load-hier-demo);; Finally evalute the form:;;  (hier-demo);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :misc                  :marking-menus                  :check-menu-item)(defvar text)(setq text"Hierarchical marking menusTo invoke a marking menu, press the mouse button down and hold it down. The menu willappear.Like standard menus, menu items in marking menus may also be menus. These items are are denotedby a > and are called 'sub-menus'Sub-menus can be invoked by dragging the rubber-band line outside the circle, pausing,while keeping the mouse button pressed down.The sub-menu will then appear.To backup to a previous menu, stretch therubber-band line to the center of the menuand then select another option.While menus can be nested to any depth, itis better to nest to at most three levels.When each level contains four choices, thisallows access to sixty-four (64) items bypassing through three menus.Five options control the presentation ofhierarchical menus. The options are describedbelow.The recommended options are      on : Float, Hide, Turn      off: Opaque, KeepOptions marked with an asterisk (*) affectonly hierarchical menus:    Float          on : menus resemble spokes of wheel and float           above the surface of the view      off: menus are pie-shaped*   Hide      on : when selecting a submenu,hides           the other siblings      off: show all sibling menu items when select-           ing a sub-menu*   Turn      on : alternate between on/off axis menus      off: all menus are either on/off axis*   Opaque      on:  menu greys out the underlying view      off: menu obscures the underlying view*   Keep      on:  removes other siblings when a sub-menu           is invoked.Retains the highlighted and           selected wedge or spoke      off: always places the menu item to the left           of the anchoring circle.Experiment with the options to determine theireffect on the presentation.")(defun to-lines (text)  "Return a list containing the separate lines of the string"  (let (n lines)    (loop      (setq n (position #\Newline text))      (unless n (push text lines)              (return (nreverse lines)))      (when (minusp n)        (push text lines)        (return (nreverse lines)))      (push (if (zerop n) ""                (subseq text 0 n))            lines)      (setq text (subseq text (1+ n))))))(defmethod scroll-down ((self table-dialog-item))  (let* ((first-cell (point-v (scroll-position self)))         (ncells (point-v (table-dimensions self)))         (visible-dimensions (point-v (visible-dimensions self)))         (last-cell (min (1- (+ first-cell visible-dimensions))                         (- ncells visible-dimensions))))    (when (< last-cell ncells)      (scroll-to-cell self (make-point 1 last-cell))       (< (+ last-cell visible-dimensions) ncells))))(defmethod scroll-up ((self table-dialog-item))  (let* ((first-cell (point-v (scroll-position self)))         (visible-dimensions (point-v (visible-dimensions self)))         new-cell)      (setq new-cell (max 0 (1+ (- first-cell visible-dimensions))))      (scroll-to-cell self (make-point 1 new-cell))      (not (zerop new-cell))))(defclass unhilited-table (marking-menu-table)  ()  (:default-initargs :auto-size t    :menu-font default-font))(defmethod highlight-table-cell ((marking-menu-table unhilited-table) cel rect selectedp)  (declare (ignore marking-menu-table cel rect selectedp)))(defun make-help-file ()  (let (that table prev next end)    (setq that          (make-instance 'dialog                          :window-type :double-edge-box                         :window-show nil                         :view-position :centered                         :view-size #@(434 359)                                        :close-box-p nil                          :view-font '("Chicago" 12 :srcor :plain)))    (add-subviews that                  (setq table (make-instance 'unhilited-table                                              :view-position  #@(11 16)                                              :view-size #@(402 290)                                             :view-font '("Courier" 12 :srccopy :plain)                                             :cell-size #@(385 16)                                              :table-hscrollp nil                                              :table-vscrollp t                                              :table-sequence                                              '()))                                    (make-dialog-item 'button-dialog-item                                     #@(364 326)                                     #@(62 16)                                    "Ok"                                     #'(lambda (item)                                         (let* ((window (view-window item)))                                          (eval-enqueue `(window-hide ,window))))                                    :default-button t))    (setq prev (make-instance 'window-menu-item                             :menu-item-title "Prev"                             :disabled t)          end (make-instance 'window-menu-item                             :menu-item-title "Close"                             :menu-item-action                              #'(lambda (item)                                  (let* ((container (containing-view item))                                        (window (view-window container)))                                   (eval-enqueue `(window-hide ,window)))))                    next (make-instance 'window-menu-item                              :menu-item-title "Next"))    (add-menu-items table prev end next (make-instance 'empty-menu-item))    (setf (menu-item-action-function prev)          #'(lambda (item)              (let* ((container (containing-view item))                     (next (find-menu-item container "Next"))                     (prev (find-menu-item container "Prev")))                (eval-enqueue                 `(progn                     (unless (scroll-up ,container)                      (menu-item-disable ,prev))                    (menu-item-enable ,next)))))                    (menu-item-action-function next)          #'(lambda (item)              (let* ((container (containing-view item))                     (next (find-menu-item container "Next"))                     (prev (find-menu-item container "Prev")))                (eval-enqueue                 `(progn                     (unless (scroll-down ,container)                      (menu-item-disable ,next))                    (menu-item-enable ,prev))))))    (set-table-sequence table (to-lines text))    (set-table-dimensions table 1 (length (table-sequence table)))    that))(defun change-main-option (item flag)  "Changes the option in the root menu for the slot with name flag"  (setf (slot-value (containing-view item) flag)        (menu-item-check-mark item)))(defvar *help* (make-help-file))(defun test-hier (&key floating turn hide in-position opaque)  (let (that         roger         rabbit         options         (standard-font default-font)        m-floating m-turn m-hide m-opaque m-in-position)    (setq that (make-instance 'marking-menu-window                              :hide hide                              :in-position in-position                              :menu-floating floating                              :menu-font standard-font                              :auto-size t))    (add-subviews that                  (make-instance 'static-text-dialog-item                                  :view-position #@(49 34)                                 :view-size  #@(223 60)                                  :dialog-item-text (format nil "Hold the mouse button down to try ~                                                                hierarchical marking menus. ~                                                                Experiment with the options ~                                                                in the submenu 'Menus >'")                                 :view-font '("Chicago" 12 :srccopy :plain)))    (add-menu-items that                    (make-instance 'menu-item                                   :menu-item-title "Help"                                   :menu-item-action                                    #'(lambda ()                                       (eval-enqueue `(help-demo))))                    (setq options (make-instance 'marking-menu-view                                                 :menu-font standard-font                                                 :menu-item-title "Menus"                                                 :auto-size t))                    (setq roger (make-instance 'marking-menu-view                                               :menu-font standard-font                                               :menu-title "View"                                               :auto-size t))                    (if (and (boundp '*custom*)                             *custom*)                      (make-instance 'window-menu-item                                     :menu-item-title "Demo�"                                     :menu-item-action                                     #'(lambda (item)                                         (when (fboundp 'marking-demo)                                           (let ((container (containing-view item)))                                           (eval-enqueue                                            `(progn                                              (window-hide ,container)                                              (marking-demo)                                              (window-show ,container)))))))                      (make-instance 'empty-menu-item)))        (setq m-floating (make-instance 'check-window-menu-item                                    :menu-item-title "Float"                                    :mark "�")          m-hide (make-instance 'check-window-menu-item                                :menu-item-title "Hide"                                :mark "�")          m-opaque (make-instance 'check-window-menu-item                                  :menu-item-title "Opaque"                                  :mark "�")          m-turn (make-instance 'check-window-menu-item                                :menu-item-title "Turn"                                :mark "�")          m-in-position (make-instance 'check-window-menu-item                                       :menu-item-title "Keep"                                       :mark "�"))    (set-menu-item-check-mark m-floating floating)    (set-menu-item-check-mark m-turn turn)    (set-menu-item-check-mark m-hide hide)    (set-menu-item-check-mark m-opaque opaque)    (set-menu-item-check-mark m-in-position in-position)        (add-menu-items options                    m-floating                    m-hide                    m-opaque                    m-turn                    m-in-position                    (make-instance 'menu-item                                   :menu-item-title "Help"                                   :menu-item-action                                    #'(lambda ()                                       (eval-enqueue `(help-demo)))))        (setf (menu-item-action-function m-floating)          #'(lambda (item)              (let ((container (containing-view item)))                (eval-enqueue                 `(setf (slot-value  ,container 'menu-floating)                        (not (slot-value ,container 'menu-floating)))))))        (setf (menu-item-action-function m-hide)          #'(lambda (item)              (change-main-option item 'hide)))        (setf (menu-item-action-function m-opaque)          #'(lambda (item)              (change-main-option item 'menu-opaque)))        (setf (menu-item-action-function m-turn)          #'(lambda (item)              (change-main-option item 'turn)))        (setf (menu-item-action-function m-in-position)          #'(lambda (item)              (change-main-option item 'in-position)))        (add-menu-items roger                    (make-instance 'window-menu-item                                   :menu-item-title "Close"                                   :menu-item-action #'(lambda (item)                                                         (let ((container                                                                (containing-view item)))                                                           (eval-enqueue `(window-close ,container)))))                    (make-instance 'menu-item                                   :menu-item-title "Beep"                                   :menu-item-action #'(lambda ()                                                         (ED-BEEP)))                    (make-instance 'window-menu-item                                   :menu-item-title (if *custom* "Exp" "Beep 2")                                   :menu-item-action (if *custom*                                                        #'(lambda (item)                                                           (let ((container (containing-view item)))                                                             (when (find-package :game)                                                              (eval-enqueue                                                              (list 'progn                                                                     (list 'window-hide container)                                                                    (list 'in-package 'game)                                                                    (list 'do-exp)                                                                    (list 'in-package 'cl-user)                                                                    (list 'window-select container))))))                                                       #'(lambda (item)                                                           (declare (ignore item))                                                           (dotimes (i 2)                                                             (ED-BEEP)))))                    (setq rabbit (make-instance 'marking-menu-view                                                :menu-font standard-font                                                :menu-item-title "Zoom")))    (add-menu-items rabbit                    (make-instance 'menu-item                                   :menu-item-title "Grow"                                   :menu-item-action                                   #'(lambda () (let ((form (list 'cl-user::zoom-it that)))                                                  (eval-enqueue form))))                    (make-instance 'menu-item                                   :menu-item-title "Normal"                                   :disabled t)                    (make-instance 'window-menu-item                                   :menu-item-title "Close"                                   :menu-item-action #'(lambda (item)                                                         (let ((container                                                                (containing-view item)))                                                           (eval-enqueue `(window-close ,container)))))                    (make-instance 'menu-item                                   :menu-item-title "Beep"                                   :menu-item-action #'(lambda ()                                                         (ED-BEEP))))    that))(defun hier-marking-demo ()  (let ((that (test-hier :floating t :turn t :hide t :in-position nil)))    (loop      while (wptr that)      do (when *eval-queue*           (loop             while *eval-queue*             do (eval (pop *eval-queue*))))))) (defun help-demo ()  (unless (and (boundp '*help*)                (wptr *help*))    (setq *help* (make-help-file)))  (window-select *help*)  (queued-modal-dialog *help* nil)  (window-hide *help*))(defun hier-demo ()  (hier-marking-demo)  (window-close *help*)  (%set-toplevel (if *testing* #'toplevel-loop                     nil)))(defun make-hier-demo ()  "Create the experiment application"  (let ((target-appl (choose-new-file-dialog :directory "ccl;hier")))    (set-menubar nil)    (setq *testing* nil)    (save-application target-appl                      :excise-compiler t    ; don't want the compiler                      :creator :hier                      :clear-clos-caches nil ; otherwise we can't access classes                      :toplevel-function #'hier-demo)))#|(test-hier :floating t :turn t :hide t :in-position nil)  (make-hier-demo)|#
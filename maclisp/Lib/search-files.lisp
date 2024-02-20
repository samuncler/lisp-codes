;;;-*- Mode: Lisp; Package: CCL -*-;;	Change History (most recent first):;;  3 10/5/97  akh  see below;;  5 10/3/96  slh  use declaim ftype to avoid warnings; removed ccl prefixes;;  3 7/30/96  akh  use arrow-dialog-item - per bill;;  2 7/26/96  akh  back-color, change button title, smaller, default path even if no selection;;  (do not edit before this line!!);;; search-files.lisp;;; Copyright � 1996 Digitool, Inc.;;; The extended search files dialog from Apple Dylan;;; (setq ccl::*use-old-search-file-dialog* t) to revert to the old one.(in-package ccl);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Modification History;;;;;; 05/07/97 bill  Specify true value of :table-vscrollp for the arrow-dialog-item;;; -------------  4.1;;; 10/11/96 bill  extended-search-files-dialog no longer errors on mac-file-type of an orphaned alias file;;; -------------  4.0f1;;; 08/23/96 bill  searching-files-dialog calls (event-dispatch) when it starts searching a new file.;;;                This makes every file name appear there and makes it seem faster (though it's;;;                probably actually slightly slower).;;;                extended-search-files-dialog makes the string-item the current-key-handler.;;; -------------  4.0b1;;; 07/17/96 bill  New file (to MCL);;;(defun buffer-point-in-comment? (buffer pos start end)  ;If true, returns position of comment end.  (assert (and (<= start pos) (<= pos end)))  (loop    (unless (setq start (buffer-forward-find-char buffer ";\"#\\\|" start pos))      (RETURN nil))    (ecase (buffer-char buffer (1- start))      (#\;       (setq start (buffer-forward-find-char buffer #\Newline start end))       (when (null start) (RETURN end))       (when (> start pos) (RETURN start)))      (#\#       (when (eq start pos) (RETURN nil))       (when (eq (buffer-char buffer start) #\|)         (setq start (buffer-skip-fwd-#comment buffer (1+ start) end))         (when (null start) (RETURN end))         (when (> start pos) (RETURN start))))      (#\\       (when (eq start pos) (RETURN nil))       (setq start (1+ start)))      (#\|       (unless (setq start (buffer-fwd-skip-delimited buffer "\|\\" start pos))         (RETURN nil)))      (#\"       (unless (setq start (buffer-fwd-skip-delimited buffer "\"\\" start pos))         (RETURN nil))))))(defun found-in-buffer-p (string buffer search-comments-p)  (let ((pos (buffer-string-pos buffer string :start 0)))    (when pos      (or search-comments-p          (do ((start 0) (end (buffer-size buffer)))              ((not (and (setq pos (buffer-string-pos buffer string :start start :end end))                         (setq start (buffer-point-in-comment? buffer pos start end))))               pos))))))(defclass searching-files-selection-dialog (select-dialog) ())(defvar *search-files-dialog-position* nil "search results window position")(defvar *search-files-dialog-size* nil "search results window size")(defclass item-selection-dialog-with-stop (select-dialog)   ((stop-action :accessor stop-action :initarg :stop-action)   (window-position-variable :accessor window-position-variable :initarg :window-position-variable)   (window-size-variable :accessor window-size-variable :initarg :window-size-variable)   (grow-rect :reader grow-rect :initform (make-record :rect))) (:default-initargs      :window-show nil   :window-type :document-with-grow   :close-box-p t))(defmethod window-close ((window item-selection-dialog-with-stop))  ;; close the window before the action since the action is an abort  (call-next-method)  (dispose-record (grow-rect window) :rect)  (let ((button (view-named 'stop-button window)))    (when (and button (dialog-item-enabled-p button) (stop-action window))      (funcall (stop-action window) window))))(defmethod set-view-size ((window item-selection-dialog-with-stop) h &optional v)  ;; prevent a re-size while resizing - the minimum size code depends on the current size  (without-interrupts   (let* ((old-size (view-size window))          (new-size (make-point h v))          (delta (subtract-points new-size old-size))          (stop-button (view-named 'stop-button window))          (stop-button-position (view-position stop-button)))     (call-next-method)     ; (method set-view-size (select-dialog t)) moved the sequence and buttons.     ; Fix what it did to the stop button and change the size of the state item     (set-view-position stop-button (point-h (view-position stop-button)) (point-v stop-button-position))     (let* ((state (view-named 'detailed-state window))            (size (view-size state)))       (set-view-size state (make-point (+ (point-h size) (point-h delta)) (point-v size)))       (invalidate-view state))     (when (window-size-variable window)       (set (window-size-variable window) (view-size window)))     new-size)))(defmethod set-view-position ((window item-selection-dialog-with-stop) h &optional v)  (declare (ignore h v))  (prog1    (call-next-method)    (when (window-position-variable window)      (set (window-position-variable window) (view-position window)))))(defmethod add-dialog-items ((dialog item-selection-dialog-with-stop)                             &rest args &key the-list table-print-function selection-type action-function                             default-button-text stop-button-text)  (declare (ignore args))  (flet ((act-on-items (item)           (declare (ignore item))           (let ((s-item (view-named 'sequence-dialog-item dialog)))             (funcall action-function                       (mapcar #'(lambda (c) (cell-contents s-item c))                              (selected-cells s-item))))))        (let ((button-width 58)          (button-height 20)          (state-width 60)          (text-height 12)          (spacing-a 13)          (border 3)          (size (view-size dialog)))      (add-subviews dialog                    (make-instance 'static-text-dialog-item                       :dialog-item-text ""                      :view-position (make-point (+ spacing-a border)                                                 (+ (floor (- button-height text-height) 2)                                                    (- spacing-a border)))                      :view-size (make-point state-width text-height)                      :view-font '("Geneva" 9 :bold)                      :view-nick-name 'state)                    (make-instance 'ellipsized-text-dialog-item                       :dialog-item-text ""                      :view-position (make-point (+ spacing-a border border state-width)                                                 (+ (floor (- button-height text-height) 2)                                                    (- spacing-a border)))                      :view-size (make-point (- (point-h size)                                                 (+ (+ spacing-a border) border state-width)                                                border                                                button-width (- spacing-a border) spacing-a)     ; button left                                             text-height)                      :view-font '("Geneva" 9 :italic)                      :view-nick-name 'detailed-state                      :compress-text nil)       ; avoid bug where compressing switches to non-italics                    (make-instance 'button-dialog-item                      :dialog-item-text stop-button-text                      :view-position (make-point (- (point-h size) (- spacing-a border) spacing-a button-width)                                                 (- spacing-a border))                      :view-size (make-point button-width button-height)                      :view-nick-name 'stop-button                      :dialog-item-action                      #'(lambda (item)                          (declare (ignore item))                          (when (stop-action dialog)                            (funcall (stop-action dialog) dialog))))                    (make-instance                      'arrow-dialog-item                      :view-position (make-point spacing-a                                                  (+ (- spacing-a border) button-height spacing-a))                      :view-size (make-point (- (point-h size)                                                spacing-a     ; left                                                (- spacing-a border) spacing-a)          ; right                                             (- (point-v size)                                                (- spacing-a border) button-height spacing-a     ; top                                                spacing-a button-height spacing-a))     ; bottom                      :table-hscrollp nil                      :table-vscrollp t                      :table-sequence the-list                      :table-print-function table-print-function                      :selection-type selection-type                      :view-nick-name 'sequence-dialog-item                      :dialog-item-action                      #'(lambda (item)                          (if (block find                                  (mapcar #'(lambda (c) (when (cell-contents item c) (return-from find t)))                                          (selected-cells item)))                            (progn (dialog-item-enable (default-button (view-container item)))                                   (when (double-click-p)                                     (dialog-item-action                                      (default-button (view-container item)))))                            (progn (dialog-item-disable (default-button (view-container item)))                                   (when (double-click-p)                                     (ed-beep))))))                                        (make-instance                       'default-button-dialog-item                      :dialog-item-text default-button-text                      :dialog-item-enabled-p the-list                      :view-position (make-point (- (point-h size) (- spacing-a border) spacing-a button-width)                                                 (- (point-v size) spacing-a button-height))                      :view-size (make-point button-width button-height)                      :view-nick-name 'locate-button                      :dialog-item-action                      #'act-on-items)))    nil))(defmethod view-minimum-size ((view item-selection-dialog-with-stop))  (let ((sequence (view-named 'sequence-dialog-item view))        (spacing-a 13)        (locate-button (view-named 'locate-button view)))    (make-point (+ (point-h (view-position sequence))                   200                   (- (point-h (view-size view))                      (+ (point-h (view-position sequence)) (point-h (view-size sequence)))))                (+ (point-v (view-position sequence))                   46                   ; 4 text lines                   spacing-a                   (point-v (view-size locate-button))                   spacing-a))))(defmethod view-maximum-size ((view item-selection-dialog-with-stop))  #@(3200 3200))(defmethod window-grow-rect ((view item-selection-dialog-with-stop))  (let ((grow-rect (grow-rect view)))    (setf (rref grow-rect rect.topleft) (view-minimum-size view)          (rref grow-rect rect.bottomright) (view-maximum-size view))    grow-rect))(defun select-items-from-list-with-stop (the-list &key (window-title "Select an Item")                                                  (selection-type :single)                                                  table-print-function                                                   (action-function #'identity)                                                  (stop-button-text "Stop")                                                  (stop-action nil)                                                  (default-button-text "Find It")                                                  (window-position-variable nil)                                                  (window-size-variable nil))  "Displays the elements of a list, and returns the item chosen by the user"  #+ccl-3  (when stop-action    (let ((process *current-process*)          (user-stop-action stop-action))      (setq stop-action            #'(lambda (dialog)                (process-interrupt process user-stop-action dialog)))))  (let ((dialog (make-instance                  'item-selection-dialog-with-stop                  :stop-action stop-action                  :back-color *tool-back-color*                  :content-color *tool-back-color*                  :window-position-variable window-position-variable                  :window-size-variable window-size-variable                  :window-title window-title                  :view-size (or (and window-size-variable (symbol-value window-size-variable))                                 #@(400 180))                  :view-position  (or (and window-position-variable (symbol-value window-position-variable))                                      (make-point (%ilsr 1 (- *screen-width* 400))                                                  90)))))    (add-dialog-items dialog                       :selection-type selection-type                      :table-print-function table-print-function                      :action-function action-function                      :stop-button-text stop-button-text                      :default-button-text default-button-text)    (when the-list       (let ((selection-item (view-named 'sequence-dialog-item dialog)))        (cell-select selection-item                     (index-to-cell selection-item 0)))) ; sdi needs to be in a window to do this    (window-show dialog)))(defmacro using-binder-editor (&body body)  (let ((ui-pkg (find-package "USER-INTERFACE")))    (if ui-pkg      `(progv ,(list (find-symbol "*USE-BINDER-EDITOR*" ui-pkg)) '(t)         ,@body)      `(progn ,@body))))(defun searching-files-selection-dialog (string)  (select-items-from-list-with-stop nil                                    :window-title (format nil "Files Containing: ~A" string)                                    :window-position-variable '*search-files-dialog-position*                                    :window-size-variable '*search-files-dialog-size*                                    :stop-action                                    #'(lambda (dialog)                                        (dialog-item-disable (view-named 'stop-button dialog))                                        (set-dialog-item-text (view-named 'detailed-state dialog) "Aborted.")                                        (abort))                                    :action-function                                    #'(lambda (list)                                        (using-binder-editor                                          (maybe-start-isearch (ed (car list)) string)))))(declaim (ftype (function (&rest t) t) bm-find-string-in-files))(defun searching-files-dialog (string files-function pathname search-comments-p)  (let* ((dialog (searching-files-selection-dialog string))         (sdi (view-named 'sequence-dialog-item dialog))         (state (view-named 'state dialog))         (detailed-state (view-named 'detailed-state dialog))         (button (default-button dialog))         (found-list nil)         (complete? nil)         (files nil)         (scratch-buffer nil))    (set-dialog-item-text state "Searching:")    (set-dialog-item-text detailed-state "Collecting File List�")    (setq files (funcall files-function))    (unless files       (window-close dialog)      (return-from searching-files-dialog))    (set-table-sequence sdi found-list)    (unwind-protect      (flet ((start-file-search (file)               (when (null (wptr dialog))                 (return-from searching-files-dialog))               (set-dialog-item-text detailed-state (format nil "~A" file))               (event-dispatch))             (search-successful (file)               (setq found-list (nconc found-list (list file)))               (set-table-sequence sdi found-list)               (unless (first-selected-cell sdi)                 (cell-select sdi #@(0 0)))               (dialog-item-enable button)               (event-dispatch)))        (declare (dynamic-extent #'start-file-search #'search-successful))        (if (fboundp 'bm-find-string-in-files)          (flet ((f (file pos)                   (when file                     (cond ((eq pos t) (start-file-search file))                           (pos ;Found, but may be in a comment.                            (when (or search-comments-p                                      (prog2                                       (%buffer-insert-file (or scratch-buffer                                                                (setq scratch-buffer (make-buffer)))                                                            file 0)                                       (found-in-buffer-p string scratch-buffer nil)                                       (buffer-delete scratch-buffer 0 t)))                              (search-successful file))                            nil)))))            (declare (dynamic-extent #'f))            (bm-find-string-in-files string files #'f))          (dolist (file files)            (when (probe-file file)              (start-file-search file)              (when (let* ((old-window (pathname-to-window file))                           (buffer (if old-window                                     (fred-buffer old-window)                                     (progn                                       (%buffer-insert-file (or scratch-buffer                                                                (setq scratch-buffer (make-buffer)))                                                            file 0)                                       scratch-buffer))))                      (prog1                        (found-in-buffer-p string buffer search-comments-p)                        (when (eq buffer scratch-buffer) (buffer-delete buffer 0 t))))                (search-successful file)))))        (setq complete? t))      (dialog-item-disable (view-named 'stop-button dialog))      (set-dialog-item-text detailed-state (if complete?                                              (format nil "Completed searching �~A�." pathname)                                             "Canceled.")))    (set-table-sequence sdi found-list)))(defun enqueue-or-new-process (name function &rest args)  #-ccl-3  (declare (ignore name))  #+ccl-3  (if *single-process-p*    (eval-enqueue #'(lambda () (apply function args)))    (apply 'process-run-function name function args))  #-ccl-3  (eval-enqueue #'(lambda () (apply function args))))(defvar *search-files-search-comments* t)(defvar *search-files-text-only-p* t)(defvar *extended-search-files-dialog-position* '(:bottom 11))(defclass extended-search-files-dialog (string-dialog)  ())(defmethod window-close :before ((w extended-search-files-dialog))  (setq *extended-search-files-dialog-position* (view-position w)));Like ccl::search-file-dialog but add a Search Comments box.(defun extended-search-files-dialog (&aux initial-pathname initial-string)  (let ((w (front-window :class 'fred-window)))    (if w      (progn        (let* ((p (window-filename w)))          (if p             (setq initial-pathname (namestring (merge-pathnames "*" p)))            (setq initial-pathname "ccl:**;*.lisp")))        (multiple-value-bind (b e)(selection-range w)          (when (neq b e)            (setq initial-string (buffer-substring (fred-buffer w) b e)))))      (setq initial-pathname "ccl:**;*.lisp")))  (let ((the-dialog (front-window :class 'extended-search-files-dialog)))    (if (and the-dialog (wptr the-dialog))      (let ((keyhdlr (current-key-handler the-dialog)))        (when initial-string          (set-dialog-item-text (view-named 'string the-dialog) initial-string))        (when initial-pathname          (set-dialog-item-text (view-named 'pathname the-dialog) initial-pathname))        (when keyhdlr                    (set-selection-range keyhdlr 0 (length (dialog-item-text keyhdlr)))))      (progn        (unless initial-pathname          (setq initial-pathname                (if (equal %previous-search-file-file "")                  "ccl:**;*.lisp"                  %previous-search-file-file)))        (let* ((window-size #@(540 111))               (spacing-a 13)               (button-width 77)               (button-height 20)               (button-left (- (point-h window-size) spacing-a button-width))               (edit-left 100)               (edit-height 16)               (fudge 6)                    ; actual height of edit is this much bigger than edit-height               (check-height 14)               (vertical-spacing 8)               (string-item (make-dialog-item 'editable-text-dialog-item                                              (make-point edit-left (+ spacing-a (floor fudge 2)))                                              (make-point (- (point-h window-size) edit-left spacing-a (floor fudge 2)) edit-height)                                               (or initial-string %previous-search-file-string)                                              nil                                              :help-spec "Search for this string."                                              :view-nick-name 'string))               (file-item (make-dialog-item 'editable-text-dialog-item                                            (make-point edit-left (+ spacing-a edit-height fudge vertical-spacing (floor fudge 2)))                                             (make-point (- button-left edit-left spacing-a) edit-height)                                            initial-pathname                                            nil                                            :view-nick-name 'pathname                                            :help-spec                                            "Search in files described by this pathname.  Colons separate folder levels.  Use \"**\" for the last folder to search all contained subfolders."))               (comments-item (make-dialog-item 'check-box-dialog-item                                                (make-point (+ edit-left 130) (- (point-v window-size) check-height spacing-a))                                                nil                                                "Search Comments" nil                                                :check-box-checked-p *search-files-search-comments*                                                :help-spec "Search comments as well as other text"))               (text-only-item (make-dialog-item 'check-box-dialog-item                                                 (make-point (- edit-left (floor fudge 2)) (- (point-v window-size) check-height spacing-a))                                                 nil                                                 "Text Files Only" nil                                                 :check-box-checked-p *search-files-text-only-p*                                                 :help-spec "Only search in files of type 'TEXT'."))               (choose-pathname-button-item (make-dialog-item 'button-dialog-item                                                              (make-point button-left (+ spacing-a edit-height fudge vertical-spacing 1))                                                              (make-point button-width button-height)                                                               "Choose�"                                                              #'(lambda (item)                                                                  (let ((pathname (catch :cancel                                                                                    (choose-directory-dialog))))                                                                    (unless (eql pathname ':cancel)                                                                      (set-dialog-item-text file-item                                                                                            (format nil "~A**:*.*" pathname))                                                                      (update-default-button (view-window item)))))                                                              :help-spec "Brings up a choose folder dialog, allowing you to choose a pathname to search."))               (search-button-item (make-dialog-item 'default-button-dialog-item                                                     (make-point button-left (- (point-v window-size) button-height spacing-a))                                                     (make-point button-width button-height) "Search"                                                     #'(lambda (item)                                                         (declare (ignore item))                                                         (let ((string (dialog-item-text string-item))                                                               (file (dialog-item-text file-item))                                                               (comments-p (not (null (check-box-checked-p comments-item))))                                                               (text-only-p (not (null (check-box-checked-p text-only-item)))))                                                           (setq %previous-search-file-string string                                                                 %previous-search-file-file file)                                                           (enqueue-or-new-process                                                            "Searching"                                                            #'(lambda ()                                                                (searching-files-dialog string                                                                                         #'(lambda ()                                                                                            (let ((files (directory file)))                                                                                              (when text-only-p                                                                                                (setf files (delete-if-not #'(lambda (f)                                                                                                                               (ignore-errors                                                                                                                                (eq (mac-file-type f) :TEXT)))                                                                                                                           files)))                                                                                              (if (null files)                                                                                                (progn                                                                                                  (message-dialog                                                                                                   (format nil "No~:[~; text~] files correspond to ~s"                                                                                                           text-only-p file)                                                                                                   :title "Search Files")                                                                                                  nil)                                                                                                files)))                                                                                        file                                                                                        comments-p)))))                                                     :dialog-item-enabled-p                                                     (and (not (equal %previous-search-file-string ""))                                                          (not (equal %previous-search-file-file "")))                                                     :help-spec "Begins search and displays a window showing the search progress and results.")))          (setq the-dialog                (make-instance 'extended-search-files-dialog                  :window-type :document                  :window-show nil                  :content-color *tool-back-color*                  :back-color *tool-back-color*                  :view-size window-size                  :view-position *extended-search-files-dialog-position*                  :window-title "Search Files"                  :view-subviews                  (list*                   (make-dialog-item 'static-text-dialog-item                                     (make-point spacing-a (+ spacing-a (floor fudge 2))) nil "Search For:")                   (make-dialog-item 'static-text-dialog-item                                     (make-point spacing-a (+ spacing-a edit-height fudge vertical-spacing (floor fudge 2))) nil "Pathname:")                   (make-dialog-item 'static-text-dialog-item                                     (make-point (- edit-left (floor fudge 2)) (+ spacing-a edit-height fudge vertical-spacing edit-height fudge 2))                                     nil "The pathname may contain wild-cards (*)."                                     nil :view-font '("Geneva" 9))                                      file-item                   string-item                   text-only-item                   choose-pathname-button-item                   search-button-item                   (if t  ; *leibniz-implementor-p*                     (list comments-item)                     nil))))          (set-current-key-handler the-dialog string-item t)          (window-select the-dialog))))    (update-default-button the-dialog)    (window-select the-dialog)    the-dialog));;;;;; Ellipsized Text;;;(defun draw-ellipsized-text-in-rect (text length rect &optional (just #$teJustLeft) compress)  (cond ((<= (#_TextWidth text 0 length)             (- (rref rect rect.right) (rref rect rect.left)))         (my-text-box text length rect just))        (compress         (let ((saved-face                (rlet ((portPtr (:pointer :grafport)))                  (#_GetPort portPtr)                  (rref portPtr grafPort.txFace))))           (unwind-protect             (progn               (#_TextFace (ash 1 #$condense))               (draw-ellipsized-text-in-rect text length rect just nil))             (#_TextFace saved-face))))        (t         (%vstack-block (widths (* (1+ length) 2))           (#_MeasureText length text widths)           (let ((width (- (rref rect rect.right) (rref rect rect.left)                           (#_CharWidth #\�))))             (dotimes (i length)               (when (> (%get-word widths (* 2 i)) width)                 (my-text-box text (max (1- i) 0) rect #$teJustLeft)                 (#_DrawChar #\�)                 (return-from draw-ellipsized-text-in-rect))))))))(defun my-text-box (cstr length rect just &optional                            (erase? (eq #$srcCopy (rref (%getport) grafport.txMode))))  (let* ((str-width (#_TextWidth cstr 0 length))         (rect-left (rref rect rect.left))         (rect-right (rref rect rect.right))         (box-width (- rect-right rect-left))         (diff (- box-width str-width))         (vpos (rlet ((fi FontInfo))                 (#_GetFontInfo fi)                 (- (rref rect rect.bottom) (rref fi FontInfo.descent))))         (pos nil))    (cond ((eq just #$teJustLeft)           (setf pos rect-left)           (setf (rref rect rect.left) (+ (rref rect rect.left) str-width)))                   ((eq just #$teJustCenter)           (setf pos (+ rect-left (ash diff -1)))           (setf (rref rect rect.right) pos)           (when erase? (#_EraseRect rect))           (setf (rref rect rect.right) rect-right                 (rref rect rect.left) (+ pos str-width)))          ((eq just #$teJustRight)           (setf pos (+ rect-left diff))           (setf (rref rect rect.right) pos)))    (when erase? (#_EraseRect rect))    ;;make rect same as when passed in    (setf (rref rect rect.left) rect-left          (rref rect rect.right) rect-right)    (#_MoveTo pos vpos)    (#_DrawText cstr 0 length)))(defun draw-string-in-rect (string rect &optional (just #$teJustLeft))  (with-cstrs ((text string))    (draw-ellipsized-text-in-rect text (length string) rect just)))(defclass ellipsized-text-dialog-item (static-text-dialog-item)   ((compress-text-p :initarg :compress-text :initform t :reader compress-text-p)))(defmethod view-draw-contents ((item ellipsized-text-dialog-item))  (when (installed-item-p item)    (with-focused-dialog-item (item)      (let ((position (view-position item))            (size (view-size item))            (handle (dialog-item-handle item)))        (let ((color-list (slot-value item 'color-list))              (text-justification (slot-value item 'text-justification))              (enabled-p (dialog-item-enabled-p item)))          (rlet ((rect :rect)                 (ps :penstate))            (rset rect rect.topleft position)            (rset rect rect.bottomright (add-points position size))            (setq text-justification                  (or (cdr (assq text-justification                                 '((:left . #.#$tejustleft)                                   (:center . #.#$tejustcenter)                                   (:right . #.#$tejustright))))                      (require-type text-justification 'fixnum)))            (with-pointers ((tp handle))              (with-fore-color (getf color-list :text nil)                (with-back-color (getf color-list :body nil)                  (#_TextMode #$srcCopy)                  (draw-ellipsized-text-in-rect tp (#_GetHandleSize handle) rect                                                text-justification (compress-text-p item)))))            (unless enabled-p              (#_GetPenState ps)              (#_PenPat *gray-pattern*)              (#_PenMode 11)              (#_PaintRect rect)              (#_SetPenState ps))))))))(defvar *old-search-file-dialog* (fboundp 'search-file-dialog))(defvar *use-old-search-file-dialog* nil)(let ((*warn-if-redefine* nil)      (*warn-if-redefine-kernel* nil))  ; Overwrite the old interface with the new.(defun search-file-dialog ()  (if (and *use-old-search-file-dialog*           *old-search-file-dialog*)    (funcall *old-search-file-dialog*)    (extended-search-files-dialog))))
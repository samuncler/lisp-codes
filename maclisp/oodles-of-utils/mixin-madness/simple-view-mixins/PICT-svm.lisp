(in-package :oou)(oou-provide :PICT-svm);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PICT-svm.Lisp;;;; Copyright � 1991 Northwestern University Institute for the Learning Sciences;; Copyright � 1992 Institut fuer Informatik, University of Basel;; All Rights Reserved;;;; authors: Michael S. Engber, Northwestern University;;           Dieter Holz, University of Basel;;;; mixin for adding PICTs to views;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :graphic-rsrc-svm                                :PICT-u                                :records-u                                :quickdraw-u                                :simple-view-ce                                )(export '(PICT-svm set-view-PICT));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|PICT-svm and PICT-vm provide PICT drawing for views. When a PICT is created,it has a bounding rectangle, but can be displayed scaled(yuck) to any size.See Also graphic-rsrc-svm - inherited behaviorInitargs :PICT-id :PICT-name   The PICT can be specified by id or name. The PICT resource will be   read in when the view is installed in a window. It is assumed that   the appropriate resource file will be open at that time. :PICT-handle   If you already have a PICT handle, it can be specified directly. :PICT-file   The name of a PICT file to use instead of looking for a PICT resource   in the open resource files. :PICT-storage [:memory]   Applicable only when using a PICT file. It determines if the   PICT will be kept memory or will be spooled in from disk. Allowed,   keywords are :memory and :disk. :PICT-scaling [:adjust-view-size]   Determines if the PICT is scaled to the view size or vice-versa.   Allowed keywords are :adjust-view-size, :scale-to-view, :clip-to-view.    :adjust-view-size - the view size is adjusted to fit the cicn    :scale-to-view    - the cicn is scaled to the view size.    :clip-to-view     - the cicn is drawn clipped to the viewMethods of Interest set-view-PICT (sv PICT-svm) &key PICT-id PICT-name PICT-handle PICT-file PICT-storage  Changes the PICT. The keywords have the same meaning as in make-instance.|#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defun application-pathname ()  (rlet ((psn :processSerialNumber)         (infoRec :ProcessInfoRec)         (name (string 32))         (fsSpec :FSSpec))    (#_getCurrentProcess psn)    (setf (pref infoRec processInfoRec.processInfoLength) (record-length :processInfoRec)          (pref infoRec processInfoRec.processName) name          (pref infoRec processInfoRec.processAppSpec) fsSpec)    (#_getProcessInformation psn infoRec)    (%path-from-fsspec (pref infoRec :processInfoRec.processAppSpec))))(defclass PICT-svm (graphic-rsrc-svm)  ((rsrc-id :initarg :PICT-id)    (rsrc-name :initarg :PICT-name)    (rsrc-handle :initarg :PICT-handle)    (rsrc-file :initform nil                       :initarg :rsrc-file                       :accessor rsrc-file)    (PICT-file :initarg :PICT-file)    (PICT-storage :initarg :PICT-storage)    (graphic-scaling :initarg :PICT-scaling))  (:default-initargs     :rsrc-type "PICT"     :PICT-storage :memory     :graphic-default-size #@(100 100)))(defmethod rsrc-get-fn ((sv PICT-svm) rsrc-type rsrc-id-or-name)  (declare (ignore rsrc-type))  (etypecase rsrc-id-or-name    (fixnum (with-slots (rsrc-file detach-p) sv                        (when rsrc-file                             (let ((res-file-open (opened-res-file-p rsrc-file))                                       (res (with-res-file ((application-pathname))                                                    (#_GetPicture rsrc-id-or-name))))                                 (when (or (null res)                                                   (%null-ptr-p res))                                      (open-res-file (rsrc-file sv))                                      (setf res (#_GetPicture rsrc-id-or-name)))                                 (when detach-p                                      (#_DetachResource res)                                      (unless res-file-open                                          (close-res-file rsrc-file)))                                 res))))    (string (with-slots (rsrc-file detach-p) sv                        (when rsrc-file                             (let ((res-file-open (opened-res-file-p rsrc-file))                                       (res nil))                                 (open-res-file (rsrc-file sv))                                 (setf res (#_GetPicture (get-resource-id "PICT" rsrc-id-or-name)))                                 (when detach-p                                      (#_DetachResource res)                                      (unless res-file-open                                          (close-res-file rsrc-file)))                                 res))))    (null   (ecase (slot-value sv 'PICT-storage)              (:memory (get-picture-from-file (slot-value sv 'PICT-file)))              (:disk   (let ((PICT_h (#_NewHandle (rlength :Picture))))                         (when (%null-ptr-p PICT_h)                           (error "unable to allocate a ~a picture record handle (~a bytes) for ~s"                                  (rlength :Picture)                                  (slot-value sv 'PICT-file)))                         (with-dereferenced-handles ((PICT_p PICT_h))                           (get-PICT-file-info (slot-value sv 'PICT-file) PICT_p))                         PICT_h))))))(defmethod graphic-size ((sv PICT-svm) PICT-handle)  (declare (ignore sv))  (subtract-points   (rref PICT-handle :Picture.picFrame.botRight :storage :handle)   (rref PICT-handle :Picture.picFrame.topLeft  :storage :handle)))(defmethod draw-graphic ((sv PICT-svm) PICT-handle rect)  (when (view-needs-update sv)    (let ((win (view-window sv)))      (when (and (view-container sv) win)        (with-back-color (back-color sv)          (view-erase sv))))    (ecase (slot-value sv 'PICT-storage)      (:memory (Draw-PICT PICT-handle rect))      (:disk   (draw-picture-from-file (slot-value sv 'PICT-file) rect)))))(defmethod back-color ((sv PICT-svm))  *white-color*)(defmethod view-default-size ((sv PICT-svm))  (add-points (multiple-value-call #'add-points (graphic-margins sv)) #@(100 100)))(defmethod set-view-PICT ((sv PICT-svm) &key PICT-id PICT-name PICT-handle PICT-file PICT-storage)  (when PICT-file (setf (slot-value sv 'PICT-file) PICT-file))  (when PICT-storage (setf (slot-value sv 'PICT-storage) PICT-storage))  (set-view-resource sv :rsrc-id PICT-id :rsrc-name PICT-name :rsrc-handle PICT-handle));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
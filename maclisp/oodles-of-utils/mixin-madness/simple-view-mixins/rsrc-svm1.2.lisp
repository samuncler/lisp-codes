(in-package :oou)(oou-provide :rsrc-svm);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; rsrc-svm.Lisp;;;; Copyright � 1992 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; Dialog item mixin for handling resources.;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :Resources-u)(export '(rsrc-svm set-view-resource rsrc-get-fn rsrc-dispose-fn));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defclass rsrc-svm ()  ((rsrc-type                :initarg :rsrc-type)   (rsrc-id                  :initarg :rsrc-id)   (rsrc-name                :initarg :rsrc-name)   (rsrc-handle              :initarg :rsrc-handle)   (detach-p                 :initarg :detach-p)   (dispose-rsrc-on-remove-p :initarg :dispose-rsrc-on-remove-p))  (:default-initargs    :dispose-rsrc-on-remove-p t :detach-p nil))(defmethod install-view-in-window :after ((sv rsrc-svm) window)  (declare (ignore window))  (rsrc-handle-install sv))(defmethod remove-view-from-window :after ((sv rsrc-svm))  (rsrc-handle-remove sv))(defmethod rsrc-handle-install ((sv rsrc-svm))  (with-slots (rsrc-type rsrc-id rsrc-name rsrc-handle detach-p) sv    (cond ((slot-boundp sv 'rsrc-handle))          ((slot-boundp sv 'rsrc-id)           (setf rsrc-handle (rsrc-get-fn sv rsrc-type rsrc-id)))          ((slot-boundp sv 'rsrc-name)           (setf rsrc-handle (rsrc-get-fn sv rsrc-type rsrc-name))))    (when (and detach-p (slot-boundp sv 'rsrc-handle) (resource-handlep rsrc-handle))      (#_DetachResource rsrc-handle))))(defmethod rsrc-handle-remove ((sv rsrc-svm))  (when (slot-boundp sv 'rsrc-handle)    (with-macptrs ((rsrc-handle (slot-value sv 'rsrc-handle)))      (slot-makunbound sv 'rsrc-handle)      (when (slot-value sv 'dispose-rsrc-on-remove-p)        (rsrc-dispose-fn sv rsrc-handle (resource-handlep rsrc-handle))))))(defmethod set-view-resource ((sv rsrc-svm) &key rsrc-type rsrc-id rsrc-name rsrc-handle)  (when rsrc-type (setf (slot-value sv 'rsrc-type) rsrc-type))  (slot-makunbound sv 'rsrc-id)  (slot-makunbound sv 'rsrc-name)  (without-interrupts   (rsrc-handle-remove sv)   (cond (rsrc-handle (setf (slot-value sv 'rsrc-handle) rsrc-handle))         (rsrc-id     (setf (slot-value sv 'rsrc-id)     rsrc-id))         (rsrc-name   (setf (slot-value sv 'rsrc-name)   rsrc-name)))   (when (wptr sv) (rsrc-handle-install sv))))(defmethod rsrc-get-fn ((sv rsrc-svm) rsrc-type rsrc-id-or-name)  (get-resource rsrc-type rsrc-id-or-name))(defmethod rsrc-dispose-fn ((sv rsrc-svm) rsrc-handle rsrc-handlep)  (if rsrc-handlep    (#_ReleaseResource rsrc-handle)    (#_DisposeHandle rsrc-handle)));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|   examples can be found in graphic-rsrc-svm, PICT-svm, PICT-di, ICON-di, cicn-di|#
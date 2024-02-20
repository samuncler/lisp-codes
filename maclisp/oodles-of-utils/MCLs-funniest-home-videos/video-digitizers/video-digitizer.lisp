(in-package :oou)(oou-provide :video-digitizer);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; video-digitizer.lisp;;;; Copyright � 1992 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; object for controling a video digitizer;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(export '(vd-nz-error-check          vd-error-code-alist          vd-init          vd-dispose          vd-install-settings          vd-grab-one-frame          vd-start-digitizing          vd-stop-digitizing          vd-digitizing-p                    src-rect-topLeft          src-rect-botRight          dig-rect-topLeft          dig-rect-botRight          dest-rect-topLeft          dest-rect-botRight          input-format          input-standard          black-level          white-level          contrast          hue          saturation          sharpness                    vd-set-src-rect          vd-set-dig-rect          vd-set-dest-rect          vd-set-input-format          vd-set-input-standard          vd-set-black-level          vd-set-white-level          vd-set-contrast          vd-set-hue          vd-set-saturation          vd-set-sharpness          ));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defclass video-digitizer ()  ((card-num           :initarg  :card-num                       :reader   card-num)   (dest-wptr          :initarg  :dest-wptr                       :reader   dest-wptr)   (digitizing-flag    :initform nil)   (vd-init-flag       :initform nil)   (src-rect-topLeft   :initarg :src-rect-topLeft                       :accessor src-rect-topLeft)   (src-rect-botRight  :initarg :src-rect-botRight                       :accessor src-rect-botRight)   (dig-rect-topLeft   :initarg :dig-rect-topLeft                       :accessor dig-rect-topLeft)   (dig-rect-botRight  :initarg :dig-rect-botRight                       :accessor dig-rect-botRight)   (dest-rect-topLeft  :initarg :dest-rect-topLeft                       :accessor dest-rect-topLeft)   (dest-rect-botRight :initarg :dest-rect-botRight                       :accessor dest-rect-botRight)      (input-format       :initarg :input-format                       :accessor input-format)   (input-standard     :initarg :input-standard                       :accessor input-standard)       (black-level        :initarg :black-level                       :accessor black-level)    (white-level        :initarg :white-level                       :accessor white-level)   (contrast           :initarg :contrast                       :accessor contrast)   (hue                :initarg :hue                       :accessor hue)   (saturation         :initarg :saturation                       :accessor saturation)   (sharpness          :initarg :sharpness                       :accessor sharpness))  (:default-initargs    :card-num           1    :input-format       :composite    :input-standard     :NTSC    :black-level        :unsupported    :white-level        :unsupported    :contrast           :unsupported    :hue                :unsupported    :saturation         :unsupported    :sharpness          :unsupported   ))(defmethod vd-nz-error-check ((vd video-digitizer) error-code)  (unless (zerop error-code)    (error "(~a) ~a"           error-code           (or (rest (assoc error-code (vd-error-code-alist vd) :test #'eql))               "unknown error code"))))(defmethod vd-error-code-alist ((vd video-digitizer)))(defmethod vd-init ((vd video-digitizer))  (multiple-value-bind (max-tl max-br) (vd-max-src-rect-corners vd)    (unless (slot-boundp vd 'src-rect-topLeft)      (setf (src-rect-topLeft vd) max-tl))    (unless (slot-boundp vd 'src-rect-botRight)      (setf (src-rect-botRight vd) max-br))    (unless (slot-boundp vd 'dig-rect-topLeft)      (setf (dig-rect-topLeft vd) max-tl))    (unless (slot-boundp vd 'dig-rect-botRight)      (setf (dig-rect-botRight vd) max-br))))(defmethod vd-init :after ((vd video-digitizer))  (setf (slot-value vd 'vd-init-flag) t))(defmethod vd-dispose ((vd video-digitizer))  (when (vd-digitizing-p vd) (vd-stop-digitizing vd)))(defmethod vd-dispose :after ((vd video-digitizer))  (setf (slot-value vd 'vd-init-flag) nil))(defgeneric vd-GDevice (vd))(defmethod vd-max-src-rect-corners ((vd video-digitizer))  (declare (ignore vd)))(defmethod vd-grab-one-frame ((vd video-digitizer))  (vd-install-settings vd))(defmethod vd-start-digitizing ((vd video-digitizer))  (vd-install-settings vd)  (setf (slot-value vd 'digitizing-flag) t))(defmethod vd-stop-digitizing ((vd video-digitizer))  (setf (slot-value vd 'digitizing-flag) nil))(defmethod vd-digitizing-p ((vd video-digitizer))  (and (slot-value vd 'vd-init-flag) (slot-value vd 'digitizing-flag)))(defmethod vd-install-settings ((vd video-digitizer))  (vd-set-src-rect  vd (src-rect-topLeft vd)  (src-rect-botRight vd))  (vd-set-dig-rect  vd (dig-rect-topLeft vd)  (dig-rect-botRight vd))  (vd-set-dest-rect vd (dest-rect-topLeft vd) (dest-rect-botRight vd))    (vd-set-input-format   vd (input-format vd))  (vd-set-input-standard vd (input-standard vd))    (vd-set-black-level vd (black-level vd))  (vd-set-white-level vd (white-level vd))  (vd-set-contrast    vd (contrast vd))  (vd-set-hue         vd (hue vd))  (vd-set-saturation  vd (saturation vd))  (vd-set-sharpness   vd (sharpness vd)));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; set functions for video control values on the digitizer board;;; the defaults do nothing for it's up to the board specific specializations(defmethod vd-set-src-rect ((vd video-digitizer) topLeft botRight)  (declare (ignore vd topLeft botRight)))(defmethod vd-set-dig-rect ((vd video-digitizer) topLeft botRight)  (declare (ignore vd topLeft botRight)))(defmethod vd-set-dest-rect ((vd video-digitizer) topLeft botRight)  (declare (ignore vd topLeft botRight)))(defmethod vd-set-input-format ((vd video-digitizer) format)  (declare (ignore vd format)))(defmethod vd-set-input-standard ((vd video-digitizer) standard)  (declare (ignore vd standard)))(defmethod vd-set-black-level ((vd video-digitizer) level)  (declare (ignore vd level)))(defmethod vd-set-white-level ((vd video-digitizer) level)  (declare (ignore vd level)))(defmethod vd-set-contrast ((vd video-digitizer) contrast)  (declare (ignore vd contrast)))(defmethod vd-set-hue ((vd video-digitizer) hue)  (declare (ignore vd hue)))(defmethod vd-set-saturation ((vd video-digitizer) saturation)  (declare (ignore vd saturation)))(defmethod vd-set-sharpness ((vd video-digitizer) sharpness)  (declare (ignore vd sharpness)));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; after methods for slot setf accessors;;; (handle updating current board settings if the board is currently digitizing)(defmethod (setf src-rect-topLeft) :after (new-topLeft (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-src-rect vd new-topLeft (src-rect-botRight vd))))(defmethod (setf src-rect-botRight) :after (new-botRight (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-src-rect vd (src-rect-topLeft vd) new-botRight)))(defmethod (setf dig-rect-topLeft) :after (new-topLeft (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-dig-rect vd new-topLeft (dig-rect-botRight vd))))(defmethod (setf dig-rect-botRight) :after (new-botRight (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-dig-rect vd (dig-rect-topLeft vd) new-botRight)))(defmethod (setf dest-rect-topLeft) :after (new-topLeft (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-dest-rect vd new-topLeft (dest-rect-botRight vd))))(defmethod (setf dest-rect-botRight) :after (new-botRight (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-dest-rect vd (dest-rect-topLeft vd) new-botRight)))(defmethod (setf input-format) :after (new-format (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-input-format vd new-format)))(defmethod (setf input-standard) :after (new-standard (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-input-standard vd new-standard)))(defmethod (setf black-level) :after (new-level (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-black-level vd new-level)))(defmethod (setf white-level) :after (new-level (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-white-level vd new-level)))(defmethod (setf contrast) :after (new-contrast (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-contrast vd new-contrast)))(defmethod (setf hue) :after (new-hue (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-hue vd new-hue)))(defmethod (setf saturation) :after (new-saturation (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-saturation vd new-saturation)))(defmethod (setf sharpness) :after (new-sharpness (vd video-digitizer))  (when (vd-digitizing-p vd)    (vd-set-sharpness vd new-sharpness)));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|examples can be found in the board specific -vd files|#
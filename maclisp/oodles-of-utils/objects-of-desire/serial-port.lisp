(in-package :oou)(oou-provide :serial-port);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; :serial-port.lisp;;;; Copyright � 1991 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; object for controling a Macintosh serial port;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(oou-dependencies :+Devices :+Serial :macptr-u :traps-u )(export '(serial-port          port baud stop-bits parity data-bits          set-baud set-stop-bits set-parity set-data-bits          sport-open-p sport-open sport-close          sport-flush sport-chars-avail          sport-read-char sport-read-line          sport-write-char sport-write-line          ));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defclass serial-port ()  ((drvr-refnum-in    :reader      drvr-refnum-in                      :allocation :class)   (drvr-refnum-out   :reader      drvr-refnum-out                      :allocation :class)   (ref-count-modem   :initform    0                      :allocation :class)   (ref-count-printer :initform    0                      :allocation :class)   (port              :initarg    :port                      :reader      port)   (baud              :initarg    :baud                      :reader      baud)   (stop-bits         :initarg    :stop-bits                      :reader      stop-bits)   (parity            :initarg    :parity                      :reader      parity)   (data-bits         :initarg    :data-bits                      :reader      data-bits)   (eoln-char         :initarg    :eoln-char                      :accessor    eoln-char))  (:default-initargs    :port             :modem    :baud             9600    :stop-bits        1.0    :parity           :none    :data-bits        8    :open-on-init-p   t    :config-on-init-p t    :flush-on-init-p  t    :eoln-char        #\return))(defmethod initialize-instance :after ((sp serial-port) &rest initargs                                       &key                                       open-on-init-p                                       config-on-init-p                                       flush-on-init-p)  (declare (dynamic-extent initargs)           (ignore initargs))  (when open-on-init-p (sport-open sp :config-p config-on-init-p :flush-p flush-on-init-p)))(defmethod ref-count ((sp serial-port))  (ecase (port sp)    (:modem   (slot-value sp 'ref-count-modem))    (:printer (slot-value sp 'ref-count-printer))))(defmethod (setf ref-count) (count (sp serial-port))  (ecase (port sp)    (:modem   (setf (slot-value sp 'ref-count-modem) count))    (:printer (setf (slot-value sp 'ref-count-printer) count))));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; set methods for the serial port settings slots(defmethod set-baud ((sp serial-port) baud &key (config-p t))  (setf (slot-value sp 'baud) baud)  (when config-p (sport-config sp)))(defmethod set-stop-bits ((sp serial-port) stop-bits &key (config-p t))  (setf (slot-value sp 'stop-bits) stop-bits)  (when config-p (sport-config sp)))(defmethod set-parity ((sp serial-port) parity &key (config-p t))  (setf (slot-value sp 'parity) parity)  (when config-p (sport-config sp)))(defmethod set-data-bits ((sp serial-port) data-bits &key (config-p t))  (setf (slot-value sp 'data-bits) data-bits)  (when config-p (sport-config sp)));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(defmethod sport-open-p ((sp serial-port))  (and (slot-boundp sp 'drvr-refnum-in)       (slot-boundp sp 'drvr-refnum-out)))(defmethod sport-open ((sp serial-port) &key (config-p t) (flush-p t))  (when (zerop (ref-count sp))    (with-pstrs ((in-name_p  (ecase (port sp) (:printer ".BIn")  (:modem ".AIn")))                 (out-name_p (ecase (port sp) (:printer ".BOut") (:modem ".AOut"))))      (rlet ((in-refNum_p  :integer)             (out-refNum_p :integer))        (trap-nz-echeck (#~OpenDriver in-name_p  in-refnum_p))        (trap-nz-echeck (#~OpenDriver out-name_p out-refnum_p))        (setf (slot-value sp 'drvr-refnum-in ) (%get-signed-word in-refnum_p))        (setf (slot-value sp 'drvr-refnum-out) (%get-signed-word out-refnum_p))))    (when config-p (sport-config sp))    (when flush-p (sport-flush sp)))  (incf (ref-count sp)))(defmethod sport-close ((sp serial-port))  (when (plusp (ref-count sp))    (decf (ref-count sp))    (when (zerop (ref-count sp))      (let ((in-refnum  (drvr-refnum-in sp))            (out-refnum (drvr-refnum-out sp)))        (slot-makunbound sp 'drvr-refnum-in)        (slot-makunbound sp 'drvr-refnum-out)        (trap-nz-echeck (#~CloseDriver in-refnum))        (trap-nz-echeck (#~CloseDriver out-refnum))))))(defmethod sport-config-bits ((sp serial-port))  (+ (ecase (baud sp)       (  300 #.#$baud300)       (  600 #.#$baud600)       ( 1200 #.#$baud1200)       ( 1800 #.#$baud1800)       ( 2400 #.#$baud2400)       ( 3600 #.#$baud3600)       ( 4800 #.#$baud4800)       ( 7200 #.#$baud7200)       ( 9600 #.#$baud9600)       (19200 #.#$baud19200)       (57600 #.#$baud57600))     (ecase (stop-bits sp)       (1.0 #.#$stop10)       (1.5 #.#$stop15)       (2.0 #.#$stop20))     (ecase (parity sp)       (:none #.#$noParity)       (:odd  #.#$oddParity)       (:even #.#$evenParity))     (ecase (data-bits sp)       (5 #.#$data5)       (6 #.#$data6)       (7 #.#$data7)       (8 #.#$data8))))(defmethod sport-config ((sp serial-port))  (let ((config-bits (sport-config-bits sp)))    (trap-nz-echeck (#~SerReset (drvr-refnum-in  sp) config-bits))    (trap-nz-echeck (#~SerReset (drvr-refnum-out sp) config-bits))))(defmethod sport-flush ((sp serial-port))  (let ((refnum (drvr-refnum-in sp)))    (rlet ((count_p :longint))      (trap-nz-echeck (#~SerGetBuf refnum count_p))      (let ((count (%get-signed-long count_p)))        (when (zerop count) (return-from sport-flush t))        (%stack-block ((buf_p count))          (trap-nz-echeck (#~FSRead refnum count_p buf_p)))))))(defmethod sport-chars-avail ((sp serial-port))  (let ((refnum (drvr-refnum-in sp)))    (rlet ((count_p :longint))      (trap-nz-echeck (#~SerGetBuf refnum count_p))      (%get-signed-long count_p))))(defmethod sport-read-char ((sp serial-port) &key (wait-p nil))  (let ((refnum (drvr-refnum-in sp)))        ;wait/check for available char    (loop (when (plusp (sport-chars-avail sp)) (return))          (unless wait-p (return-from sport-read-char nil)))        ;get the char    (rlet ((count_p :longint)           (char_p  :character))      (%put-long count_p 1)      (trap-nz-echeck (#~FSRead refnum count_p char_p))      (unless (= 1 (%get-signed-long count_p))        (error "Reading 1 characater from serial port failed."))      (%get-character char_p))))    (defmethod sport-read-line ((sp serial-port)                            &key                            (wait-p nil)                            (wait-eoln-p wait-p)                            (eoln-char (eoln-char sp)))  (let ((str (make-array 0                         :element-type 'base-character                         :fill-pointer 0                         :adjustable t)))    (loop      (let ((c (sport-read-char sp :wait-p wait-p)))        (if c          (if (char= c eoln-char)            (return-from sport-read-line (values str t))            (vector-push-extend c str))          (unless (or wait-p (and wait-eoln-p (plusp (length str))))            (return-from sport-read-line (values str nil))))))))(defmethod sport-write-char ((sp serial-port) char)  (rlet ((count_p :longint)         (char_p  :character))    (%put-long count_p 1)    (%put-character char_p char)    (trap-nz-echeck (#~FSWrite (drvr-refnum-out sp) count_p char_p))    (unless (= 1 (%get-signed-long count_p))      (error "Writing 1 character to serial port failed (~a written)."             (%get-signed-long count_p))))  t)(defmethod sport-write-line ((sp serial-port) string &key (eoln-char (eoln-char sp)))  (let ((len (length string)))    (rlet ((count_p :longint))      (%put-long count_p (1+ len))      (with-cstrs ((text_p string))        (%put-character text_p eoln-char len)        (trap-nz-echeck (#~FSWrite (drvr-refnum-out sp) count_p text_p))        (unless (= (1+ len) (%get-signed-long count_p))          (error "Writing ~a characters to serial port failed (~a written)."                 (1+ len)                 (%get-signed-long count_p))))))  t);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#|;a modest example - on a Pioneer laserdisc player(setf sp (make-instance 'serial-port :port :printer :baud 1200 )) ;open drawer(progn  (sport-write-line sp "ST")  (list   (sport-read-line sp :wait-p t)   (sport-read-line sp :wait-p t)));close drawer(progn  (sport-write-line sp "PL")  (list   (sport-read-line sp :wait-p t)   (sport-read-line sp :wait-p t)))(progn  (sport-write-line sp "?D")  (sport-read-line sp :wait-p t))(sport-chars-avail sp)(sport-close sp)|#
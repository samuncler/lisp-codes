;;; -*- package: CCL -*-;;;;;;; Adding passive connections to MacTCP;;;(in-package "CCL")(defun  %tcp-control (pb code &optional ignore-error-p (wait-for-connection t))  (setf (rref pb tcpioPB.csCode) code        (rref pb tcpioPB.ioCompletion) (%null-ptr))  (let* ((err nil))    (progn        (loop          (when (and (eql (setq err (#_control :async pb)) 0)                     wait-for-connection)            (let* ((*interrupt-level* 0))              (while (> (setq err (rref pb tcpioPB.ioResult)) 0))))          (unless (eql err -23016) (return)))        (unless (or ignore-error-p (eql err 0))          (%tcp-err-disp err))        err))); Wait for a connection (from any host, port) to us.(defun %tcp-passive-open (pb port &optional (wait-for-connection t))  (setf (rref pb tcpioPB.open.validityFlags) 0        (rref pb tcpioPB.open.localPort) port        (rref pb tcpioPB.open.optionCnt) 0        (rref pb tcpioPB.open.remoteHost) 0        (rref pb tcpioPB.open.remotePort) 0        (rref pb tcpioPB.open.timeToLive) 0)      ; time-to-live = 60 hops  (%tcp-control pb $TCPPassiveOpen nil wait-for-connection))(defmethod initialize-instance ((s tcp-stream) &key                                host                                port                                (wait-for-connection t)                                (tcpbufsize 8192)                                (rdsentries 6)                                (writebufsize 1024)                                notify-proc                                (commandtimeout 30))  (call-next-method)  (let (pb)    (unless (integerp port)      (setq port (or (cdr (assoc (require-type port '(or string symbol))                                 *service-name-number-alist* :test #'string-equal))                     (error "Unknown port ~S" port))))    (when host      (setq host (tcp-host-address host)))    (unwind-protect      (progn        (setq pb (#_NewPtr :clear :errchk (+ $tcpPBSize tcpbufsize writebufsize (+ (* 6 rdsentries) 2))))        (%tcp-create pb (ccl:%inc-ptr pb $tcpPBSize) tcpbufsize notify-proc)        (if host          (%tcp-active-open pb host port)          (%tcp-passive-open pb port wait-for-connection))        (setf (slot-value s 'conn)              (make-conn :pb pb                         :write-buffer (ccl:%inc-ptr pb (+ $tcpPBSize tcpbufsize))                         :write-bufsize writebufsize                         :write-count 0                         :read-timeout commandtimeout                         :untyi-char nil                         :rds (ccl:%inc-ptr pb (+ $tcpPBSize tcpbufsize writebufsize))                         :rds-entries rdsentries                         :rds-offset 0                         :read-count 0                         :read-bufptr (ccl:%null-ptr)))        (setq pb nil)        (push s *open-tcp-streams*)        s)      (when pb        (unless (ccl:%null-ptr-p (rref pb tcpioPB.StreamPtr))          (%tcp-control pb $TCPRelease T))        (#_DisposPtr pb)))))(defun open-tcp-stream (host port &key                             (element-type 'character)                             (wait-for-connection t)                             (tcpbufsize 8192)                             (rdsentries 6)                             (writebufsize 1024)                             notify-proc                             (commandtimeout 30))  (if (subtypep element-type 'character)    (make-instance 'tcp-stream      :host host :port port      :wait-for-connection wait-for-connection      :tcpbufsize tcpbufsize      :rdsentries rdsentries      :writebufsize writebufsize       :notify-proc notify-proc      :commandtimeout commandtimeout)    (make-instance 'binary-tcp-stream      :element-type element-type      :host host :port port      :wait-for-connection wait-for-connection      :tcpbufsize tcpbufsize      :rdsentries rdsentries      :writebufsize writebufsize       :notify-proc notify-proc      :commandtimeout commandtimeout)))
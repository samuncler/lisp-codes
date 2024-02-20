;;;-*-Mode: LISP; Package: CCL -*-;;	Change History (most recent first):;;  9 6/8/95   akh  another fix to last-frame-ptr for non current sg;;  8 5/15/95  akh  well the saved reg list really wasnt backwards;;  7 4/27/95  slh  ;;  6 4/25/95  akh  fix last-frame-ptr for other stack groups;;  4 4/24/95  akh  find-local-name had list of saved registers backwards;;                  child-frame was broken if not *current-stack-group*;;  (do not edit before this line!!); backtrace.lisp; low-level support for stack-backtrace printing; Copyright 1987-1988, Coral Software Corp.; Copyright 1989-1994, Apple Computer, Inc.; Copyright 1995, Digitool, Inc.(in-package :ccl);; Modification History;; 06/12/97 slh  bring up to date w/PPC version;  4/27/95 slh  print-call-history: keyword args!;  4/18/95 slh  print-call-history: mods. for non-current sg's; also;               last-frame-ptr;  3/30/95 slh  merge in base-app changes;-------------- 3.0d18; This PRINTS the call history on *DEBUG-IO*.  It's more dangerous (because of;  stack consing) to actually return it.(defun print-call-history (&key (stack-group *current-stack-group*) (start-frame 0) (detailed-p t))  (let ((*standard-output* *debug-io*)        (*print-circle* *error-print-circle*))    (do* ((p (%get-frame-ptr stack-group) (parent-frame p stack-group))          (frame-number 0 (1+ frame-number))          (q (last-frame-ptr stack-group)))         ((or (null p) (>= p q))          (values))      (declare (fixnum frame-number))      (when (>= frame-number start-frame)        (multiple-value-bind (lfun pc) (cfp-lfun p stack-group)          (format t "~&(~x) : ~D ~S ~d"                  (index->address p) frame-number                  (if lfun (%lfun-name-string lfun))                  pc)          (when detailed-p            (dotimes (i (count-values-in-frame p stack-group))              (declare (fixnum i))              (multiple-value-bind (var type name)                                    (nth-value-in-frame p i stack-group lfun pc)                (format t "~&  ~D " i)                (when name (format t "~s" name))                (format t ": ~s" var)                (when type (format t " (~S)" type))))            (terpri)            (terpri)))))))(defun parent-frame (p sg)  (let ((e (stack-area-endptr p sg)))    (when e      (values (%next-cfp sg e p)))))(defun %caller (cstack)  (declare (%noforcestk))  (old-lap-inline ()   (if# (eq (ttagp ($ $t_fixnum) arg_z da))     (index->address arg_z atemp1)     (jsr_subprim $sp-findlfunv)     (if# (and (ne (move.l atemp0 da))               (eq (vsubtypep ($ $v_nlfunv) atemp0 da)))       (move.l ($ ($lfv_lfun)) acc)       (add.l atemp0 acc)       (bra @done)))   (move.l nilreg acc)   @done))(defun cfp-lfun (cstack sg &optional (child (child-frame cstack sg)))  (let* ((lfun nil)          (pc nil)          (endptr (if child (stack-area-endptr child sg))))    (when (and child endptr)      (lap-inline ()        (:variable cstack lfun pc child endptr)        (move.l (varg cstack) dtemp0)        (index->address dtemp0 da)        (move.l (varg child) dtemp0)        (index->address dtemp0 atemp0)        (move.l (varg endptr) dtemp0)        (index->address dtemp0 atemp1)        @loop            (add.w ($ 4) atemp0)        (cmp.l atemp0 da)        (beq @done)        (cmp.l atemp0 atemp1)        (if# eq          (move.l @atemp1 atemp0)          (move.l @atemp0 atemp1)          (bra @loop))        (movem.l #(atemp0 atemp1 da) -@sp)        (address->index atemp0 arg_z)        (ccall %caller arg_z)        (movem.l sp@+ #(atemp0 atemp1 da))        (if# (eq nilreg acc)          (bra @loop))        (if# (eq (varg lfun) acc)          (bra @loop))        (move.l acc (varg lfun))        (move.l @atemp0 db)        (sub.l acc db)        (mkint db)        (move.l db (varg pc))        (bra @loop)        @done))    (if lfun      (setq lfun (%lfun-vector-lfun (%lfun-vector lfun t))))    (values lfun pc)))(defun stack-area-endptr (p sg)  (old-lap   (index->address arg_y atemp0)   (move.l arg_z atemp1)   (move.l (atemp1 $sg.sgbuf) atemp1)   (move.l (svref atemp1 sgbuf.csbuf) atemp1)   (if# (eq (special *current-stack-group*) arg_z)     (move.l (a5 $csarea) arg_z)     (move.l sp (atemp1 $stackseg.first))    else#     (move.l atemp1 da)     (move.l (atemp1 $stackseg.first) atemp1)     (move.l (atemp1 $catch.cs_area) arg_z)     (move.l da atemp1))   (prog#    (if# (cc (atemp1 $stackseg.first) atemp0)      (bif (cs (atemp1 $stackseg.last) atemp0) (exit#)))    (move.l (atemp1 $stackseg.older) da)    (move.l da atemp1)    (bne (top#))    (ccall error '"Stack frame not in any segment"))   (move.l (atemp1 $stackseg.last) da)@loop   (if# (and (cs arg_z atemp0) (cc arg_z da))     (move.l arg_z atemp0)     (address->index atemp0 acc)     (lfret))   (move.l arg_z atemp1)   (move.l @atemp1 arg_z)   (if# eq     (move.l nilreg acc)     (lfret))   (move.l arg_z atemp1)   (move.l @atemp1 arg_z)   (bra @loop)))(defun index->address (i)  (lap-inline (i)    (vscale.l arg_z)    (jsr_subprim $sp-mkulong)))(defun address->index (addr)  (lap-inline (addr)    (jsr_subprim $sp-getulong)    (address->index arg_z acc)))(defun last-frame-ptr (&optional (sg *current-stack-group*))  (lap-inline ()    (:variable sg)    (move.l (varg sg) atemp1)    (with-preserved-registers #(asave0 asave1 dsave0 dsave1 dsave2)      (equate _vtop (* 5 4))      (move.l ($ 0) arg_z)      (move.l arg_z da)      (move.l ($ 3) dy)            (move.l atemp1 asave1)                       ; atemp1 is sg         (move.l (asave1 $sg.sgbuf) asave1)      (move.l (svref asave1 sgbuf.vsbuf) dsave0)  ; dsave0 has vsbuf      (move.l (svref asave1 sgbuf.csbuf) dsave1)  ; dsave1 has csbuf      (if# (eq (special *current-stack-group*) atemp1)        (move.l (a5 $csarea) atemp1)    ; now atemp1 has csarea        (move.l dsave1 atemp0)        (move.l sp (atemp0 $stackseg.first))        (lea (sp 4) asave0)             ; asave0 has cstack first + 4        (move.l (atemp0 $stackseg.last) dsave2)  ; dsave2 has end of c stackseg        (move.l dsave0 atemp0)        (move.l vsp (atemp0 $stackseg.first))                else#        (move.l dsave1 atemp1)        (move.l (atemp1 $stackseg.first) atemp1)        ; what goes in asave0?        (lea (atemp1 $catchfsize) asave0)        (move.l (atemp1 $catch.cs_area) atemp1)        (move.l dsave1 atemp0)        (move.l (atemp0 $stackseg.last) dsave2))      #|      (move.l (a5 $csarea) atemp1)              (lea (sp 4) asave0)      (move.l (special *current-stack-group*) asave1) ;;(varg sg)      (move.l (asave1 $sg.sgbuf) asave1)      (move.l (svref asave1 sgbuf.vsbuf) dsave0)      (move.l (svref asave1 sgbuf.csbuf) dsave1)      (move.l dsave0 atemp0)      (move.l vsp (atemp0 $stackseg.first))      (move.l dsave1 atemp0)      (move.l (atemp0 $stackseg.last) dsave2)      |#      (bra @test)      @loop      (bif (eq asave0 dsave2) @nextseg)      (move.l asave0@+ atemp0)      (move.l atemp0 db)      (if# (and (ne asave0 atemp1)                (eq (and.w dy db))                (ne asave0 dsave2)                (pl (move.l @asave0 db))                (eq (btst ($ 0) db))                (cs (progn                      (move.l dsave0 asave1)                      (prog#                       (bif (and (cc (cmp.l asave1 atemp0))                                 (cs (cmp.l (asave1 $stackseg.last) atemp0)))                            (exit#))                       (move.l (asave1 $stackseg.older) asave1)                       (cmp.l da asave1)                       (bne (top#))))))        (move.w db atemp0)        (if# (ne db atemp0)          (move.l asave0 arg_z)          (sub.l ($ 4) arg_z)))      @test      (cmp.l asave0 atemp1)      (bne @loop)      (move.l @atemp1 asave0)      (cmp.l da asave0)      (if# ne        (move.l asave0@+ atemp1)        (cmp.l dsave2 asave0)        (bne @test)        @nextseg        (move.l dsave1 atemp0)        (move.l (atemp0 $stackseg.older) dsave1)        (move.l dsave1 atemp0)        (move.l (atemp0 $stackseg.first) asave0)        (move.l (atemp0 $stackseg.last) dsave2)        (bra @test))      (address->index arg_z acc))))(defun child-frame (p sg)  (let* ((sgbuf (sg-buffer sg))         (csbuf (sgbuf.csbuf sgbuf))         (csarea (if (eq sg *current-stack-group*)                   (address->index (%get-long (%currenta5) $csarea))                   (lap-inline ()                     (:variable csbuf)                     (move.l (varg csbuf) atemp0)                     (move.l (atemp0 $stackseg.first) atemp0)                     (move.l (atemp0 $catch.cs_area) acc)                     (address->index acc acc))))         (frame (if (eq sg *current-stack-group*)                  (lap-inline () (address->index sp acc))                  (lap-inline ()                    (:variable csbuf)                    (move.l (varg csbuf) atemp0)                    (move.l (atemp0 $stackseg.first) acc)                    (add.l ($ $catchfsize) acc)                    (address->index acc acc))))         last-frame)    ; frame was BOGUS if sg was not *current-stack-group* - result was crash    (loop      (setq last-frame frame)      (multiple-value-setq (frame csarea) (%next-cfp sg csarea frame))      (when (eql frame p)        (return last-frame))      (unless frame        (return nil))))); This returns the "logical" number of values in the frame, counting; special bindings as a single value.(defun count-values-in-frame (cstack-index sg &optional child-frame)  (let* ((vsp (frame-vsp cstack-index))         (child-vsp (frame-vsp (or child-frame (child-frame cstack-index sg)) vsp sg))         (n 0))    (until (eq vsp child-vsp)      (setq n (%i+ n 1))      (setq  vsp (%i- vsp (if (saved-binding-p sg vsp) 3 1))))    n))(defun saved-binding-p (sg voffset)  (old-lap-inline ()   (index->address arg_z da)   (sub.l ($ 8) da)   (move.l ($ 0) db)   (if# (eq (special *current-stack-group*) arg_y)     (move.l (a5 $db_link) atemp0)     else#     ;(debug "Other stack-group")     (move.l arg_y atemp0)     (move.l (atemp0 4) atemp0)     (move.l (svref atemp0 sgbuf.csbuf) atemp0)     (move.l (atemp0 $stackseg.first) atemp0)     (move.l (atemp0 $catch.dblink) atemp0))   (until# (eq atemp0 db)     (cmp.l atemp0 da)     (beq @found)     (move.l @atemp0 atemp0))   (move.l nilreg acc)   (bra @ret)@found   (move.l (a5 $t) acc)@ret)); Returns, of all things, an offset into the vstack.; If parent-vsp is specified, will ensure that the returned offset; is in the same stack segment as parent-vsp.(defun frame-vsp (cstack &optional parent-vsp sg)  (old-lap-inline ()   (index->address arg_x atemp0)   (move.l @atemp0 atemp0)   (if# (ne arg_y nilreg)     (index->address arg_y arg_y)     (if# (eq arg_z nilreg)       (move.l (special *current-stack-group*) arg_z))     (move.l arg_z atemp1)     (move.l (atemp1 $sg.sgbuf) atemp1)     (move.l (svref atemp1 sgbuf.vsbuf) atemp1)     (move.l ($ 0) arg_z)     (bra @test)     (prog#      (if# (and (cc (atemp1 $stackseg.first) atemp0)                (cs (atemp1 $stackseg.last) atemp0))        (if# (eq arg_y nilreg)          (move.l (atemp1 $stackseg.first) atemp0)          (bra (exit#)))        (bif (and (cc (atemp1 $stackseg.first) arg_y)                  (cs (atemp1 $stackseg.last) arg_y))             (exit#))        (move.l arg_y atemp0)        (move.l nilreg arg_y))      (move.l (atemp1 $stackseg.older) atemp1)      @test      (bif (ne arg_z atemp1) (top#))      (ccall error '"Can't find stack segment")))   (sub.l ($ 4) atemp0)   (address->index atemp0 acc)))(defun nth-value-in-frame (sp n sg &optional lfun pc child-frame &aux                               (i -1)                              (phys-cell i)                              special)  (declare (ignore child-frame))  (let* ((curvsp (frame-vsp sp)))    (let* ((val (loop                  (setq special (saved-binding-p sg curvsp)                         i (%i+ i 1)                        phys-cell (%i+ phys-cell (if special 3 1)))                  (if (eq n i)                    (return                      (access-lisp-data curvsp)))                  (setq curvsp (%i- curvsp (if special 3 1)))))           (argtype nil)           (argname nil))      (if special        (setq         argname          (if (eq (%type-of (setq argname (access-lisp-data (%i- curvsp 1))))                  'symbol-locative)           (%symbol-locative-symbol argname)           (nilreg-cell-symbol (lap-inline (argname)                                  (sub.l nilreg arg_z)                                  (movereg arg_z acc)                                 (mkint acc))))         argtype :saved-special)        (multiple-value-setq (argtype argname)                              (find-local-name phys-cell lfun pc)))	(when (closed-over-value-p val)	  (setq argtype :inherited)	  (setq val (lap-inline (val) (move.l arg_z atemp0) (move.l @atemp0 acc))))      (values (safe-cell-value val) argtype argname)))); Act as if VSTACK-INDEX points at some lisp data & return that data.(defun %access-lisp-data (vstack-index)  (lap-inline (vstack-index)    (index->address arg_z atemp0)    (move.l @atemp0 acc)))(defun access-lisp-data (vstack-index)  (let* ((data (%access-lisp-data vstack-index)))    (if (closed-over-value-p data)      (car data)      data)))(defun find-local-name (cellno lfun pc)  (let* ((n cellno))    (when lfun      (multiple-value-bind (mask where) (registers-used-by lfun pc)        (if (and where (< (1- where) n (+ where (logcount mask))))          (let ((j 5))            (decf n where)            (loop (loop (if (logbitp (decf j) mask) (return)))                  (if (< (decf n) 0) (return)))            (values (format nil "saved ~a" (nth j '(asave1 asave0 dsave2 dsave1 dsave0))) ;'(asave1 asave0 dsave2 dsave1 dsave0)))                    nil))          (multiple-value-bind (nreq nopt restp nkeys junk optinitp junk ncells nclosed)                               (if lfun (function-args lfun))            (declare (ignore junk optinitp))            (if nkeys (setq nkeys (+ nkeys nkeys)))            (values             (if (and ncells (< n ncells))               (if (< n nclosed)                 :inherited                 (if (< (setq n (- n nclosed)) nreq)                   "required"                   (if (< (setq n (- n nreq)) nopt)                     "optional"                     (progn                       (setq n (- n nopt))                       (if (and restp (eq n 0))                         "rest"                         (progn                           (if restp (setq n (1- n)))                           (if (and nkeys (< n nkeys))                             (if (not (logbitp 0 n)) ; a keyword                               "keyword"                               "key-supplied-p")                             "opt-supplied-p"))))))))             (let* ((info (function-symbol-map lfun))                    (syms (%car info))                    (ptrs (%cdr info)))               (when info                 (dotimes (i (length syms))                   (let ((j (%i+ i (%i+ i i ))))                     (and (eq (uvref ptrs j) (%ilogior (%ilsl 8 cellno) #o77))                          (%i>= pc (uvref ptrs (%i+ j 1)))                          (%i< pc (uvref ptrs (%i+ j 2)))                          (return (aref syms i))))))))))))))(defun function-args (lfun)  "Returns 9 values, as follows:     req = number of required arguments     opt = number of optional arguments     restp = t if rest arg, '&restv if restv arg     keys = number of keyword arguments or NIL if &key not mentioned     allow-other-keys = t if &allow-other-keys present     optinit = t if any optional arg has non-nil default value or supplied-p               variable     lexprp = t if function is a lexpr, in which case all other values are              undefined.     ncells = number of stack frame cells used by all arguments.     nclosed = number of inherited values (now counted distinctly from required)     All numeric values (but ncells) are mod 64."  (let* ((bits (lfun-bits lfun))         (req (ldb $lfbits-numreq bits))         (opt (ldb $lfbits-numopt bits))         (restp (logbitp $lfbits-rest-bit bits))         (restvp (if (logbitp $lfbits-restv-bit bits) '&restv))         (keyvect (lfun-keyvect lfun))         (keys (and keyvect (length keyvect)))         (allow-other-keys (logbitp $lfbits-aok-bit bits))         (optinit (logbitp $lfbits-optinit-bit bits))         ;(lexprp (logbitp $lfbits-lexprp bits)) ;currently not maintained         (lexprp nil)         (nclosed (ldb $lfbits-numinh bits)))    (values req opt (setq restp (or restp restvp)) keys allow-other-keys optinit lexprp            (unless (or lexprp (%ilogbitp $lfatr-novpushed-args-bit                                           (uvref (%lfun-vector lfun t) 0)))              (+ req opt (if restp 1 0) (if keys (+ keys keys) 0)                 (if optinit opt 0) nclosed))            nclosed)))(defun closed-over-value-p (value)  (old-lap-inline (value nil)   (if# (and (ne arg_y nilreg)             (eq (ttagp ($ $t_cons) arg_y da))             (eq (progn                   (move.l arg_y atemp0)                   (cmp.l ($ $magic_closure_value) (atemp0 (- $t_cons))))))     (add.w ($ $t_val) acc)))); from ccl4 backtrace - called by inspector(defun %store-lisp-data (vstack-index value)  (lap-inline (vstack-index value)    (index->address arg_y atemp0)    (move.l arg_z @atemp0)))(defun closed-over-value (data)  (if (closed-over-value-p data)    (car data)    data))(defun set-closed-over-value (value-cell value)  (setf (car value-cell) value))(defun safe-cell-value (val)  (let* ((fcell-offset (lap-inline (val nil)                         (if# (and (cc (a5 $fcells_start) arg_y)                                   (cs (a5 $fcells_end) arg_y))                           (move.l arg_y acc)                           (sub.l nilreg acc)                           (mkint acc)))))    (if fcell-offset      (setq val `(nilreg-fcell ,(or (nilreg-cell-symbol fcell-offset) fcell-offset)))      (let* ((vcell-offset (lap-inline (val nil)                             (if# (and (cc (a5 $vcells_start) arg_y)                                       (cs (a5 $vcells_end) arg_y))                               (move.l arg_y acc)                               (sub.l nilreg acc)                               (mkint acc)))))        (if vcell-offset          (setq val `(nilreg-vcell ,(or (nilreg-cell-symbol vcell-offset) vcell-offset))))))    val)); Returns two values:;  [nil, nil] if it can be reliably determined that function uses no registers at PC;  [mask, savevsp]  if it can be reliably determined that the registers specified by "mask";      were saved at "savevsp" in the function's stack frame;  [mask, nil] if registers in "mask" MAY have been saved, but we don't know how to restore them;      (perhaps because the "at-pc" argument wasn't specified.(defun registers-used-by (lfun &optional at-pc)  (let ((regs-used nil)        (where-saved nil))    (if (functionp lfun)      (let* ((vec (%lfun-vector lfun t))             (attr (uvref vec 0))             (uses-regs (%ilogbitp $lfatr-uses-regs-bit attr))             (mapheader (if uses-regs                          (if (%ilogbitp $lfatr-regmap-bit attr)                            (uvref vec (%i- (uvsize vec)                                            (%lfun-vector-mapwords vec nil)))))))        (when uses-regs          (if (not mapheader)            (setq regs-used (ldb $lfregs-regs-mask -1)) ; say that lfun use all of 'em, cause it may ...            (progn              (setq regs-used (ldb $lfregs-regs-mask mapheader))              (if (and at-pc (%ilogbitp $lfregs-simple-bit mapheader))                (setq where-saved (if (%i<= (ldb $lfregs-simple-pc-mask mapheader)                                            (%ilsr 1 at-pc))                                    (ldb $lfregs-simple-ea-mask mapheader)                                    (setq regs-used nil)))))))))  (values regs-used where-saved))); End of backtrace.lisp
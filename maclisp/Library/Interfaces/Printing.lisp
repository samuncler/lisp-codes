(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:Printing.p"; at Tuesday June 6,1995 2:05:23 pm.; ;  	File:		Printing.p;  ;  	Contains:	Print Manager Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC; $IFC UNDEFINED __PRINTING__; $SETC __PRINTING__ := 1; $I+; $SETC PrintingIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __ERRORS__|#(require-interface 'Errors)#|                                              ; $I Errors.p |#                                             ; $ENDC; 	ConditionalMacros.p											#|                                              ; $IFC UNDEFINED __QUICKDRAW__|#(require-interface 'Quickdraw)#|                                              ; $I Quickdraw.p |#                                             ; $ENDC; 	Types.p														; 	MixedMode.p													; 	QuickdrawText.p												; $IFC UNDEFINED __DIALOGS__(require-interface 'Dialogs)                    ; $I Dialogs.p; $ENDC; 	Memory.p													; 	Windows.p													; 		Events.p												; 			OSUtils.p											; 		Controls.p												; 			Menus.p												; 	TextEdit.p													; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $iPFMaxPgs 128)(defconstant $iPrPgFract 120)                   ; Page scale factor. ptPgSize (below) is in units of 1/iPrPgFract(defconstant $iPrPgFst 1)                       ; Page range constants(defconstant $iPrPgMax 9999)(defconstant $iPrRelease 3)                     ; Current version number of the code.(defconstant $iPrSavPFil -1)(defconstant $iPrAbort #x80)(defconstant $iPrDevCtl 7)                      ; The PrDevCtl Proc's ctl number(defconstant $lPrReset #x10000)                 ; The PrDevCtl Proc's CParam for reset(defconstant $lPrLineFeed #x30000)(defconstant $lPrLFStd #x3FFFF)                 ; The PrDevCtl Proc's CParam for std paper advance(defconstant $lPrLFSixth #x3FFFF)(defconstant $lPrPageEnd #x20000)               ; The PrDevCtl Proc's CParam for end page(defconstant $lPrDocOpen #x10000)(defconstant $lPrPageOpen #x40000)(defconstant $lPrPageClose #x20000)(defconstant $lPrDocClose #x50000)(defconstant $iFMgrCtl 8)                       ; The FMgr's Tail-hook Proc's ctl number(defconstant $iMscCtl 9)                        ; The FMgr's Tail-hook Proc's ctl number(defconstant $iPvtCtl 10)                       ; The FMgr's Tail-hook Proc's ctl number(defconstant $pPrGlobals #x944)                 ; The PrVars lo mem area:(defconstant $bDraftLoop 0)(defconstant $bSpoolLoop 1)(defconstant $bUser1Loop 2)(defconstant $bUser2Loop 3)(defconstant $fNewRunBit 2)(defconstant $fHiResOK 3)(defconstant $fWeOpenedRF 4); Driver constants (defconstant $iPrBitsCtl 4)(defconstant $lScreenBits 0)(defconstant $lPaintBits 1)(defconstant $lHiScreenBits #x2)                ; The Bitmap Print Proc's Screen Bitmap param(defconstant $lHiPaintBits #x3)                 ; The Bitmap Print Proc's Paint [sq pix] param(defconstant $iPrIOCtl 5)(defconstant $iPrEvtCtl 6)                      ; The PrEvent Proc's ctl number(defconstant $lPrEvtAll #x2FFFD)                ; The PrEvent Proc's CParam for the entire screen(defconstant $lPrEvtTop #x1FFFD)                ; The PrEvent Proc's CParam for the top folder(defconstant $iPrDrvrRef -3)(defconstant $getRslDataOp 4)(defconstant $setRslOp 5)(defconstant $draftBitsOp 6)(defconstant $noDraftBitsOp 7)(defconstant $getRotnOp 8)(defconstant $NoSuchRsl 1)(defconstant $OpNotImpl 2)                      ; the driver doesn't support this opcode(defconstant $RgType1 1)(defconstant $feedCut 0)(defconstant $feedFanfold 1)(defconstant $feedMechCut 2)(defconstant $feedOther 3)(def-mactype :tfeed (find-mactype ':signed-byte))(defconstant $scanTB 0)(defconstant $scanBT 1)(defconstant $scanLR 2)(defconstant $scanRL 3)(def-mactype :tscan (find-mactype ':signed-byte));  A Rect Ptr (def-mactype :tprect (find-mactype '(:pointer :rect)))(def-mactype :pridleprocptr (find-mactype ':pointer));  PROCEDURE PrIdle; (def-mactype :pridleupp (find-mactype ':pointer))(defconstant $uppPrIdleProcInfo #x0)            ;  PROCEDURE ; ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewPrIdleProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-no-return(deftrap "_CallPrIdleProc" ((userRoutine :pointer))   nil   (:register-trap #x4E90 :a0 userRoutine)); $ENDC(def-mactype :pitemprocptr (find-mactype ':pointer));  PROCEDURE PItem(theDialog: DialogPtr; item: INTEGER); (def-mactype :pitemupp (find-mactype ':pointer))(defconstant $uppPItemProcInfo #x2C0)           ;  PROCEDURE (4 byte param, 2 byte param); ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewPItemProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallPItemProc" ((theDialog (:pointer :grafport)) (item :signed-integer) (userRoutine :pointer))   nil   (#x205F #x4E90) ); $ENDC(defrecord TPrPort    (gPort :grafport)                            ; The Printer's graf port.   (gProcs :qdprocs)                            ; ..and its procs   (lGParam1 :signed-long)                      ; 16 bytes for private parameter storage.   (lGParam2 :signed-long)   (lGParam3 :signed-long)   (lGParam4 :signed-long)   (fOurPtr :boolean)                           ; Whether the PrPort allocation was done by us.   (fOurBits :boolean)                          ; Whether the BitMap allocation was done by us.   )(def-mactype :tpprport (find-mactype '(:pointer :tprport)));  Printing Graf Port. All printer imaging, whether spooling, banding, etc, happens "thru" a GrafPort.;   This is the "PrPeek" record. (defrecord TPrInfo    (iDev :signed-integer)                       ; Font mgr/QuickDraw device code   (iVRes :signed-integer)                      ; Resolution of device, in device coordinates   (iHRes :signed-integer)                      ; ..note: V before H => compatable with Point.   (rPage :rect)                                ; The page (printable) rectangle in device coordinates.   )(def-mactype :tpprinfo (find-mactype '(:pointer :tprinfo)));  Print Info Record: The parameters needed for page composition. (defrecord TPrStl    (wDev :signed-integer)   (iPageV :signed-integer)   (iPageH :signed-integer)   (bPort :signed-byte)   (feed :signed-byte)   )(def-mactype :tpprstl (find-mactype '(:pointer :tprstl)))(defrecord TPrXInfo    (iRowBytes :signed-integer)   (iBandV :signed-integer)   (iBandH :signed-integer)   (iDevBytes :signed-integer)   (iBands :signed-integer)   (bPatScale :signed-byte)   (bUlThick :signed-byte)   (bUlOffset :signed-byte)   (bUlShadow :signed-byte)   (scan :signed-byte)   (bXInfoX :signed-byte)   )(def-mactype :tpprxinfo (find-mactype '(:pointer :tprxinfo)))(defrecord TPrJob    (iFstPage :signed-integer)                   ; Page Range.   (iLstPage :signed-integer)   (iCopies :signed-integer)                    ; No. copies.   (bJDocLoop :signed-byte)                     ; The Doc style: Draft, Spool, .., and ..   (fFromUsr :boolean)                          ; Printing from an User's App (not PrApp) flag   (pIdleProc :pointer)                         ; The Proc called while waiting on IO etc.   (pFileName (:pointer (:string 255)))         ; Spool File Name: NIL for default.   (iFileVol :signed-integer)                   ; Spool File vol, set to 0 initially   (bFileVers :signed-byte)                     ; Spool File version, set to 0 initially   (bJobX :signed-byte)                         ; An eXtra byte.   )(def-mactype :tpprjob (find-mactype '(:pointer :tprjob)));  Print Job: Print "form" for a single print request. (defrecord TPrFlag1    (f15 :boolean)   (f14 :boolean)   (f13 :boolean)   (f12 :boolean)   (f11 :boolean)   (f10 :boolean)   (f9 :boolean)   (f8 :boolean)   (f7 :boolean)   (f6 :boolean)   (f5 :boolean)   (f4 :boolean)   (f3 :boolean)   (f2 :boolean)   (fLstPgFst :boolean)   (fUserScale :boolean)   )(defrecord (TPrint :handle)    (iPrVersion :signed-integer)                 ; (2) Printing software version   (prInfo :tprinfo)                            ; (14) the PrInfo data associated with the current style.   (rPaper :rect)                               ; (8) The paper rectangle [offset from rPage]   (prStl :tprstl)                              ; (8)  This print request's style.   (prInfoPT :tprinfo)                          ; (14)  Print Time Imaging metrics   (prXInfo :tprxinfo)                          ; (16)  Print-time (expanded) Print info record.   (prJob :tprjob)                              ; (20) The Print Job request (82)  Total of the above; 120-82 = 38 bytes needed to fill 120   (:variant       (      (printX (:array :signed-integer 19))      )      (      (prFlag1 :tprflag1)      (iZoomMin :signed-integer)      (iZoomMax :signed-integer)      (hDocName (:handle (:string 255)))      )      )   )(def-mactype :tpprint (find-mactype '(:pointer :tprint)))(def-mactype :thprint (find-mactype '(:handle :tprint)));  The universal 120 byte printing record (defrecord TPrStatus    (iTotPages :signed-integer)                  ; Total pages in Print File.   (iCurPage :signed-integer)                   ; Current page number   (iTotCopies :signed-integer)                 ; Total copies requested   (iCurCopy :signed-integer)                   ; Current copy number   (iTotBands :signed-integer)                  ; Total bands per page.   (iCurBand :signed-integer)                   ; Current band number   (fPgDirty :boolean)                          ; True if current page has been written to.   (fImaging :boolean)                          ; Set while in band's DrawPic call.   (hPrint (:handle :tprint))                   ; Handle to the active Printer record   (pPrPort (:pointer :tprport))                ; Ptr to the active PrPort   (hPic (:handle :picture))                    ; Handle to the active Picture   )(def-mactype :tpprstatus (find-mactype '(:pointer :tprstatus)));  Print Status: Print information during printing. (defrecord (TPfPgDir :handle)    (iPages :signed-integer)   (iPgPos (:array :signed-long 129))           ; ARRAY [0..iPfMaxPgs] OF LONGINT   )(def-mactype :tppfpgdir (find-mactype '(:pointer :tpfpgdir)))(def-mactype :thpfpgdir (find-mactype '(:handle :tpfpgdir)));  PicFile = a TPfHeader followed by n QuickDraw Pics (whose PicSize is invalid!) ;  This is the Printing Dialog Record. Only used by folks appending their own;    DITLs to the print dialogs.	Print Dialog: The Dialog Stream object. #|                                              ; $IFC STRICT_WINDOWS (def-mactype :tpprdlg (find-mactype ':pointer))(def-mactype :tpprdlgref (find-mactype ':pointer)) |#                                             ; $ELSEC(defrecord TPrDlg    (Dlg :dialogrecord)                          ; The Dialog window   (pFltrProc :pointer)                         ; The Filter Proc.   (pItemProc :pointer)                         ; The Item evaluating proc.   (hPrintUsr (:handle :tprint))                ; The user's print record.   (fDoIt :boolean)   (fDone :boolean)   (lUser1 :signed-long)                        ; Four longs for apps to hang global data.   (lUser2 :signed-long)                        ; Plus more stuff needed by the particular   (lUser3 :signed-long)                        ; printing dialog.   (lUser4 :signed-long)   )(def-mactype :tpprdlg (find-mactype '(:pointer :tprdlg)))(def-mactype :tpprdlgref (find-mactype '(:pointer :tprdlg))); $ENDC(def-mactype :pdlginitprocptr (find-mactype ':pointer));  FUNCTION PDlgInit(hPrint: THPrint): TPPrDlg; (def-mactype :pdlginitupp (find-mactype ':pointer))(defconstant $uppPDlgInitProcInfo #xF0)         ;  FUNCTION (4 byte param): 4 byte result; ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewPDlgInitProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallPDlgInitProc" ((hPrint (:handle :tprint)) (userRoutine :pointer))   (:pointer :tprdlg)   (#x205F #x4E90) ); $ENDC(defrecord TGnlData    (iOpCode :signed-integer)   (iError :signed-integer)   (lReserved :signed-long)                     ; more fields here depending on call   )(defrecord TRslRg    (iMin :signed-integer)   (iMax :signed-integer)   )(defrecord TRslRec    (iXRsl :signed-integer)   (iYRsl :signed-integer)   )(defrecord TGetRslBlk    (iOpCode :signed-integer)   (iError :signed-integer)   (lReserved :signed-long)   (iRgType :signed-integer)   (xRslRg :trslrg)   (yRslRg :trslrg)   (iRslRecCnt :signed-integer)   (rgRslRec (:array :trslrec 27))   )(defrecord TSetRslBlk    (iOpCode :signed-integer)   (iError :signed-integer)   (lReserved :signed-long)   (hPrint (:handle :tprint))   (iXRsl :signed-integer)   (iYRsl :signed-integer)   )(defrecord TDftBitsBlk    (iOpCode :signed-integer)   (iError :signed-integer)   (lReserved :signed-long)   (hPrint (:handle :tprint))   )(defrecord TGetRotnBlk    (iOpCode :signed-integer)   (iError :signed-integer)   (lReserved :signed-long)   (hPrint (:handle :tprint))   (fLandscape :boolean)   (bXtra :signed-byte)   ); $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrPurge" ()   nil   (:stack-trap #xA8FD ((+ (ash 43008 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrNoPurge" ()   nil   (:stack-trap #xA8FD ((+ (ash 45056 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrOpen" ()   nil   (:stack-trap #xA8FD ((+ (ash 51200 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrClose" ()   nil   (:stack-trap #xA8FD ((+ (ash 53248 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrintDefault" ((hPrint (:handle :tprint)))   nil   (:stack-trap #xA8FD hPrint ((+ (ash 8196 16) 1152) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrValidate" ((hPrint (:handle :tprint)))   (:stack :boolean)   (:stack-trap #xA8FD hPrint ((+ (ash 20996 16) 1176) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrStlDialog" ((hPrint (:handle :tprint)))   (:stack :boolean)   (:stack-trap #xA8FD hPrint ((+ (ash 10756 16) 1156) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrJobDialog" ((hPrint (:handle :tprint)))   (:stack :boolean)   (:stack-trap #xA8FD hPrint ((+ (ash 12804 16) 1160) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrStlInit" ((hPrint (:handle :tprint)))   (:stack (:pointer :tprdlg))   (:stack-trap #xA8FD hPrint ((+ (ash 15364 16) 1036) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrJobInit" ((hPrint (:handle :tprint)))   (:stack (:pointer :tprdlg))   (:stack-trap #xA8FD hPrint ((+ (ash 17412 16) 1040) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrJobMerge" ((hPrintSrc (:handle :tprint)) (hPrintDst (:handle :tprint)))   nil   (:stack-trap #xA8FD hPrintSrc hPrintDst ((+ (ash 22532 16) 2204) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrDlgMain" ((hPrint (:handle :tprint)) (pDlgInit :pointer))   (:stack :boolean)   (:stack-trap #xA8FD hPrint pDlgInit ((+ (ash 18948 16) 2196) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrOpenDoc" ((hPrint (:handle :tprint)) (pPrPort (:pointer :tprport)) (pIOBuf :pointer))   (:stack (:pointer :tprport))   (:stack-trap #xA8FD hPrint pPrPort pIOBuf ((+ (ash 1024 16) 3072) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrCloseDoc" ((pPrPort (:pointer :tprport)))   nil   (:stack-trap #xA8FD pPrPort ((+ (ash 2048 16) 1156) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrOpenPage" ((pPrPort (:pointer :tprport)) (pPageFrame (:pointer :rect)))   nil   (:stack-trap #xA8FD pPrPort pPageFrame ((+ (ash 4096 16) 2056) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrClosePage" ((pPrPort (:pointer :tprport)))   nil   (:stack-trap #xA8FD pPrPort ((+ (ash 6144 16) 1036) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrPicFile" ((hPrint (:handle :tprint)) (pPrPort (:pointer :tprport)) (pIOBuf :pointer) (pDevBuf :pointer) (prStatus (:pointer :tprstatus)))   nil   (:stack-trap #xA8FD hPrint pPrPort pIOBuf pDevBuf prStatus ((+ (ash 24581 16) 5248) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrError" ()   (:stack :signed-integer)   (:stack-trap #xA8FD ((+ (ash 47616 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrSetError" ((iErr :signed-integer))   nil   (:stack-trap #xA8FD iErr ((+ (ash 49152 16) 512) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrGeneral" ((pData :pointer))   nil   (:stack-trap #xA8FD pData ((+ (ash 28679 16) 1152) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrDrvrOpen" ()   nil   (:stack-trap #xA8FD ((+ (ash 32768 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrDrvrClose" ()   nil   (:stack-trap #xA8FD ((+ (ash 34816 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrCtlCall" ((iWhichCtl :signed-integer) (lParam1 :signed-long) (lParam2 :signed-long) (lParam3 :signed-long))   nil   (:stack-trap #xA8FD iWhichCtl lParam1 lParam2 lParam3 ((+ (ash 40960 16) 3584) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrDrvrDCE" ()   (:stack :handle)   (:stack-trap #xA8FD ((+ (ash 37888 16) 0) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_PrDrvrVers" ()   (:stack :signed-integer)   (:stack-trap #xA8FD ((+ (ash 39424 16) 0) :signed-longint))); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := PrintingIncludes; $ENDC                                         ; __PRINTING__#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC(provide-interface 'Printing)
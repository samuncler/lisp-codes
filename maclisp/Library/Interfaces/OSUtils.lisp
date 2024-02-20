(in-package :TRAPS);;;;;;;;;;;;;;;;;;;;;;;;;;; Modification History;;;; 03/06/96 bill Map old names to new names;;; Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:OSUtils.p"; at Tuesday June 6,1995 1:59:54 pm.; ;  	File:		OSUtils.p;  ;  	Contains:	OS Utilities Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC; $IFC UNDEFINED __OSUTILS__; $SETC __OSUTILS__ := 1; $I+; $SETC OSUtilsIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											; $IFC UNDEFINED __MIXEDMODE__(require-interface 'MixedMode)                  ; $I MixedMode.p; $ENDC; $IFC UNDEFINED __MEMORY__(require-interface 'Memory)                     ; $I Memory.p; $ENDC; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $useFree 0)(defconstant $useATalk 1)(defconstant $useAsync 2)(defconstant $useExtClk 3)                      ; Externally clocked(defconstant $useMIDI 4);  Environs Equates (defconstant $curSysEnvVers 2)                  ; Updated to equal latest SysEnvirons version;  Machine Types (defconstant $envMac -1)(defconstant $envXL -2)(defconstant $envMachUnknown 0)(defconstant $env512KE 1)(defconstant $envMacPlus 2)(defconstant $envSE 3)(defconstant $envMacII 4)(defconstant $envMacIIx 5)(defconstant $envMacIIcx 6)(defconstant $envSE30 7)(defconstant $envPortable 8)(defconstant $envMacIIci 9)(defconstant $envMacIIfx 11);  CPU types (defconstant $envCPUUnknown 0)(defconstant $env68000 1)(defconstant $env68010 2)(defconstant $env68020 3)(defconstant $env68030 4)(defconstant $env68040 5);  Keyboard types (defconstant $envUnknownKbd 0)(defconstant $envMacKbd 1)(defconstant $envMacAndPad 2)(defconstant $envMacPlusKbd 3)(defconstant $envAExtendKbd 4)(defconstant $envStandADBKbd 5)(defconstant $envPrtblADBKbd 6)(defconstant $envPrtblISOKbd 7)(defconstant $envStdISOADBKbd 8)(defconstant $envExtISOADBKbd 9)(defconstant $false32b 0)                       ; 24 bit addressing error(defconstant $true32b 1)                        ; 32 bit addressing error;  result types for RelString Call (defconstant $sortsBefore -1)                   ; first string < second string(defconstant $sortsEqual 0)                     ; first string = second string(defconstant $sortsAfter 1)                     ; first string > second string;  Toggle results (defconstant $toggleUndefined 0)(defconstant $toggleOK 1)(defconstant $toggleBadField 2)(defconstant $toggleBadDelta 3)(defconstant $toggleBadChar 4)(defconstant $toggleUnknown 5)(defconstant $toggleBadNum 6)(defconstant $toggleOutOfRange 7)               ; synonym for toggleErr3(defconstant $toggleErr3 7)(defconstant $toggleErr4 8)(defconstant $toggleErr5 9);  Date equates (defconstant $smallDateBit 31)                  ; Restrict valid date/time to range of Time global(defconstant $togChar12HourBit 30)              ; If toggling hour by char, accept hours 1..12 only(defconstant $togCharZCycleBit 29)              ; Modifier for togChar12HourBit: accept hours 0..11 only(defconstant $togDelta12HourBit 28)             ; If toggling hour up/down, restrict to 12-hour range (am/pm)(defconstant $genCdevRangeBit 27)               ; Restrict date/time to range used by genl CDEV(defconstant $validDateFields -1)(defconstant $maxDateField 10)(defconstant $eraMask #x1)(defconstant $yearMask #x2)(defconstant $monthMask #x4)(defconstant $dayMask #x8)(defconstant $hourMask #x10)(defconstant $minuteMask #x20)(defconstant $secondMask #x40)(defconstant $dayOfWeekMask #x80)(defconstant $dayOfYearMask #x100)(defconstant $weekOfYearMask #x200)(defconstant $pmMask #x400)(defconstant $dateStdMask #x7F)                 ; default for ValidDate flags and ToggleDate TogglePB.togFlags(defconstant $eraField 0)(defconstant $yearField 1)(defconstant $monthField 2)(defconstant $dayField 3)(defconstant $hourField 4)(defconstant $minuteField 5)(defconstant $secondField 6)(defconstant $dayOfWeekField 7)(defconstant $dayOfYearField 8)(defconstant $weekOfYearField 9)(defconstant $pmField 10)(defconstant $res1Field 11)(defconstant $res2Field 12)(defconstant $res3Field 13)(def-mactype :longdatefield (find-mactype ':signed-byte))(defconstant $dummyType 0)(defconstant $vType 1)(defconstant $ioQType 2)(defconstant $drvQType 3)(defconstant $evType 4)(defconstant $fsQType 5)(defconstant $sIQType 6)(defconstant $dtQType 7)(defconstant $nmType 8)(def-mactype :qtypes (find-mactype ':signed-byte))(defconstant $OSTrap 0)(defconstant $ToolTrap 1)(def-mactype :traptype (find-mactype ':signed-byte))(defrecord SysParmType    (valid :unsigned-byte)   (aTalkA :unsigned-byte)   (aTalkB :unsigned-byte)   (config :unsigned-byte)   (portA :signed-integer)   (portB :signed-integer)   (alarm :signed-long)   (font :signed-integer)   (kbdPrint :signed-integer)   (volClik :signed-integer)   (misc :signed-integer)   )(def-mactype :syspptr (find-mactype '(:pointer :sysparmtype)))(def-mactype :qelemptr (find-mactype '(:pointer :qelem)))(defrecord QElem    (qLink (:pointer :qelem))   (qType :signed-integer)   (qData (:array :signed-integer 1))   )(def-mactype :qhdrptr (find-mactype '(:pointer :qhdr)))(defrecord QHdr    (qFlags :signed-integer)   (qHead (:pointer :qelem))   (qTail (:pointer :qelem))   ); ; 		DeferredTaskProcPtr uses register based parameters on the 68k and cannot; 		be written in or called from a high-level language without the help of; 		mixed mode or assembly glue.; ; 		In:; 		 => dtParam     	A1.L; 	(def-mactype :deferredtaskprocptr (find-mactype ':pointer));  register PROCEDURE DeferredTask(dtParam: LONGINT); (def-mactype :deferredtaskupp (find-mactype ':pointer))(defrecord DeferredTask    (qLink (:pointer :qelem))   (qType :signed-integer)   (dtFlags :signed-integer)   (dtAddr :pointer)   (dtParam :signed-long)   (dtReserved :signed-long)   )(def-mactype :deferredtaskptr (find-mactype '(:pointer :deferredtask)))(defrecord SysEnvRec    (environsVersion :signed-integer)   (machineType :signed-integer)   (systemVersion :signed-integer)   (processor :signed-integer)   (hasFPU :boolean)   (hasColorQD :boolean)   (keyBoardType :signed-integer)   (atDrvrVersNum :signed-integer)   (sysVRefNum :signed-integer)   )(defrecord MachineLocation    (latitude :signed-long)   (longitude :signed-long)   (:variant       (      (dlsDelta :signed-byte)                   ; signed byte; daylight savings delta      )      (      (gmtDelta :signed-long)                   ; must mask - see documentation      )      )   )(defrecord DateTimeRec    (year :signed-integer)   (month :signed-integer)   (day :signed-integer)   (hour :signed-integer)   (minute :signed-integer)   (second :signed-integer)   (dayOfWeek :signed-integer)   )(%define-record :longdatetime (find-record-descriptor :wide))(defrecord LongDateCvt    (:variant       (      (c :wide)      )      (      (lHigh :unsigned-long)      (lLow :unsigned-long)      )      )   )(defrecord LongDateRec    (:variant       (      (era :signed-integer)      (year :signed-integer)      (month :signed-integer)      (day :signed-integer)      (hour :signed-integer)      (minute :signed-integer)      (second :signed-integer)      (dayOfWeek :signed-integer)      (dayOfYear :signed-integer)      (weekOfYear :signed-integer)      (pm :signed-integer)      (res1 :signed-integer)      (res2 :signed-integer)      (res3 :signed-integer)      )      (      (list (:array :signed-integer 14))        ; Index by LongDateField!      )      (      (eraAlt :signed-integer)      (oldDate :datetimerec)      )      )   )(def-mactype :datedelta (find-mactype ':signed-byte))(defrecord TogglePB    (togFlags :signed-long)                      ; caller normally sets low word to dateStdMask=$7F   (amChars :ostype)                            ; from 'itl0', but uppercased   (pmChars :ostype)                            ; from 'itl0', but uppercased   (reserved (:array :signed-long 4))   )(def-mactype :toggleresults (find-mactype ':signed-integer))(defconstant $uppDeferredTaskProcInfo #xB802)   ;  Register PROCEDURE (4 bytes in A1); ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewDeferredTaskProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM                        ; To be implemented:  Glue to move parameters into registers.; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_CallDeferredTaskProc" ((dtParam :signed-long) (userRoutine :pointer))   nil   () )                                         ; CONST; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_LongDateToSeconds" ((lDate (:pointer :longdaterec)) (lSecs (:pointer :wide)))   nil   (:stack-trap #xA8B5 lDate lSecs ((+ (ash 32776 16) 65522) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_LongSecondsToDate" ((lSecs (:pointer :wide)) (lDate (:pointer :longdaterec)))   nil   (:stack-trap #xA8B5 lSecs lDate ((+ (ash 32776 16) 65520) :signed-longint))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_ToggleDate" ((lSecs (:pointer :wide)) (field :signed-byte) (delta :signed-byte) (ch :signed-integer) (params (:pointer :togglepb)))   (:stack :signed-integer)   (:stack-trap #xA8B5 lSecs field delta ch params ((+ (ash 33294 16) 65518) :signed-longint))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap "_ValidDate" ((vDate (:pointer :longdaterec)) (flags :signed-long) (newSecs (:pointer :wide)))   (:stack :signed-integer)   (:stack-trap #xA8B5 vDate flags newSecs ((+ (ash 33292 16) 65508) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_IsMetric" ()   (:stack :boolean)   (:stack-trap #xA9ED (4 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetSysPPtr" ()   (:pointer :sysparmtype)   (#x2EBC #x0 #x1F8) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-return-d0(deftrap "_ReadDateTime" ((time (:pointer :signed-long)))   (:d0 :signed-integer)   (:register-trap #xA039 :a0 time)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetDateTime" ((secs (:pointer :signed-long)))   nil   (#x205F #x20B8 #x20C) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-return-d0(deftrap "_SetDateTime" ((time :signed-long))   (:d0 :signed-integer)   (:register-trap #xA03A :d0 time)); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_SetTime" ((d (:pointer :datetimerec)))   nil   (#x205F #xA9C7 #xA03A) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetTime" ((d (:pointer :datetimerec)))   nil   (#x205F #x2038 #x20C #xA9C6) ); $ENDC; CONST;; Warning: No calling method defined for this trap(deftrap-inline "_DateToSeconds" ((d (:pointer :datetimerec)) (secs (:pointer :signed-long)))   nil   () )                                         ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_SecondsToDate" ((secs :signed-long) (d (:pointer :datetimerec)))   nil   (#x205F #x201F #xA9C6) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_SysBeep" ((duration :signed-integer))   nil   (:stack-trap #xA9C8)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-return-d0(deftrap "_DTInstall" ((dtTaskPtr (:pointer :deferredtask)))   (:d0 :signed-integer)   (:register-trap #xA082 :a0 dtTaskPtr)); $ENDC; $IFC NOT CFMSYSTEMCALLS;; Inline instructions called as foreign function(deftrap-inline "_GetMMUMode" ()   :signed-byte   (#x1EB8 #xCB2) )                             ;  MOVE.b $0CB2,(SP) ; $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_SwapMMUMode" ((mode (:pointer :signed-byte)))   nil   (#x205F #x1010 #xA05D #x1080) ); $ENDC; $IFC SystemSixOrLater ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_SysEnvirons" ((versionRequested :signed-integer) (theWorld (:pointer :sysenvrec)))   :signed-integer   (#x205F #x301F #xA090 #x3E80) ); $ENDC#|                                              ; $ELSEC |#                                             ; $ENDC;; Generated by translator basic-stack-trap(deftrap "_SysEnvirons" ((versionRequested :signed-integer) (theWorld (:pointer :sysenvrec)))   (:stack :signed-integer)   (:stack-trap #xA090))                        ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_Delay" ((numTicks :signed-long) (finalTicks (:pointer :signed-long)))   nil   (#x225F #x205F #xA03B #x2280) ); $ENDC; ; 	GetTrapAddress and SetTrapAddress are obsolete and should not; 	be used. Always use NGetTrapAddress and NSetTrapAddress instead.; 	The old routines will not be supported for PowerPC apps.; ; $IFC OLDROUTINENAMES  & NOT GENERATINGCFM ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetTrapAddress" ((trapNum :signed-integer))   :pointer   (#x301F #xA146 #x2E88) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-in-d0-1-arg-in-a0(deftrap "_SetTrapAddress" ((trapAddr :pointer) (trapNum :signed-integer))   nil   (:register-trap #xA047 :d0 trapNum :a0 trapAddr)); $ENDC; $ENDC;; Warning: No calling method defined for this trap;; Using mcl2 version of ngettrapaddress because there is no implementation in the new headers(deftrap "_NGetTrapAddress"         ((trapnum :signed-integer))         (:a0 :signed-long)         (:register-trap 41798 :d0 trapnum));; Warning: No calling method defined for this trap;; Using mcl2 version of nsettrapaddress because there is no implementation in the new headers(deftrap "_NSetTrapAddress"         ((trapaddr :signed-long) (trapnum :signed-integer))         nil         (:register-trap 41543 :a0 trapaddr :d0 trapnum)); $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetOSTrapAddress" ((trapNum :signed-integer))   :pointer   (#x301F #xA346 #x2E88) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-in-d0-1-arg-in-a0(deftrap "_SetOSTrapAddress" ((trapAddr :pointer) (trapNum :signed-integer))   nil   (:register-trap #xA247 :d0 trapNum :a0 trapAddr)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetToolTrapAddress" ((trapNum :signed-integer))   :pointer   (#x301F #xA746 #x2E88) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-in-d0-1-arg-in-a0(deftrap "_SetToolTrapAddress" ((trapAddr :pointer) (trapNum :signed-integer))   nil   (:register-trap #xA647 :d0 trapNum :a0 trapAddr)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetToolboxTrapAddress" ((trapNum :signed-integer))   :pointer   (#x301F #xA746 #x2E88) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-in-d0-1-arg-in-a0(deftrap "_SetToolboxTrapAddress" ((trapAddr :pointer) (trapNum :signed-integer))   nil   (:register-trap #xA647 :d0 trapNum :a0 trapAddr)); $ENDC;; Warning: No calling method defined for this trap;; Using mcl2 version of writeparam because there is no implementation in the new headers(deftrap "_WriteParam" nil (:d0 :signed-integer) (:register-trap 41016)); $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_Enqueue" ((qElement (:pointer :qelem)) (qHeader (:pointer :qhdr)))   nil   (#x225F #x205F #xA96F) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_Dequeue" ((qElement (:pointer :qelem)) (qHeader (:pointer :qhdr)))   :signed-integer   (#x225F #x205F #xA96E #x3E80) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_SetCurrentA5" ()   :signed-long   (#x2E8D #x2A78 #x904) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_SetA5" ((newA5 :signed-long))   :signed-long   (#x2F4D #x4 #x2A5F) ); $ENDC#|                                              ; $IFC NOT SystemSevenOrLater  |#                                             ; $ENDC;; Warning: No calling method defined for this trap;; Using mcl2 version of environs because there is no implementation in the new headers(deftrap "_Environs"         ((rom (:pointer :signed-integer))          (machine (:pointer :signed-integer)))         nil         (:no-trap (environs rom machine))); $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_InitUtil" ()   :signed-integer   (#xA03F #x3E80) ); $ENDC; $IFC GENERATING68K ;; Warning: No calling method defined for this trap;; Using mcl2 version of swapinstructioncache because there is no implementation in the new headers(deftrap "_SwapInstructionCache"         ((cacheenable :boolean))         (:a0 :boolean)         (:register-trap 41368 :a0 (%int-to-ptr cacheenable) :d0 0)); $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_FlushInstructionCache" ()   nil   (#x7001 #xA098) ); $ENDC;; Warning: No calling method defined for this trap;; Using mcl2 version of swapdatacache because there is no implementation in the new headers(deftrap "_SwapDataCache"         ((cacheenable :boolean))         (:a0 :boolean)         (:register-trap 41368 :a0 (%int-to-ptr cacheenable) :d0 2)); $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_FlushDataCache" ()   nil   (#x7003 #xA098) ); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FlushCodeCache" ()   nil   (:stack-trap #xA0BD)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_FlushCodeCacheRange" ((address :pointer) (count :signed-long))   nil   (#x225F #x205F #x7009 #xA098) ); $ENDC; $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_ReadLocation" ((loc (:pointer :machinelocation)))   nil   (#x205F #x203C #xC #xE4 #xA051) ); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_WriteLocation" ((loc (:pointer :machinelocation)))   nil   (#x205F #x203C #xC #xE4 #xA052) ); $ENDC; $IFC OLDROUTINENAMES ; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_LongDate2Secs" "LongDateToSeconds")         ((lDate (:pointer :longdaterec)) (lSecs (:pointer :wide)))   nil   (:stack-trap #xA8B5 lDate lSecs ((+ (ash 32776 16) 65522) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_LongSecs2Date" "LongSecondsToDate")         ((lSecs (:pointer :wide)) (lDate (:pointer :longdaterec)))   nil   (:stack-trap #xA8B5 lSecs lDate ((+ (ash 32776 16) 65520) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap ("_IUMetric" "IsMetric") ()   (:stack :boolean)   (:stack-trap #xA9ED (4 :signed-integer))); $ENDC; CONST;; Warning: No calling method defined for this trap;; Using mcl2 version of date2secs because there is no implementation in the new headers(deftrap ("_Date2Secs" "DateToSeconds")         ((d (:pointer :datetimerec)) (secs (:pointer :signed-long)))         nil         (:no-trap (%put-long secs (register-trap 43463 :a0 d :d0)))); $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline ("_Secs2Date" "SecondsToDate")  ((secs :signed-long) (d (:pointer :datetimerec)))   nil   (#x205F #x201F #xA9C6) ); $ENDC; $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := OSUtilsIncludes; $ENDC                                         ; __OSUTILS__#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC(provide-interface 'OSUtils);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch(DEFTRAP "_UPRSTRING"         ((THESTRING (:POINTER (:STRING 255))))         NIL         (:REGISTER-TRAP 41044 :D0 (%GET-UNSIGNED-BYTE THE-STRING) :A0          (%INC-PTR THESTRING)));; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFTRAP "_CMPSTRING"         ((S1 :POINTER) (S2 :POINTER) (LENGTHS :UNSIGNED-LONG))         (:D0 :SIGNED-INTEGER)         (:REGISTER-TRAP 41020 :A0 S1 :A1 S2 :D0 LENGTHS));; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEF-MACTYPE :PARAMBLKTYPE (FIND-MACTYPE :UNSIGNED-WORD));; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $VOLUMEPARAM 2);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $MULTIDEVPARAM 5);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $SLOTDEVPARAM 4);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $COPYPARAM 8);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $FIDPARAM 10);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $CSPARAM 11);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $CNTRLPARAM 3);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $WDPARAM 9);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $FILEPARAM 1);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $OBJPARAM 7);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $FOREIGNPRIVPARAM 12);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $ACCESSPARAM 6);; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:OSUTILS.patch (DEFCONSTANT $IOPARAM 0)
(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:DeskBus.p"; at Tuesday June 6,1995 2:07:31 pm.; ;  	File:		DeskBus.p;  ;  	Contains:	Apple Desktop Bus (ADB) Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __DESKBUS__; $SETC __DESKBUS__ := 1; $I+; $SETC DeskBusIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											#|                                              ; $IFC UNDEFINED __MIXEDMODE__|#(require-interface 'MixedMode)#|                                              ; $I MixedMode.p |#                                             ; $ENDC; $PUSH; $ALIGN MAC68K; $LibExport+(def-mactype :adbaddress (find-mactype ':character)); ; 		ADBCompletionProcPtr uses register based parameters on the 68k and cannot; 		be written in or called from a high-level language without the help of; 		mixed mode or assembly glue.; ; 		In:; 		 => dataBuffPtr 	A0.L; 		 => opDataAreaPtr	A2.L; 		 => command     	D0.L; 	(def-mactype :adbcompletionprocptr (find-mactype ':pointer));  register PROCEDURE ADBCompletion(dataBuffPtr: Ptr; opDataAreaPtr: Ptr; command: LONGINT); (def-mactype :adbcompletionupp (find-mactype ':pointer))(defconstant $uppADBCompletionProcInfo #x7B9802);  Register PROCEDURE (4 bytes in A0, 4 bytes in A2, 4 bytes in D0); ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewADBCompletionProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM                        ; To be implemented:  Glue to move parameters into registers.; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_CallADBCompletionProc" ((dataBuffPtr :pointer) (opDataAreaPtr :pointer) (command :signed-long) (userRoutine :pointer))   nil   () ); ; 		ADBDeviceDriverProcPtr uses register based parameters on the 68k and cannot; 		be written in or called from a high-level language without the help of; 		mixed mode or assembly glue.; ; 		In:; 		 => devAddress  	D0.B; 		 => devType     	D1.B; 	(def-mactype :adbdevicedriverprocptr (find-mactype ':pointer));  register PROCEDURE ADBDeviceDriver(devAddress: ByteParameter; devType: ByteParameter); (def-mactype :adbdevicedriverupp (find-mactype ':pointer))(defconstant $uppADBDeviceDriverProcInfo #x50802);  Register PROCEDURE (1 byte in D0, 1 byte in D1); ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewADBDeviceDriverProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM                        ; To be implemented:  Glue to move parameters into registers.; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_CallADBDeviceDriverProc" ((devAddress :signed-byte) (devType :signed-byte) (userRoutine :pointer))   nil   () ); ; 		ADBServiceRoutineProcPtr uses register based parameters on the 68k and cannot; 		be written in or called from a high-level language without the help of; 		mixed mode or assembly glue.; ; 		In:; 		 => dataBuffPtr 	A0.L; 		 => completionProc	A1.L; 		 => dataPtr     	A2.L; 		 => command     	D0.L; 	(def-mactype :adbserviceroutineprocptr (find-mactype ':pointer));  register PROCEDURE ADBServiceRoutine(dataBuffPtr: Ptr; completionProc: ADBCompletionUPP; dataPtr: Ptr; command: LONGINT); (def-mactype :adbserviceroutineupp (find-mactype ':pointer))(defconstant $uppADBServiceRoutineProcInfo #xF779802);  Register PROCEDURE (4 bytes in A0, 4 bytes in A1, 4 bytes in A2, 4 bytes in D0); ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewADBServiceRoutineProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM                        ; To be implemented:  Glue to move parameters into registers.; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_CallADBServiceRoutineProc" ((dataBuffPtr :pointer) (completionProc :pointer) (dataPtr :pointer) (command :signed-long) (userRoutine :pointer))   nil   () ); ; 		ADBInitProcPtr uses register based parameters on the 68k and cannot; 		be written in or called from a high-level language without the help of; 		mixed mode or assembly glue.; ; 		In:; 		 => callOrder   	D0.B; 	(def-mactype :adbinitprocptr (find-mactype ':pointer));  register PROCEDURE ADBInit(callOrder: ByteParameter); (def-mactype :adbinitupp (find-mactype ':pointer))(defconstant $uppADBInitProcInfo #x802)         ;  Register PROCEDURE (1 byte in D0); ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewADBInitProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM                        ; To be implemented:  Glue to move parameters into registers.; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_CallADBInitProc" ((callOrder :signed-byte) (userRoutine :pointer))   nil   () )(defrecord ADBOpBlock    (dataBuffPtr :pointer)                       ;  address of data buffer    (opServiceRtPtr :pointer)                    ;  service routine pointer    (opDataAreaPtr :pointer)                     ;  optional data area address    )(def-mactype :adbopbptr (find-mactype '(:pointer :adbopblock)))(defrecord ADBDataBlock    (devType :character)                         ;  device type    (origADBAddr :character)                     ;  original ADB Address    (dbServiceRtPtr :pointer)                    ;  service routine pointer    (dbDataAreaAddr :pointer)                    ;  data area address    )(def-mactype :adbdblkptr (find-mactype '(:pointer :adbdatablock)))(defrecord ADBSetInfoBlock    (siService :pointer)                         ;  service routine pointer    (siDataAreaAddr :pointer)                    ;  data area address    )(def-mactype :adbsinfoptr (find-mactype '(:pointer :adbsetinfoblock))); $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_ADBReInit" ()   nil   (:stack-trap #xA07B)); $ENDC;; Warning: No calling method defined for this trap;; Using mcl2 version of adbop because there is no implementation in the new headers(deftrap "_ADBOp"         ((data :pointer) (comprout :pointer) (buffer :pointer)          (commandnum :signed-integer))         (:no-trap :signed-integer)         (:no-trap          (rlet ((block :adbopblock))                (setf (rref block :adbopblock.databuffptr) buffer                      (rref block :adbopblock.opservicertptr) comprout                      (rref block :adbopblock.opdataareaptr) data)                (register-trap                  41084                  :a0                  block                  :d0                  commandnum                  (:signed-integer :d0))))); $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CountADBs" ()   :signed-integer   (#xA077 #x3E80) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetIndADB" ((info (:pointer :adbdatablock)) (devTableIndex :signed-integer))   :character   (#x301F #x205F #xA078 #x1E80) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetADBInfo" ((info (:pointer :adbdatablock)) (adbAddr :signed-byte))   :signed-integer   (#x101F #x205F #xA079 #x3E80) ); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_SetADBInfo" ((info (:pointer :adbsetinfoblock)) (adbAddr :signed-byte))   :signed-integer   (#x101F #x205F #xA07A #x3E80) ); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := DeskBusIncludes; $ENDC                                         ; __DESKBUS__; $IFC NOT UsingIncludes; $ENDC(provide-interface 'DeskBus)
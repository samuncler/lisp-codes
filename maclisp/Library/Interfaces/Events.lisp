(in-package :TRAPS);;;;;;;;;;;;;;;;;;;;;;;;;;; Modification History;;;; 03/06/96 bill Map old names to new names;;; Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:Events.p"; at Tuesday June 6,1995 2:00:42 pm.; ;  	File:		Events.p;  ;  	Contains:	Event Manager Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC; $IFC UNDEFINED __EVENTS__; $SETC __EVENTS__ := 1; $I+; $SETC EventsIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											; $IFC UNDEFINED __QUICKDRAW__(require-interface 'Quickdraw)                  ; $I Quickdraw.p; $ENDC; 	MixedMode.p													; 	QuickdrawText.p												#|                                              ; $IFC UNDEFINED __OSUTILS__|#(require-interface 'OSUtils)#|                                              ; $I OSUtils.p |#                                             ; $ENDC; 	Memory.p													; $PUSH; $ALIGN MAC68K; $LibExport+(def-mactype :macoseventkind (find-mactype ':unsigned-integer))(defconstant $nullEvent 0)(defconstant $mouseDown 1)(defconstant $mouseUp 2)(defconstant $keyDown 3)(defconstant $keyUp 4)(defconstant $autoKey 5)(defconstant $updateEvt 6)(defconstant $diskEvt 7)(defconstant $activateEvt 8)(defconstant $osEvt 15)(def-mactype :macoseventmask (find-mactype ':unsigned-integer))(defconstant $mDownMask #x2)                    ;  mouse button pressed (defconstant $mUpMask #x4)                      ;  mouse button released (defconstant $keyDownMask #x8)                  ;  key pressed (defconstant $keyUpMask #x10)                   ;  key released (defconstant $autoKeyMask #x20)                 ;  key repeatedly held down (defconstant $updateMask #x40)                  ;  window needs updating (defconstant $diskMask #x80)                    ;  disk inserted (defconstant $activMask #x100)                  ;  activate/deactivate window (defconstant $highLevelEventMask #x400)         ;  high-level events (includes AppleEvents) (defconstant $osMask #x8000)                    ;  operating system events (suspend, resume) (defconstant $everyEvent #xFFFF)                ;  all of the above ;  event message equates (defconstant $charCodeMask #xFF)(defconstant $keyCodeMask #xFF00)(defconstant $adbAddrMask #xFF0000)(defconstant $osEvtMessageMask #xFF000000);  OS event messages.  Event (sub)code is in the high byte of the message field. (defconstant $mouseMovedMessage #xFA)(defconstant $suspendResumeMessage #x1)(defconstant $resumeFlag 1)                     ;  Bit 0 of message indicates resume vs suspend (defconstant $convertClipboardFlag 2)           ;  Bit 1 in resume message indicates clipboard change (def-mactype :macoseventmodifiers (find-mactype ':unsigned-integer));  modifiers (defconstant $activeFlag #x1)                   ;  Bit 0 of modifiers for activateEvt and mouseDown events (defconstant $btnState #x80)                    ;  Bit 7 of low byte is mouse button state (defconstant $cmdKey #x100)                     ;  Bit 0 of high byte (defconstant $shiftKey #x200)                   ;  Bit 1 of high byte (defconstant $alphaLock #x400)                  ;  Bit 2 of high byte (defconstant $optionKey #x800)                  ;  Bit 3 of high byte (defconstant $controlKey #x1000)                ;  Bit 4 of high byte (defconstant $rightShiftKey #x2000)             ;  Bit 5 of high byte (defconstant $rightOptionKey #x4000)            ;  Bit 6 of high byte (defconstant $rightControlKey #x8000)           ;  Bit 7 of high byte (defrecord EventRecord    (what :unsigned-integer)   (message :unsigned-long)   (when :unsigned-long)   (where :point)   (modifiers :unsigned-integer)   )(defrecord KeyMap (array (array :boolean 128 :packed)))(defrecord EvQEl    (qLink (:pointer :qelem))   (qType :signed-integer)   (evtQWhat :unsigned-integer)                 ;  this part is identical to the EventRecord as...    (evtQMessage :unsigned-long)                 ;  defined above    (evtQWhen :unsigned-long)   (evtQWhere :point)   (evtQModifiers :unsigned-integer)   )(def-mactype :evqelptr (find-mactype '(:pointer :evqel)))(def-mactype :getnexteventfilterprocptr (find-mactype ':pointer));  PROCEDURE GetNextEventFilter(VAR theEvent: EventRecord; VAR result: BOOLEAN); (def-mactype :getnexteventfilterupp (find-mactype ':pointer))(defconstant $uppGetNextEventFilterProcInfo #xBF);  SPECIAL_CASE_PROCINFO( kSpecialCaseGNEFilterProc ) ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewGetNextEventFilterProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM                        ; To be implemented:  Glue to move parameters according to special case conventions.; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_CallGetNextEventFilterProc" ((theEvent (:pointer :eventrecord)) (result (:pointer :boolean)) (userRoutine :pointer))   nil   () )(def-mactype :gnefilterupp (find-mactype ':pointer))(def-mactype :fkeyprocptr (find-mactype ':pointer));  PROCEDURE FKEY; (def-mactype :fkeyupp (find-mactype ':pointer))(defconstant $uppFKEYProcInfo #x0)              ;  PROCEDURE ; ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewFKEYProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator register-trap-1-arg-no-return(deftrap "_CallFKEYProc" ((userRoutine :pointer))   nil   (:register-trap #x4E90 :a0 userRoutine)); $ENDC; $IFC NOT CFMSYSTEMCALLS;; Generated by translator read-long-from-memory(deftrap "_GetCaretTime" ()   (:no-trap :unsigned-long)   (:no-trap (%get-unsigned-long (%int-to-ptr 756))));  MOVE.l $02F4,(SP) ; $ENDC; $IFC NOT CFMSYSTEMCALLS;; Inline instructions called as foreign function(deftrap-inline "_SetEventMask" ((value :unsigned-integer))   nil   (#x31DF #x144) )                             ;  MOVE.w (SP)+,$0144 ; $ENDC; $IFC NOT CFMSYSTEMCALLS;; Generated by translator read-word-from-memory(deftrap "_GetEventMask" ()   (:no-trap :unsigned-integer)   (:no-trap (%get-unsigned-word (%int-to-ptr 324))));  MOVE.w $0144,(SP) ; $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetEvQHdr" ()   (:pointer :qhdr)   (#x2EBC #x0 #x14A) ); $ENDC;  InterfaceLib exports GetEvQHdr, so make GetEventQueue map to that ; $IFC NOT CFMSYSTEMCALLS;; Generated by translator read-long-from-memory(deftrap "_GetDblTime" ()   (:no-trap :unsigned-long)   (:no-trap (%get-unsigned-long (%int-to-ptr 752))));  MOVE.l $02F0,(SP) ; $ENDC;  InterfaceLib exports GetDblTime, so make GetDoubleClickTime map to that ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_GetNextEvent" ((eventMask :unsigned-integer) (theEvent (:pointer :eventrecord)))   (:stack :boolean)   (:stack-trap #xA970)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_WaitNextEvent" ((eventMask :unsigned-integer) (theEvent (:pointer :eventrecord)) (sleep :unsigned-long) (mouseRgn (:handle :region)))   (:stack :boolean)   (:stack-trap #xA860)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_EventAvail" ((eventMask :unsigned-integer) (theEvent (:pointer :eventrecord)))   (:stack :boolean)   (:stack-trap #xA971)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_GetMouse" ((mouseLoc (:pointer :point)))   nil   (:stack-trap #xA972)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_Button" ()   (:stack :boolean)   (:stack-trap #xA974)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_StillDown" ()   (:stack :boolean)   (:stack-trap #xA973)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_WaitMouseUp" ()   (:stack :boolean)   (:stack-trap #xA977)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_GetKeys" ((theKeys :keymap))   nil   (:stack-trap #xA976)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_KeyTranslate" ((transData :pointer) (keycode :unsigned-integer) (state (:pointer :unsigned-long)))   (:stack :unsigned-long)   (:stack-trap #xA9C3)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_TickCount" ()   (:stack :unsigned-long)   (:stack-trap #xA975)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_PostEvent" ((eventNum :unsigned-integer) (eventMsg :unsigned-long))   :signed-integer   (#x201F #x305F #xA02F #x3E80) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_PPostEvent" ((eventCode :unsigned-integer) (eventMsg :unsigned-long) (qEl (:pointer (:pointer :evqel))))   :signed-integer   (#x225F #x201F #x305F #xA12F #x2288 #x3E80) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_OSEventAvail" ((mask :unsigned-integer) (theEvent (:pointer :eventrecord)))   :boolean   (#x205F #x301F #xA030 #x5240 #x1E80) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_GetOSEvent" ((mask :unsigned-integer) (theEvent (:pointer :eventrecord)))   :boolean   (#x205F #x301F #xA031 #x5240 #x1E80) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_FlushEvents" ((whichMask :unsigned-integer) (stopMask :unsigned-integer))   nil   (#x201F #xA032) ); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_SystemClick" ((theEvent (:pointer :eventrecord)) (theWindow (:pointer :grafport)))   nil   (:stack-trap #xA9B3)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_SystemTask" ()   nil   (:stack-trap #xA9B4)); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_SystemEvent" ((theEvent (:pointer :eventrecord)))   (:stack :boolean)   (:stack-trap #xA9B2)); $ENDC; $IFC OLDROUTINENAMES (defconstant $networkEvt 10)(defconstant $driverEvt 11)(defconstant $app1Evt 12)(defconstant $app2Evt 13)(defconstant $app3Evt 14)(defconstant $app4Evt 15)(defconstant $networkMask #x400)(defconstant $driverMask #x800)(defconstant $app1Mask #x1000)(defconstant $app2Mask #x2000)(defconstant $app3Mask #x4000)(defconstant $app4Mask #x8000); $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap ("_KeyTrans" "KeyTranslate")         ((transData :pointer) (keycode :unsigned-integer) (state (:pointer :unsigned-long)))   (:stack :unsigned-long)   (:stack-trap #xA9C3)); $ENDC; $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := EventsIncludes; $ENDC                                         ; __EVENTS__#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC(provide-interface 'Events)
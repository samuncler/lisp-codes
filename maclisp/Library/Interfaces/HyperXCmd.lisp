(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:HyperXCmd.p"; at Tuesday June 6,1995 2:11:28 pm.; ; 	File:		HyperXCmd.p; ; 	Copyright:	� 1983-1993 by Apple Computer, Inc.; 				All rights reserved.; ; 	Version:	System 7.1 for ETO #11; 	Created:	Tuesday, March 30, 1993 18:00; ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED UsingHyperXCmd; $SETC UsingHyperXCmd := 1; $I+; $SETC HyperXCmdIncludes := UsingIncludes; $SETC UsingIncludes := 1; $IFC UNDEFINED UsingTypes(require-interface 'Types)                      ; $I $$Shell(PInterfaces)Types.p; $ENDC; $IFC UNDEFINED UsingEvents(require-interface 'Events)                     ; $I $$Shell(PInterfaces)Events.p; $ENDC; $IFC UNDEFINED UsingTextEdit(require-interface 'TextEdit)                   ; $I $$Shell(PInterfaces)TextEdit.p; $ENDC; $IFC UNDEFINED UsingMenus(require-interface 'Menus)                      ; $I $$Shell(PInterfaces)Menus.p; $ENDC; $IFC UNDEFINED UsingStandardFile(require-interface 'StandardFile)               ; $I $$Shell(PInterfaces)StandardFile.p; $ENDC; $SETC UsingIncludes := HyperXCmdIncludes;  result codes (defconstant $xresSucc 0)(defconstant $xresFail 1)(defconstant $xresNotImp 2);  XCMDBlock constants for event.what... (defconstant $xOpenEvt 1000)                    ;  the first event after you are created (defconstant $xCloseEvt 1001)                   ;  your window is being forced close (Quit?) (defconstant $xGiveUpEditEvt 1002)              ;  you are losing Edit... (defconstant $xGiveUpSoundEvt 1003)             ;  someone else is requesting HyperCard's sound channel (defconstant $xHidePalettesEvt 1004)            ;  someone called HideHCPalettes (defconstant $xShowPalettesEvt 1005)            ;  someone called ShowHCPalettes (defconstant $xEditUndo 1100)                   ;  Edit��Undo (defconstant $xEditCut 1102)                    ;  Edit��Cut (defconstant $xEditCopy 1103)                   ;  Edit��Copy (defconstant $xEditPaste 1104)                  ;  Edit��Paste (defconstant $xEditClear 1105)                  ;  Edit��Clear (defconstant $xSendEvt 1200)                    ;  script has sent you a message (text) (defconstant $xSetPropEvt 1201)                 ;  set a window property (defconstant $xGetPropEvt 1202)                 ;  get a window property (defconstant $xCursorWithin 1300)               ;  cursor is within the window (defconstant $xMenuEvt 1400)                    ;  user has selected an item in your menu (defconstant $xMBarClickedEvt 1401)             ;  a menu is about to be shown--update if needed (defconstant $xShowWatchInfoEvt 1501)           ;  for variable and message watchers (defconstant $xScriptErrorEvt 1502)             ;  place the insertion point (defconstant $xDebugErrorEvt 1503)              ;  user clicked "Debug" at a complaint (defconstant $xDebugStepEvt 1504)               ;  hilite the line (defconstant $xDebugTraceEvt 1505)              ;  same as step but tracing (defconstant $xDebugFinishedEvt 1506)           ;  script ended (defconstant $paletteProc 2048)                 ;  Windoid with grow box (defconstant $palNoGrowProc 2052)               ;  standard Windoid defproc (defconstant $palZoomProc 2056)                 ;  Windoid with zoom and grow (defconstant $palZoomNoGrow 2060)               ;  Windoid with zoom and no grow (defconstant $hasZoom 8)(defconstant $hasTallTBar 2)(defconstant $toggleHilite 1)(defconstant $maxCachedChecks 16)               ;  maximum number of checkpoints in a script ;  paramCount is set to these constants when first calling special XThings (defconstant $xMessageWatcherID -2)(defconstant $xVariableWatcherID -3)(defconstant $xScriptEditorID -4)(defconstant $xDebuggerID -5);  XTalkObjectPtr^.objectKind values (defconstant $stackObj 1)(defconstant $bkgndObj 2)(defconstant $cardObj 3)(defconstant $fieldObj 4)(defconstant $buttonObj 5);  selectors for ShowHCAlert's dialogs (shown as buttonID:buttonText) (defconstant $errorDlgID 1)                     ;  1:OK (default) (defconstant $confirmDlgID 2)                   ;  1:OK (default) and 2:Cancel (defconstant $confirmDelDlgID 3)                ;  1:Cancel (default) and 2:Delete (defconstant $yesNoCancelDlgID 4)               ;  1:Yes (default), 2:Cancel, and 3:No (def-mactype :xcmdptr (find-mactype '(:pointer :xcmdblock)))(defrecord XCmdBlock    (paramCount :signed-integer)                 ;  If = -1 then new use for XWindoids    (params (:array :handle 16))   (returnValue :handle)   (passFlag :boolean)   (entryPoint :pointer)                        ;  to call back to HyperCard    (request :signed-integer)   (result :signed-integer)   (inArgs (:array :signed-long 8))   (outArgs (:array :signed-long 4))   )(def-mactype :xweventinfoptr (find-mactype '(:pointer :xweventinfo)))(defrecord XWEventInfo    (event :eventrecord)   (eventWindow (:pointer :grafport))   (eventParams (:array :signed-long 9))   (eventResult :handle)   )(def-mactype :xtalkobjectptr (find-mactype '(:pointer :xtalkobject)))(defrecord XTalkObject    (objectKind :signed-integer)                 ;  stack, bkgnd, card, field, or button    (stackNum :signed-long)                      ;  reference number of the source stack    (bkgndID :signed-long)   (cardID :signed-long)   (buttonID :signed-long)   (fieldID :signed-long)   )(def-mactype :checkpthandle (find-mactype '(:pointer :checkptptr)))(def-mactype :checkptptr (find-mactype '(:pointer :checkpts)))(defrecord CheckPts    (checks (:array :signed-integer (- #$maxCachedChecks 1 -1)))   );   HyperTalk Utilities  ;; Warning: No calling method defined for this trap(deftrap-inline "_EvalExpr" ((paramPtr (:pointer :xcmdblock)) (expr (:string 255)))   :handle   () );; Warning: No calling method defined for this trap(deftrap-inline "_SendCardMessage" ((paramPtr (:pointer :xcmdblock)) (msg (:string 255)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SendHCMessage" ((paramPtr (:pointer :xcmdblock)) (msg (:string 255)))   nil   () )                                         ;   Memory Utilities  ;; Warning: No calling method defined for this trap(deftrap-inline "_RunHandler" ((paramPtr (:pointer :xcmdblock)) (handler :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetGlobal" ((paramPtr (:pointer :xcmdblock)) (globName (:string 255)))   :handle   () );; Warning: No calling method defined for this trap(deftrap-inline "_SetGlobal" ((paramPtr (:pointer :xcmdblock)) (globName (:string 255)) (globValue :handle))   nil   () )                                         ;   String Utilities  ;; Warning: No calling method defined for this trap(deftrap-inline "_ZeroBytes" ((paramPtr (:pointer :xcmdblock)) (dstPtr :pointer) (longCount :signed-long))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_ScanToReturn" ((paramPtr (:pointer :xcmdblock)) (scanPtr (:pointer :pointer)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_ScanToZero" ((paramPtr (:pointer :xcmdblock)) (scanPtr (:pointer :pointer)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_StringEqual" ((paramPtr (:pointer :xcmdblock)) (str1 (:string 255)) (str2 (:string 255)))   :boolean   () );; Warning: No calling method defined for this trap(deftrap-inline "_StringLength" ((paramPtr (:pointer :xcmdblock)) (strPtr :pointer))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_StringMatch" ((paramPtr (:pointer :xcmdblock)) (pattern (:string 255)) (target :pointer))   :pointer   () )                                         ;   String Conversions  ;; Warning: No calling method defined for this trap(deftrap-inline "_ZeroTermHandle" ((paramPtr (:pointer :xcmdblock)) (hndl :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_BoolToStr" ((paramPtr (:pointer :xcmdblock)) (bool :boolean) (str (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_ExtToStr" ((paramPtr (:pointer :xcmdblock)) (num :pointer) (str (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_LongToStr" ((paramPtr (:pointer :xcmdblock)) (posNum :signed-long) (str (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_NumToHex" ((paramPtr (:pointer :xcmdblock)) (num :signed-long) (nDigits :signed-integer) (str (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_NumToStr" ((paramPtr (:pointer :xcmdblock)) (num :signed-long) (str (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_PasToZero" ((paramPtr (:pointer :xcmdblock)) (str (:string 255)))   :handle   () );; Warning: No calling method defined for this trap(deftrap-inline "_PointToStr" ((paramPtr (:pointer :xcmdblock)) (pt :point) (str (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_RectToStr" ((paramPtr (:pointer :xcmdblock)) (rct :rect) (str (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_ReturnToPas" ((paramPtr (:pointer :xcmdblock)) (zeroStr :pointer) (pasStr (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_StrToBool" ((paramPtr (:pointer :xcmdblock)) (str (:string 255)))   :boolean   () );; Warning: No calling method defined for this trap(deftrap-inline "_StrToExt" ((paramPtr (:pointer :xcmdblock)) (str (:string 255)))   :pointer   () );; Warning: No calling method defined for this trap(deftrap-inline "_StrToLong" ((paramPtr (:pointer :xcmdblock)) (str (:string 255)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_StrToNum" ((paramPtr (:pointer :xcmdblock)) (str (:string 255)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_StrToPoint" ((paramPtr (:pointer :xcmdblock)) (str (:string 255)) (pt (:pointer :point)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_StrToRect" ((paramPtr (:pointer :xcmdblock)) (str (:string 255)) (rct (:pointer :rect)))   nil   () )                                         ;   Field Utilities  ;; Warning: No calling method defined for this trap(deftrap-inline "_ZeroToPas" ((paramPtr (:pointer :xcmdblock)) (zeroStr :pointer) (pasStr (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetFieldByID" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldID :signed-integer))   :handle   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetFieldByName" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldName (:string 255)))   :handle   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetFieldByNum" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldNum :signed-integer))   :handle   () );; Warning: No calling method defined for this trap(deftrap-inline "_SetFieldByID" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldID :signed-integer) (fieldVal :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SetFieldByName" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldName (:string 255)) (fieldVal :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SetFieldByNum" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldNum :signed-integer) (fieldVal :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetFieldTE" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldID :signed-integer) (fieldNum :signed-integer) (fieldNamePtr (:pointer (:string 255))))   (:handle :terec)   () )                                         ;   Miscellaneous Utilities  ;; Warning: No calling method defined for this trap(deftrap-inline "_SetFieldTE" ((paramPtr (:pointer :xcmdblock)) (cardFieldFlag :boolean) (fieldID :signed-integer) (fieldNum :signed-integer) (fieldNamePtr (:pointer (:string 255))) (fieldTE (:handle :terec)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_BeginXSound" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_EndXSound" ((paramPtr (:pointer :xcmdblock)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetFilePath" ((paramPtr (:pointer :xcmdblock)) (fileName (:string 255)) (numTypes :signed-integer) (typeList :sftypelist) (askUser :boolean) (fileType (:pointer :ostype)) (fullName (:pointer (:string 255))))   :boolean   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetXResInfo" ((paramPtr (:pointer :xcmdblock)) (resFile (:pointer :signed-integer)) (resID (:pointer :signed-integer)) (rType (:pointer :ostype)) (name (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_Notify" ((paramPtr (:pointer :xcmdblock)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SendHCEvent" ((paramPtr (:pointer :xcmdblock)) (event :eventrecord))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SendWindowMessage" ((paramPtr (:pointer :xcmdblock)) (windPtr (:pointer :grafport)) (windowName (:string 255)) (msg (:string 255)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_FrontDocWindow" ((paramPtr (:pointer :xcmdblock)))   (:pointer :grafport)   () );; Warning: No calling method defined for this trap(deftrap-inline "_StackNameToNum" ((paramPtr (:pointer :xcmdblock)) (stackName (:string 255)))   :signed-long   () )                                         ;   Creating and Disposing XWindoids  ;; Warning: No calling method defined for this trap(deftrap-inline "_ShowHCAlert" ((paramPtr (:pointer :xcmdblock)) (dlgID :signed-integer) (promptStr (:string 255)))   :signed-integer   () );; Warning: No calling method defined for this trap(deftrap-inline "_NewXWindow" ((paramPtr (:pointer :xcmdblock)) (boundsRect :rect) (title (:string 255)) (visible :boolean) (procID :signed-integer) (color :boolean) (floating :boolean))   (:pointer :grafport)   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetNewXWindow" ((paramPtr (:pointer :xcmdblock)) (templateType :ostype) (templateID :signed-integer) (color :boolean) (floating :boolean))   (:pointer :grafport)   () )                                         ;   XWindoid Utilities  ;; Warning: No calling method defined for this trap(deftrap-inline "_CloseXWindow" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_HideHCPalettes" ((paramPtr (:pointer :xcmdblock)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_ShowHCPalettes" ((paramPtr (:pointer :xcmdblock)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_RegisterXWMenu" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)) (menu (:handle :menuinfo)) (registering :boolean))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SetXWIdleTime" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)) (interval :signed-long))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_XWHasInterruptCode" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)) (haveCode :boolean))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_XWAlwaysMoveHigh" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)) (moveHigh :boolean))   nil   () )                                         ;   Text Editing Utilities  ;; Warning: No calling method defined for this trap(deftrap-inline "_XWAllowReEntrancy" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)) (allowSysEvts :boolean) (allowHCEvts :boolean))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_BeginXWEdit" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_EndXWEdit" ((paramPtr (:pointer :xcmdblock)) (window (:pointer :grafport)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_HCWordBreakProc" ((paramPtr (:pointer :xcmdblock)))   :pointer   () )                                         ;   Script Editor support  ;; Warning: No calling method defined for this trap(deftrap-inline "_PrintTEHandle" ((paramPtr (:pointer :xcmdblock)) (hTE (:handle :terec)) (header (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetCheckPoints" ((paramPtr (:pointer :xcmdblock)))   (:pointer :checkptptr)   () );; Warning: No calling method defined for this trap(deftrap-inline "_SetCheckPoints" ((paramPtr (:pointer :xcmdblock)) (checkLines (:pointer :checkptptr)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_FormatScript" ((paramPtr (:pointer :xcmdblock)) (scriptHndl :handle) (insertionPoint (:pointer :signed-long)) (quickFormat :boolean))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SaveXWScript" ((paramPtr (:pointer :xcmdblock)) (scriptHndl :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetObjectName" ((paramPtr (:pointer :xcmdblock)) (object (:pointer :xtalkobject)) (objName (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetObjectScript" ((paramPtr (:pointer :xcmdblock)) (object (:pointer :xtalkobject)) (scriptHndl (:pointer :handle)))   nil   () )                                         ;   Debugging Tools support  ;; Warning: No calling method defined for this trap(deftrap-inline "_SetObjectScript" ((paramPtr (:pointer :xcmdblock)) (object (:pointer :xtalkobject)) (scriptHndl :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_AbortScript" ((paramPtr (:pointer :xcmdblock)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GoScript" ((paramPtr (:pointer :xcmdblock)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_StepScript" ((paramPtr (:pointer :xcmdblock)) (stepInto :boolean))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_CountHandlers" ((paramPtr (:pointer :xcmdblock)) (handlerCount (:pointer :signed-integer)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetHandlerInfo" ((paramPtr (:pointer :xcmdblock)) (handlerNum :signed-integer) (handlerName (:pointer (:string 255))) (objectName (:pointer (:string 255))) (varCount (:pointer :signed-integer)))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetVarInfo" ((paramPtr (:pointer :xcmdblock)) (handlerNum :signed-integer) (varNum :signed-integer) (varName (:pointer (:string 255))) (isGlobal (:pointer :boolean)) (varValue (:pointer (:string 255))) (varHndl :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_SetVarValue" ((paramPtr (:pointer :xcmdblock)) (handlerNum :signed-integer) (varNum :signed-integer) (varHndl :handle))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_GetStackCrawl" ((paramPtr (:pointer :xcmdblock)))   :handle   () )                                         ; $ENDC;  UsingHyperXCmd ; $IFC NOT UsingIncludes;; Warning: No calling method defined for this trap(deftrap-inline "_TraceScript" ((paramPtr (:pointer :xcmdblock)) (traceInto :boolean))   nil   () ); $ENDC(provide-interface 'HyperXCmd)
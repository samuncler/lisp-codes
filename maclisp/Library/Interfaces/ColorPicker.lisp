(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:ColorPicker.p"; at Tuesday June 6,1995 2:06:41 pm.; ;  	File:		ColorPicker.p;  ;  	Contains:	Color Picker package Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Mod History;;;;;; 04/04/97 bill  unsigned-integer for the fields of HSVColor, CMYColor, PMColor;;;#|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __COLORPICKER__; $SETC __COLORPICKER__ := 1; $I+; $SETC ColorPickerIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __QUICKDRAW__|#(require-interface 'Quickdraw)#|                                              ; $I Quickdraw.p |#                                             ; $ENDC; 	Types.p														; 		ConditionalMacros.p										; 	MixedMode.p													; 	QuickdrawText.p												#|                                              ; $IFC UNDEFINED __MIXEDMODE__|#(require-interface 'MixedMode)#|                                              ; $I MixedMode.p |#                                             ; $ENDC#|                                              ; $IFC UNDEFINED __WINDOWS__|#(require-interface 'Windows)#|                                              ; $I Windows.p |#                                             ; $ENDC; 	Memory.p													; 	Events.p													; 		OSUtils.p												; 	Controls.p													; 		Menus.p													#|                                              ; $IFC UNDEFINED __DIALOGS__|#(require-interface 'Dialogs)#|                                              ; $I Dialogs.p |#                                             ; $ENDC; 	Errors.p													; 	TextEdit.p													#|                                              ; $IFC UNDEFINED __CMAPPLICATION__|#(require-interface 'CMApplication)#|                                              ; $I CMApplication.p |#                                             ; $ENDC; 	Printing.p													#|                                              ; $IFC UNDEFINED __BALLOONS__|#(require-interface 'Balloons)#|                                              ; $I Balloons.p |#                                             ; $ENDC; $PUSH; $ALIGN MAC68K; $LibExport+; Maximum small fract value, as long(defconstant $MaxSmallFract #xFFFF)(defconstant $kDefaultWidth 383)(defconstant $kDefaultHeight 238)(defconstant $kDidNothing 0)(defconstant $kColorChanged 1)(defconstant $kOkHit 2)(defconstant $kCancelHit 3)(defconstant $kNewPickerChosen 4)(defconstant $kApplItemHit 5)(def-mactype :pickeraction (find-mactype ':signed-integer))(defconstant $kOriginalColor 0)(defconstant $kNewColor 1)(def-mactype :colortype (find-mactype ':signed-integer))(defconstant $kCut 0)(defconstant $kCopy 1)(defconstant $kPaste 2)(defconstant $kClear 3)(defconstant $kUndo 4)(def-mactype :editoperation (find-mactype ':signed-integer))(defconstant $kMouseDown 0)(defconstant $kKeyDown 1)(defconstant $kFieldEntered 2)(defconstant $kFieldLeft 3)(defconstant $kCutOp 4)(defconstant $kCopyOp 5)(defconstant $kPasteOp 6)(defconstant $kClearOp 7)(defconstant $kUndoOp 8)(def-mactype :itemmodifier (find-mactype ':signed-integer))(defconstant $kAtSpecifiedOrigin 0)(defconstant $kDeepestColorScreen 1)(defconstant $kCenterOnMainScreen 2)(def-mactype :dialogplacementspec (find-mactype ':signed-integer))(defconstant $DialogIsMoveable 1)(defconstant $DialogIsModal 2)(defconstant $CanModifyPalette 4)(defconstant $CanAnimatePalette 8)(defconstant $AppIsColorSyncAware 16)(defconstant $InSystemDialog 32)(defconstant $InApplicationDialog 64)(defconstant $InPickerDialog 128)(defconstant $DetachedFromChoices 256)(defconstant $CanDoColor 1)(defconstant $CanDoBlackWhite 2)(defconstant $AlwaysModifiesPalette 4)(defconstant $MayModifyPalette 8)(defconstant $PickerIsColorSyncAware 16)(defconstant $CanDoSystemDialog 32)(defconstant $CanDoApplDialog 64)(defconstant $HasOwnDialog 128)(defconstant $CanDetach 256)(defconstant $kNoForcast 0)(defconstant $kMenuChoice 1)(defconstant $kDialogAccept 2)(defconstant $kDialogCancel 3)(defconstant $kLeaveFocus 4)(defconstant $kPickerSwitch 5)(defconstant $kNormalKeyDown 6)(defconstant $kNormalMouseDown 7)(def-mactype :eventforcaster (find-mactype ':signed-integer));  A SmallFract value is just the fractional part of a Fixed number,; which is the low order word.  SmallFracts are used to save room,; and to be compatible with Quickdraw's RGBColor.  They can be; assigned directly to and from INTEGERs. ;  Unsigned fraction between 0 and 1 (def-mactype :smallfract (find-mactype ':unsigned-integer));  For developmental simplicity in switching between the HLS and HSV; models, HLS is reordered into HSL. Thus both models start with; hue and saturation values; value/lightness/brightness is last. (defrecord HSVColor    (hue :unsigned-integer)                        ; Fraction of circle, red at 0   (saturation :unsigned-integer)                 ; 0-1, 0 for gray, 1 for pure color   (value :unsigned-integer)                      ; 0-1, 0 for black, 1 for max intensity   )(defrecord HSLColor    (hue :unsigned-integer)                        ; Fraction of circle, red at 0   (saturation :unsigned-integer)                 ; 0-1, 0 for gray, 1 for pure color   (lightness :unsigned-integer)                  ; 0-1, 0 for black, 1 for white   )(defrecord CMYColor    (cyan :unsigned-integer)   (magenta :unsigned-integer)   (yellow :unsigned-integer)   )(defrecord PMColor    (profile (:handle :cmprofile))   (color :cmcolor)   )(def-mactype :pmcolorptr (find-mactype '(:pointer :pmcolor)))(def-mactype :picker (find-mactype ':pointer))(defrecord PickerIconData    (scriptCode :signed-integer)   (iconSuiteID :signed-integer)   (helpResType :ostype)   (helpResID :signed-integer)   )(defrecord PickerInitData    (pickerDialog (:pointer :grafport))   (choicesDialog (:pointer :grafport))   (flags :signed-long)   (yourself :pointer)   )(defrecord PickerMenuItemInfo    (editMenuID :signed-integer)   (cutItem :signed-integer)   (copyItem :signed-integer)   (pasteItem :signed-integer)   (clearItem :signed-integer)   (undoItem :signed-integer)   )(defrecord PickerMenuState    (cutEnabled :boolean)   (copyEnabled :boolean)   (pasteEnabled :boolean)   (clearEnabled :boolean)   (undoEnabled :boolean)   (undoString (:string 255))   )(def-mactype :colorchangedprocptr (find-mactype ':pointer));  PROCEDURE ColorChanged(userData: LONGINT; VAR newColor: PMColor); (def-mactype :usereventprocptr (find-mactype ':pointer));  FUNCTION UserEvent(VAR event: EventRecord): BOOLEAN; (def-mactype :colorchangedupp (find-mactype ':pointer))(def-mactype :usereventupp (find-mactype ':pointer))(defrecord ColorPickerInfo    (theColor :pmcolor)   (dstProfile (:handle :cmprofile))   (flags :signed-long)   (placeWhere :signed-integer)   (dialogOrigin :point)   (pickerType :signed-long)   (eventProc :pointer)   (colorProc :pointer)   (colorProcData :signed-long)   (prompt (:string 255))   (mInfo :pickermenuiteminfo)   (newColorChosen :boolean)   (filler :signed-byte)   )(defrecord SystemDialogInfo    (flags :signed-long)   (pickerType :signed-long)   (placeWhere :signed-integer)   (dialogOrigin :point)   (mInfo :pickermenuiteminfo)   )(defrecord PickerDialogInfo    (flags :signed-long)   (pickerType :signed-long)   (dialogOrigin (:pointer :point))   (mInfo :pickermenuiteminfo)   )(defrecord ApplicationDialogInfo    (flags :signed-long)   (pickerType :signed-long)   (theDialog (:pointer :grafport))   (pickerOrigin :point)   (mInfo :pickermenuiteminfo)   )(defrecord EventData    (event (:pointer :eventrecord))   (action :signed-integer)   (itemHit :signed-integer)   (handled :boolean)   (filler :signed-byte)   (colorProc :pointer)   (colorProcData :signed-long)   (forcast :signed-integer)   )(defrecord EditData    (theEdit :signed-integer)   (action :signed-integer)   (handled :boolean)   (filler :signed-byte)   )(defrecord ItemHitData    (itemHit :signed-integer)   (iMod :signed-integer)   (action :signed-integer)   (colorProc :pointer)   (colorProcData :signed-long)   (where :point)   )(defrecord HelpItemInfo    (options :signed-long)   (tip :point)   (altRect :rect)   (theProc :signed-integer)   (helpVariant :signed-integer)   (helpMessage :hmmessagerecord)   ); 	Below are the color conversion routines.; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_Fix2SmallFract" ((f :signed-long))   (:stack :signed-integer)   (:stack-trap #xA82E f (1 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SmallFract2Fix" ((s :signed-integer))   (:stack :signed-long)   (:stack-trap #xA82E s (2 :signed-integer))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_CMY2RGB" ((cColor (:pointer :cmycolor)) (rColor (:pointer :rgbcolor)))   nil   (:stack-trap #xA82E cColor rColor (3 :signed-integer))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_RGB2CMY" ((rColor (:pointer :rgbcolor)) (cColor (:pointer :cmycolor)))   nil   (:stack-trap #xA82E rColor cColor (4 :signed-integer))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_HSL2RGB" ((hColor (:pointer :hslcolor)) (rColor (:pointer :rgbcolor)))   nil   (:stack-trap #xA82E hColor rColor (5 :signed-integer))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_RGB2HSL" ((rColor (:pointer :rgbcolor)) (hColor (:pointer :hslcolor)))   nil   (:stack-trap #xA82E rColor hColor (6 :signed-integer))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_HSV2RGB" ((hColor (:pointer :hsvcolor)) (rColor (:pointer :rgbcolor)))   nil   (:stack-trap #xA82E hColor rColor (7 :signed-integer))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_RGB2HSV" ((rColor (:pointer :rgbcolor)) (hColor (:pointer :hsvcolor)))   nil   (:stack-trap #xA82E rColor hColor (8 :signed-integer))); $ENDC; 	Below brings up the ColorPicker 1.0 Dialog; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_GetColor" ((where :point) (prompt (:string 255)) (inColor (:pointer :rgbcolor)) (outColor (:pointer :rgbcolor)))   (:stack :boolean)   (:stack-trap #xA82E where prompt inColor outColor (9 :signed-integer))); $ENDC; 	Below are the ColorPicker 2.0 routines.; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_PickColor" ((theColorInfo (:pointer :colorpickerinfo)))   (:stack :signed-integer)   (:stack-trap #xA82E theColorInfo (531 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_AddPickerToDialog" ((info (:pointer :applicationdialoginfo)) (thePicker (:pointer :pointer)))   (:stack :signed-integer)   (:stack-trap #xA82E info thePicker (1044 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_CreateColorDialog" ((info (:pointer :systemdialoginfo)) (thePicker (:pointer :pointer)))   (:stack :signed-integer)   (:stack-trap #xA82E info thePicker (1045 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_CreatePickerDialog" ((info (:pointer :pickerdialoginfo)) (thePicker (:pointer :pointer)))   (:stack :signed-integer)   (:stack-trap #xA82E info thePicker (1046 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_DisposeColorPicker" ((thePicker :pointer))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker (535 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_GetPickerVisibility" ((thePicker :pointer) (visible (:pointer :boolean)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker visible (1048 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SetPickerVisibility" ((thePicker :pointer) (visible :signed-integer))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker visible (793 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SetPickerPrompt" ((thePicker :pointer) (promptString (:pointer (:string 255))))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker promptString (1050 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_DoPickerEvent" ((thePicker :pointer) (data (:pointer :eventdata)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker data (1051 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_DoPickerEdit" ((thePicker :pointer) (data (:pointer :editdata)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker data (1052 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_DoPickerDraw" ((thePicker :pointer))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker (541 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_GetPickerColor" ((thePicker :pointer) (whichColor :signed-integer) (color (:pointer :pmcolor)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker whichColor color (1310 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SetPickerColor" ((thePicker :pointer) (whichColor :signed-integer) (color (:pointer :pmcolor)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker whichColor color (1311 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_GetPickerOrigin" ((thePicker :pointer) (where (:pointer :point)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker where (1056 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SetPickerOrigin" ((thePicker :pointer) (where :point))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker where (1057 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_GetPickerProfile" ((thePicker :pointer) (profile (:pointer (:handle :cmprofile))))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker profile (1058 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SetPickerProfile" ((thePicker :pointer) (profile (:handle :cmprofile)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker profile (1059 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_GetPickerEditMenuState" ((thePicker :pointer) (mState (:pointer :pickermenustate)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker mState (1060 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_ExtractPickerHelpItem" ((thePicker :pointer) (itemNo :signed-integer) (whichState :signed-integer) (helpInfo (:pointer :helpiteminfo)))   (:stack :signed-integer)   (:stack-trap #xA82E thePicker itemNo whichState helpInfo (1573 :signed-integer))); $ENDC(defconstant $uppColorChangedProcInfo #x3C0)    ;  PROCEDURE (4 byte param, 4 byte param); (defconstant $uppUserEventProcInfo #xD0)        ;  FUNCTION (4 byte param): 1 byte result; ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewColorChangedProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewUserEventProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallColorChangedProc" ((userData :signed-long) (newColor (:pointer :pmcolor)) (userRoutine :pointer))   nil   (#x205F #x4E90) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallUserEventProc" ((event (:pointer :eventrecord)) (userRoutine :pointer))   :boolean   (#x205F #x4E90) ); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := ColorPickerIncludes; $ENDC                                         ; __COLORPICKER__; $IFC NOT UsingIncludes; $ENDC(provide-interface 'ColorPicker)
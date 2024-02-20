(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:StandardFile.p"; at Tuesday June 6,1995 2:06:55 pm.; ;  	File:		StandardFile.p;  ;  	Contains:	Standard File package Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC; $IFC UNDEFINED __STANDARDFILE__; $SETC __STANDARDFILE__ := 1; $I+; $SETC StandardFileIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											#|                                              ; $IFC UNDEFINED __DIALOGS__|#(require-interface 'Dialogs)#|                                              ; $I Dialogs.p |#                                             ; $ENDC; 	Errors.p													; 	Memory.p													; 		MixedMode.p												; 	Windows.p													; 		Quickdraw.p												; 			QuickdrawText.p										; 		Events.p												; 			OSUtils.p											; 		Controls.p												; 			Menus.p												; 	TextEdit.p													#|                                              ; $IFC UNDEFINED __FILES__|#(require-interface 'Files)#|                                              ; $I Files.p |#                                             ; $ENDC; $PUSH; $ALIGN MAC68K; $LibExport+;  resource IDs and item offsets of pre-7.0 dialogs (defconstant $putDlgID -3999)(defconstant $putSave 1)(defconstant $putCancel 2)(defconstant $putEject 5)(defconstant $putDrive 6)(defconstant $putName 7)(defconstant $getDlgID -4000)(defconstant $getOpen 1)(defconstant $getCancel 3)(defconstant $getEject 5)(defconstant $getDrive 6)(defconstant $getNmList 7)(defconstant $getScroll 8);  resource IDs and item offsets of 7.0 dialogs (defconstant $sfPutDialogID -6043)(defconstant $sfGetDialogID -6042)(defconstant $sfItemOpenButton 1)(defconstant $sfItemCancelButton 2)(defconstant $sfItemBalloonHelp 3)(defconstant $sfItemVolumeUser 4)(defconstant $sfItemEjectButton 5)(defconstant $sfItemDesktopButton 6)(defconstant $sfItemFileListUser 7)(defconstant $sfItemPopUpMenuUser 8)(defconstant $sfItemDividerLinePict 9)(defconstant $sfItemFileNameTextEdit 10)(defconstant $sfItemPromptStaticText 11)(defconstant $sfItemNewFolderUser 12);  pseudo-item hits for use in DlgHook (defconstant $sfHookFirstCall -1)(defconstant $sfHookCharOffset #x1000)(defconstant $sfHookNullEvent 100)(defconstant $sfHookRebuildList 101)(defconstant $sfHookFolderPopUp 102)(defconstant $sfHookOpenFolder 103);  the following are only in system 7.0+ (defconstant $sfHookOpenAlias 104)(defconstant $sfHookGoToDesktop 105)(defconstant $sfHookGoToAliasTarget 106)(defconstant $sfHookGoToParent 107)(defconstant $sfHookGoToNextDrive 108)(defconstant $sfHookGoToPrevDrive 109)(defconstant $sfHookChangeSelection 110)(defconstant $sfHookSetActiveOffset 200)(defconstant $sfHookLastCall -2);  the refcon field of the dialog record during a;  modalfilter or dialoghook contains one of the following (defconstant $sfMainDialogRefCon :|stdf|)(defconstant $sfNewFolderDialogRefCon :|nfdr|)(defconstant $sfReplaceDialogRefCon :|rplc|)(defconstant $sfStatWarnDialogRefCon :|stat|)(defconstant $sfLockWarnDialogRefCon :|lock|)(defconstant $sfErrorDialogRefCon :|err |)(defrecord SFReply    (good :boolean)   (copy :boolean)   (fType :ostype)   (vRefNum :signed-integer)   (version :signed-integer)   (fName (:string 63))   )(defrecord StandardFileReply    (sfGood :boolean)   (sfReplacing :boolean)   (sfType :ostype)   (sfFile :fsspec)   (sfScript :signed-integer)   (sfFlags :signed-integer)   (sfIsFolder :boolean)   (sfIsVolume :boolean)   (sfReserved1 :signed-long)   (sfReserved2 :signed-integer)   );  for CustomXXXFile, ActivationOrderListPtr parameter is a pointer to an array of item numbers (def-mactype :activationorderlistptr (find-mactype '(:pointer :signed-integer)));  the following also include an extra parameter of "your data pointer" (def-mactype :dlghookprocptr (find-mactype ':pointer));  FUNCTION DlgHook(item: INTEGER; theDialog: DialogPtr): INTEGER; (def-mactype :filefilterprocptr (find-mactype ':pointer));  FUNCTION FileFilter(pb: CInfoPBPtr): BOOLEAN; (def-mactype :dlghookydprocptr (find-mactype ':pointer));  FUNCTION DlgHookYD(item: INTEGER; theDialog: DialogPtr; yourDataPtr: UNIV Ptr): INTEGER; (def-mactype :modalfilterydprocptr (find-mactype ':pointer));  FUNCTION ModalFilterYD(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER; yourDataPtr: UNIV Ptr): BOOLEAN; (def-mactype :filefilterydprocptr (find-mactype ':pointer));  FUNCTION FileFilterYD(pb: CInfoPBPtr; yourDataPtr: UNIV Ptr): BOOLEAN; (def-mactype :activateydprocptr (find-mactype ':pointer));  PROCEDURE ActivateYD(theDialog: DialogPtr; itemNo: INTEGER; activating: BOOLEAN; yourDataPtr: UNIV Ptr); (def-mactype :dlghookupp (find-mactype ':pointer))(def-mactype :filefilterupp (find-mactype ':pointer))(def-mactype :dlghookydupp (find-mactype ':pointer))(def-mactype :modalfilterydupp (find-mactype ':pointer))(def-mactype :filefilterydupp (find-mactype ':pointer))(def-mactype :activateydupp (find-mactype ':pointer))(defconstant $uppDlgHookProcInfo #x3A0)         ;  FUNCTION (2 byte param, 4 byte param): 2 byte result; (defconstant $uppFileFilterProcInfo #xD0)       ;  FUNCTION (4 byte param): 1 byte result; (defconstant $uppDlgHookYDProcInfo #xFA0)       ;  FUNCTION (2 byte param, 4 byte param, 4 byte param): 2 byte result; (defconstant $uppModalFilterYDProcInfo #x3FD0)  ;  FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; (defconstant $uppFileFilterYDProcInfo #x3D0)    ;  FUNCTION (4 byte param, 4 byte param): 1 byte result; (defconstant $uppActivateYDProcInfo #x36C0)     ;  PROCEDURE (4 byte param, 2 byte param, 1 byte param, 4 byte param); ; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewDlgHookProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewFileFilterProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewDlgHookYDProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewModalFilterYDProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewFileFilterYDProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM ;; Generated by translator basic-stack-trap(deftrap "_NewActivateYDProc" ((userRoutine :pointer))   (:stack :pointer)   (:stack-trap #x2E9F)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallDlgHookProc" ((item :signed-integer) (theDialog (:pointer :grafport)) (userRoutine :pointer))   :signed-integer   (#x205F #x4E90) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallFileFilterProc" ((pb (:pointer :cinfopbrec)) (userRoutine :pointer))   :boolean   (#x205F #x4E90) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallDlgHookYDProc" ((item :signed-integer) (theDialog (:pointer :grafport)) (yourDataPtr :pointer) (userRoutine :pointer))   :signed-integer   (#x205F #x4E90) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallModalFilterYDProc" ((theDialog (:pointer :grafport)) (theEvent (:pointer :eventrecord)) (itemHit (:pointer :signed-integer)) (yourDataPtr :pointer) (userRoutine :pointer))   :boolean   (#x205F #x4E90) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallFileFilterYDProc" ((pb (:pointer :cinfopbrec)) (yourDataPtr :pointer) (userRoutine :pointer))   :boolean   (#x205F #x4E90) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_CallActivateYDProc" ((theDialog (:pointer :grafport)) (itemNo :signed-integer) (activating :boolean) (yourDataPtr :pointer) (userRoutine :pointer))   nil   (#x205F #x4E90) ); $ENDC(defrecord SFTypeList (array (array :ostype 4))); ; 	The GetFile "typeList" parameter type has changed from "SFTypeList" to "ConstSFTypeListPtr".; 	For C, this will add "const" and make it an in-only parameter.; 	For Pascal, this will require client code to use the @ operator, but make it easier to specify long lists.; ; 	ConstSFTypeListPtr is a pointer to an array of OSTypes.; (def-mactype :constsftypelistptr (find-mactype '(:pointer :ostype))); $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SFPutFile" ((where :point) (prompt (:string 255)) (origName (:string 255)) (dlgHook :pointer) (reply (:pointer :sfreply)))   nil   (:stack-trap #xA9EA where prompt origName dlgHook reply (1 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SFGetFile" ((where :point) (prompt (:string 255)) (fileFilter :pointer) (numTypes :signed-integer) (typeList (:pointer :ostype)) (dlgHook :pointer) (reply (:pointer :sfreply)))   nil   (:stack-trap #xA9EA where prompt fileFilter numTypes typeList dlgHook reply (2 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SFPPutFile" ((where :point) (prompt (:string 255)) (origName (:string 255)) (dlgHook :pointer) (reply (:pointer :sfreply)) (dlgID :signed-integer) (filterProc :pointer))   nil   (:stack-trap #xA9EA where prompt origName dlgHook reply dlgID filterProc (3 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_SFPGetFile" ((where :point) (prompt (:string 255)) (fileFilter :pointer) (numTypes :signed-integer) (typeList (:pointer :ostype)) (dlgHook :pointer) (reply (:pointer :sfreply)) (dlgID :signed-integer) (filterProc :pointer))   nil   (:stack-trap #xA9EA where prompt fileFilter numTypes typeList dlgHook reply dlgID filterProc (4 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_StandardPutFile" ((prompt (:string 255)) (defaultName (:string 255)) (reply (:pointer :standardfilereply)))   nil   (:stack-trap #xA9EA prompt defaultName reply (5 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_StandardGetFile" ((fileFilter :pointer) (numTypes :signed-integer) (typeList (:pointer :ostype)) (reply (:pointer :standardfilereply)))   nil   (:stack-trap #xA9EA fileFilter numTypes typeList reply (6 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_CustomPutFile" ((prompt (:string 255)) (defaultName (:string 255)) (reply (:pointer :standardfilereply)) (dlgID :signed-integer) (where :point) (dlgHook :pointer) (filterProc :pointer) (activeList (:pointer :signed-integer)) (activate :pointer) (yourDataPtr :pointer))   nil   (:stack-trap #xA9EA prompt defaultName reply dlgID where dlgHook filterProc activeList activate yourDataPtr (7 :signed-integer))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-word-on-stack(deftrap "_CustomGetFile" ((fileFilter :pointer) (numTypes :signed-integer) (typeList (:pointer :ostype)) (reply (:pointer :standardfilereply)) (dlgID :signed-integer) (where :point) (dlgHook :pointer) (filterProc :pointer) (activeList (:pointer :signed-integer)) (activate :pointer) (yourDataPtr :pointer))   nil   (:stack-trap #xA9EA fileFilter numTypes typeList reply dlgID where dlgHook filterProc activeList activate yourDataPtr (8 :signed-integer))); $ENDC; $ALIGN RESET                                  ; $POP; $SETC UsingIncludes := StandardFileIncludes; $ENDC; __STANDARDFILE__#|                                              ; $IFC NOT UsingIncludes;; No calling method defined for this trap(deftrap-inline "_StandardOpenDialog" ((reply (:pointer :standardfilereply)))   :signed-integer   () ) |#                                             ; $ENDC(provide-interface 'StandardFile)
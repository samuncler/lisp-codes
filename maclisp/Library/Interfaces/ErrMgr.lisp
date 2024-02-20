(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:ErrMgr.p"; at Tuesday June 6,1995 2:08:40 pm.; ; 	File:		ErrMgr.p; ; 	Copyright:	� 1987-88, 1993-95 by Apple Computer, Inc.; 				All rights reserved.; ; 	Version:	3.4a4; 	Created:	Tuesday, March 30, 1993 18:00; ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED UsingErrMgr AND UNDEFINED __ERRMGR__; $SETC UsingErrMgr := 1; $SETC __ERRMGR__ := 1; $I+; $SETC ErrMgrIncludes := UsingIncludes; $SETC UsingIncludes := 1; $IFC UNDEFINED UsingTypes AND UNDEFINED __TYPES__(require-interface 'Types)                      ; $I Types.p; $ENDC; $SETC UsingIncludes := ErrMgrIncludes;  ErrMgr initialization.This must be done before using any other ErrMgr; routine.  Set showToolErrNbrs to true if you want all tool messages to contain; the error number following the message text enclosed in parentheses (e.g.,; "<msg txt> ([OS] Error <n>)"; system error messages always contain the error; number).  The toolErrFileName parameter is used to specify the name of a; tool-specific error file, and should be the NULL or a null string if not used; (or if the tool's data fork is to be used as the error file, see; GetToolErrText for futher details). The sysErrFileName parameter is used to; specify the name of a system error file, and should normally be the NULL or a; null string, which causes the ErrMgr to look in the MPW Shell directory for; "SysErrs.Err" (see GetSysErrText).            ; $IFC UNDEFINED __CFM68K__; $PUSH; $LibExport+; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_InitErrMgr" ((toolErrFilename (:string 255)) (sysErrFilename (:string 255)) (showToolErrNbrs :boolean))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_CloseErrMgr" ()   nil   () );  Ideally a CloseErrMgr should be done at the end of execution to make sure all; files opened by the ErrMgr are closed.	You can let normal program termination; do the closing.  But if you are a purist...;  ; $IFC UNDEFINED __CFM68K__; $POP; $ENDC;  Get the error message text corresponding to system error number errNbr from; the system error message file (whose name was specified in the InitErrMgr; call).	The text of the message is returned in errMsg and the function returns; a pointer to errMsg.  The maximum length of the message is limited to 254; characters.; ; Note, if a system message filename was not specified to InitErrMgr, then the; ErrMgr assumes the message file contained in the file "SysErrs.Err".  This; file is first accessed as "                                 {ShellDirectory}SysErrs.Err" on the assumption that; SysErrs.Err is kept in the same directory as the MPW Shell.  If the file; cannot be opened, then an open is attempted on "SysErrs.Err" in the System; Folder.                                       ; $IFC UNDEFINED __CFM68K__; $PUSH; $LibExport+; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_GetSysErrText" ((msgNbr :signed-integer) (errMsg (:pointer (:string 255))))   nil   () );; Warning: No calling method defined for this trap(deftrap-inline "_AddErrInsert" ((insert (:string 255)) (msgString (:pointer (:string 255))))   nil   () );  Add another insert to an error message string.This call is used when more; than one insert is to be added to a message (because it contains more than; one '^' character).;  ; $IFC UNDEFINED __CFM68K__; $POP; $ENDC;  Get the error message text corresponding to tool error number errNbr from; the tool error message file (whose name was specified in the InitErrMgr; call).	The text of the message is returned in errMsg and the function returns; a pointer to errMsg.  The maximum length of the message is limited to 254; characters.  If the message is to have an insert, then ErrInsert should be a; pointer to it.	Otherwise it should be either be a null string or a NULL; pointer.; ; Inserts are indicated in error messages by specifying a '^' to indicate where; the insert is to be placed.; ; Note, if a tool message filename was not specified to InitErrMgr, then the; ErrMgr assumes the message file contained in the data fork of the tool calling; the ErrMgr.  This name is contained in the Shell variable	{Command} and the; value of that variable is used to open the error message file. ; $ENDC;  UsingErrMgr ; $IFC NOT UsingIncludes;; Warning: No calling method defined for this trap(deftrap-inline "_GetToolErrText" ((msgNbr :signed-integer) (errInsert (:string 255)) (errMsg (:pointer (:string 255))))   nil   () ); $ENDC(provide-interface 'ErrMgr)
(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:Signal.p"; at Tuesday June 6,1995 2:20:38 pm.; ; Created: Friday, August 2, 1991 at 11:40 PM;  Signal.p;  Pascal Interface to the Macintosh Libraries; ; 	Signal Handling interface.; 	This must be compatible with C's <signal.h>; ;   Copyright Apple Computer, Inc. 1986, 1987, 1988, 1991, 1994;   All rights reserved; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED UsingSignal AND UNDEFINED __SIGNAL__; $SETC UsingSignal := 1; $SETC __SIGNAL__ := 1; $I+; $SETC SignalIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __CONDITIONALMACROS__|#(require-interface 'ConditionalMacros)#|                                              ; $I ConditionalMacros.p |#                                             ; $ENDC; $ALIGN MAC68K(def-mactype :signalmap (find-mactype ':signed-integer))(def-mactype :signalhandler (find-mactype '(:pointer :signed-long)));  Pointer to function (defconstant $SIG_ERR -1)                       ;  Returned by IEsignal on error (defconstant $SIG_IGN 0)(defconstant $SIG_DFL 1)(defconstant $SIG_HOLD 3)(defconstant $SIG_RELEASE 5)(defconstant $SIGABRT #x1)(defconstant $SIGINT #x2)                       ;  Currently only SIGINT implemented (defconstant $SIGFPE #x4)(defconstant $SIGILL #x8)(defconstant $SIGSEGV #x10)(defconstant $SIGTERM #x20);  Signal Handling Functions #|                                              ; $IFC NOT UNDEFINED __CFM68K__; $IFC NOT UNDEFINED UsingSharedLibs; $PUSH; $LibExport+; $ENDC |#                                             ; $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_IEsignal" ((sigNum :signed-long) (sigHdlr (:pointer :signed-long)))   (:pointer :signed-long)   () );; Warning: No calling method defined for this trap(deftrap-inline "_IEraise" ((sigNum :signed-long))   :signed-long   () )#|                                              ; $IFC NOT UNDEFINED __CFM68K__; $IFC NOT UNDEFINED UsingSharedLibs; $POP; $ENDC |#                                             ; $ENDC; $ALIGN RESET; $SETC UsingIncludes := SignalIncludes; $ENDC                                         ;  UsingSignal ; $IFC NOT UsingIncludes; $ENDC(provide-interface 'Signal)
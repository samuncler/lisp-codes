(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:CMComponent.p"; at Tuesday June 6,1995 2:06:19 pm.; ;  	File:		CMComponent.p;  ;  	Contains:	Stub for including new file names.;  ;  	Version:	Technology:	ColorSync 2.0;  				Package:	Universal Interfaces 2.1�1 in �MPW Prerelease� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __CMCOMPONENT__; $SETC __CMCOMPONENT__ := 1; $I+; $SETC CMComponentIncludes := UsingIncludes; $SETC UsingIncludes := 1;  ; 	This file has been included to allow older source code ; 	to #include <CMComponent.h>.  Please update your source; 	code to directly #include <CMMComponent.h>; 	  and			 #include <CMPRComponent.h>; ; ;  #include the two ColorSync 2.0 files equivalent to the v. 1.0 file ; $IFC UNDEFINED __CMMCOMPONENT__(require-interface 'CMMComponent)               ; $I CMMComponent.p; $ENDC; 	Types.p														; 		ConditionalMacros.p										; 	Quickdraw.p													; 		MixedMode.p												; 		QuickdrawText.p											; 	Components.p												; 	CMApplication.p												; 		Files.p													; 			OSUtils.p											; 				Memory.p										; 		Printing.p												; 			Errors.p											; 			Dialogs.p											; 				Windows.p										; 					Events.p									; 					Controls.p									; 						Menus.p									; 				TextEdit.p										; 		CMICCProfile.p											; $IFC UNDEFINED __CMPRCOMPONENT__(require-interface 'CMPRComponent)              ; $I CMPRComponent.p; $ENDC; $SETC UsingIncludes := CMComponentIncludes; $ENDC                                         ; __CMCOMPONENT__; $IFC NOT UsingIncludes; $ENDC(provide-interface 'CMComponent)
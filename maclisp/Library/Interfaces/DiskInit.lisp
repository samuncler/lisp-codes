(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:DiskInit.p"; at Tuesday June 6,1995 2:07:58 pm.; ;  	File:		DiskInit.p;  ;  	Contains:	Disk Initialization Package ('PACK' 2) Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __DISKINIT__; $SETC __DISKINIT__ := 1; $I+; $SETC DiskInitIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											; $PUSH; $ALIGN MAC68K; $LibExport+(defrecord HFSDefaults    (sigWord (:array :character 2 :packed))      ;  signature word    (abSize :signed-long)                        ;  allocation block size in bytes    (clpSize :signed-long)                       ;  clump size in bytes    (nxFreeFN :signed-long)                      ;  next free file number    (btClpSize :signed-long)                     ;  B-Tree clump size in bytes    (rsrv1 :signed-integer)                      ;  reserved    (rsrv2 :signed-integer)                      ;  reserved    (rsrv3 :signed-integer)                      ;  reserved    ); $IFC SystemSevenOrLater ; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DILoad" ()   nil   (#x7002 #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIUnload" ()   nil   (#x7004 #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIBadMount" ((where :point) (evtMessage :signed-long))   :signed-integer   (#x7000 #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIFormat" ((drvNum :signed-integer))   :signed-integer   (#x7006 #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIVerify" ((drvNum :signed-integer))   :signed-integer   (#x7008 #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIZero" ((drvNum :signed-integer) (volName (:string 255)))   :signed-integer   (#x700A #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIXFormat" ((drvNum :signed-integer) (fmtFlag :boolean) (fmtArg :signed-long) (actSize (:pointer :signed-long)))   :signed-integer   (#x700C #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIXZero" ((drvNum :signed-integer) (volName (:string 255)) (fsid :signed-integer) (mediaStatus :signed-integer) (volTypeSelector :signed-integer) (volSize :signed-long) (extendedInfoPtr :pointer))   :signed-integer   (#x700E #x3F00 #xA9E9) ); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_DIReformat" ((drvNum :signed-integer) (fsid :signed-integer) (volName (:string 255)) (msgText (:string 255)))   :signed-integer   (#x7010 #x3F00 #xA9E9) ); $ENDC#|                                              ; $ELSEC;; Inline instructions called as foreign function(deftrap-inline "_DILoad" ()   nil   (#x7002 #x3F00 #xA9E9) );; Inline instructions called as foreign function(deftrap-inline "_DIUnload" ()   nil   (#x7004 #x3F00 #xA9E9) );; Inline instructions called as foreign function(deftrap-inline "_DIBadMount" ((where :point) (evtMessage :signed-long))   :signed-integer   (#x7000 #x3F00 #xA9E9) );; Inline instructions called as foreign function(deftrap-inline "_DIFormat" ((drvNum :signed-integer))   :signed-integer   (#x7006 #x3F00 #xA9E9) );; Inline instructions called as foreign function(deftrap-inline "_DIVerify" ((drvNum :signed-integer))   :signed-integer   (#x7008 #x3F00 #xA9E9) ) |#                                             ; $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := DiskInitIncludes; $ENDC; __DISKINIT__; $IFC NOT UsingIncludes;; Inline instructions called as foreign function(deftrap-inline "_DIZero" ((drvNum :signed-integer) (volName (:string 255)))   :signed-integer   (#x700A #x3F00 #xA9E9) ); $ENDC(provide-interface 'DiskInit)
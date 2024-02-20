(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:ToolUtils.p"; at Tuesday June 6,1995 2:22:51 pm.; ;  	File:		ToolUtils.p;  ;  	Contains:	Toolbox Utilities Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __TOOLUTILS__; $SETC __TOOLUTILS__ := 1; $I+; $SETC ToolUtilsIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											#|                                              ; $IFC UNDEFINED __QUICKDRAW__|#(require-interface 'Quickdraw)#|                                              ; $I Quickdraw.p |#                                             ; $ENDC; 	MixedMode.p													; 	QuickdrawText.p												#|                                              ; $IFC UNDEFINED __OSUTILS__|#(require-interface 'OSUtils)#|                                              ; $I OSUtils.p |#                                             ; $ENDC; 	Memory.p													#|                                              ; $IFC UNDEFINED __TEXTUTILS__|#(require-interface 'TextUtils)#|                                              ; $I TextUtils.p |#                                             ; $ENDC; 	Script.p													; 		IntlResources.p											; 		Events.p												#|                                              ; $IFC UNDEFINED __FIXMATH__|#(require-interface 'FixMath)#|                                              ; $I FixMath.p |#                                             ; $ENDC; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $sysPatListID 0)(defconstant $iBeamCursor 1)(defconstant $crossCursor 2)(defconstant $plusCursor 3)(defconstant $watchCursor 4)(defrecord Int64Bit    (hiLong :signed-long)   ;;Changing field lolong from signed-long to unsigned-long to match C header (pretty-darn-sure)   (loLong :unsigned-long)   ); $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FixRatio" ((numer :signed-integer) (denom :signed-integer))   (:stack :signed-long)   (:stack-trap #xA869)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FixMul" ((a :signed-long) (b :signed-long))   (:stack :signed-long)   (:stack-trap #xA868)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FixRound" ((x :signed-long))   (:stack :signed-integer)   (:stack-trap #xA86C)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_PackBits" ((srcPtr (:pointer :pointer)) (dstPtr (:pointer :pointer)) (srcBytes :signed-integer))   nil   (:stack-trap #xA8CF)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_UnpackBits" ((srcPtr (:pointer :pointer)) (dstPtr (:pointer :pointer)) (dstBytes :signed-integer))   nil   (:stack-trap #xA8D0)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitTst" ((bytePtr :pointer) (bitNum :signed-long))   (:stack :boolean)   (:stack-trap #xA85D)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitSet" ((bytePtr :pointer) (bitNum :signed-long))   nil   (:stack-trap #xA85E)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitClr" ((bytePtr :pointer) (bitNum :signed-long))   nil   (:stack-trap #xA85F)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitAnd" ((value1 :signed-long) (value2 :signed-long))   (:stack :signed-long)   (:stack-trap #xA858)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitOr" ((value1 :signed-long) (value2 :signed-long))   (:stack :signed-long)   (:stack-trap #xA85B)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitXor" ((value1 :signed-long) (value2 :signed-long))   (:stack :signed-long)   (:stack-trap #xA859)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitNot" ((value :signed-long))   (:stack :signed-long)   (:stack-trap #xA85A)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_BitShift" ((value :signed-long) (count :signed-integer))   (:stack :signed-long)   (:stack-trap #xA85C)); $ENDC; $IFC GENERATING68K ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_LongMul" ((a :signed-long) (b :signed-long) (result (:pointer :int64bit)))   nil   (:stack-trap #xA867)); $ENDC; $ENDC; $IFC OLDROUTINELOCATIONS ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_GetIcon" ((iconID :signed-integer))   (:stack :handle)   (:stack-trap #xA9BB)); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_PlotIcon" ((theRect (:pointer :rect)) (theIcon :handle))   nil   (:stack-trap #xA94B)); $ENDC; $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_GetPattern" ((patternID :signed-integer))   (:stack (:handle :pattern))   (:stack-trap #xA9B8)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_GetCursor" ((cursorID :signed-integer))   (:stack (:handle :cursor))   (:stack-trap #xA9B9)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_GetPicture" ((pictureID :signed-integer))   (:stack (:handle :picture))   (:stack-trap #xA9BC)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_SlopeFromAngle" ((angle :signed-integer))   (:stack :signed-long)   (:stack-trap #xA8BC)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_AngleFromSlope" ((slope :signed-long))   (:stack :signed-integer)   (:stack-trap #xA8C4)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_DeltaPoint" ((ptA :point) (ptB :point))   (:stack :signed-long)   (:stack-trap #xA94F)); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_ShieldCursor" ((shieldRect (:pointer :rect)) (offsetPt :point))   nil   (:stack-trap #xA855)); $ENDC; $IFC NOT GENERATINGCFM;; Inline instructions called as foreign function(deftrap-inline "_ScreenRes" ((scrnHRes (:pointer :signed-integer)) (scrnVRes (:pointer :signed-integer)))   nil   (#x225F #x32B8 #x102 #x225F #x32B8 #x104) ); $ENDC;; Warning: No calling method defined for this trap(deftrap-inline "_GetIndPattern" ((thePat (:pointer :pattern)) (patternListID :signed-integer) (index :signed-integer))   nil   () )                                         ; $IFC NOT GENERATINGCFM;; Generated by hand(deftrap ("_HiWord" nil) ((x :signed-long))   (:no-trap :signed-integer)  (:no-trap (ccl::rlet ((p :long))              (setf (%get-long p) x)              (%get-signed-word p)))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by hand(deftrap ("_LoWord" nil) ((x :signed-long))   (:no-trap :signed-integer)  (:no-trap (ccl::rlet ((p :long))              (setf (%get-long p) x)              (%get-signed-word p 2)))); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := ToolUtilsIncludes; $ENDC                                         ; __TOOLUTILS__; $IFC NOT UsingIncludes; $ENDC(provide-interface 'ToolUtils)
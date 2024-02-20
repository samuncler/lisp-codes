(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:FixMath.p"; at Tuesday June 6,1995 2:09:11 pm.; ;  	File:		FixMath.p;  ;  	Contains:	Fixed Math Interfaces.;  ;  	Version:	Technology:	System 7.5;  				Package:	Universal Interfaces 2.0 in �MPW Latest� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __FIXMATH__; $SETC __FIXMATH__ := 1; $I+; $SETC FixMathIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $fixed1 #x10000)(defconstant $fract1 #x40000000)(defconstant $positiveInfinity #x7FFFFFFF)(defconstant $negativeInfinity #x80000000); $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_Fix2Frac" ((x :signed-long))   (:stack :signed-long)   (:stack-trap #xA841)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_Fix2Long" ((x :signed-long))   (:stack :signed-long)   (:stack-trap #xA840)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_Long2Fix" ((x :signed-long))   (:stack :signed-long)   (:stack-trap #xA83F)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_Frac2Fix" ((x :signed-long))   (:stack :signed-long)   (:stack-trap #xA842)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FracMul" ((x :signed-long) (y :signed-long))   (:stack :signed-long)   (:stack-trap #xA84A)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FixDiv" ((x :signed-long) (y :signed-long))   (:stack :signed-long)   (:stack-trap #xA84D)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FracDiv" ((x :signed-long) (y :signed-long))   (:stack :signed-long)   (:stack-trap #xA84B)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FracSqrt" ((x :signed-long))   (:stack :signed-long)   (:stack-trap #xA849)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FracSin" ((x :signed-long))   (:stack :signed-long)   (:stack-trap #xA848)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FracCos" ((x :signed-long))   (:stack :signed-long)   (:stack-trap #xA847)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_FixATan2" ((x :signed-long) (y :signed-long))   (:stack :signed-long)   (:stack-trap #xA818)); $ENDC#|                                              ; $IFC GENERATINGPOWERPC ; CONST;; Inline instructions called as foreign function(deftrap-inline "_WideAdd" ((target (:pointer :wide)) (source (:pointer :wide)))   (:pointer :wide)   (:c #x303C #x4C #xA832) ); CONST                                         ; CONST;; Inline instructions called as foreign function(deftrap-inline "_WideCompare" ((target (:pointer :wide)) (source (:pointer :wide)))   :signed-integer   (:c #x303C #x4D #xA832) );; Inline instructions called as foreign function(deftrap-inline "_WideNegate" ((target (:pointer :wide)))   (:pointer :wide)   (:c #x303C #x4E #xA832) );; Inline instructions called as foreign function(deftrap-inline "_WideShift" ((target (:pointer :wide)) (shift :signed-long))   (:pointer :wide)   (:c #x303C #x4F #xA832) ); CONST;; Inline instructions called as foreign function(deftrap-inline "_WideSquareRoot" ((source (:pointer :wide)))   :signed-long   (:c #x303C #x50 #xA832) ); CONST;; Inline instructions called as foreign function(deftrap-inline "_WideSubtract" ((target (:pointer :wide)) (source (:pointer :wide)))   (:pointer :wide)   (:c #x303C #x51 #xA832) );; Inline instructions called as foreign function(deftrap-inline "_WideMultiply" ((multiplicand :signed-long) (multiplier :signed-long) (target (:pointer :wide)))   (:pointer :wide)   (:c #x303C #x52 #xA832) );  returns the quotient ; CONST;; Inline instructions called as foreign function(deftrap-inline "_WideDivide" ((dividend (:pointer :wide)) (divisor :signed-long) (remainder (:pointer :signed-long)))   :signed-long   (:c #x303C #x53 #xA832) );  quotient replaces dividend ;; Inline instructions called as foreign function(deftrap-inline "_WideWideDivide" ((dividend (:pointer :wide)) (divisor :signed-long) (remainder (:pointer :signed-long)))   (:pointer :wide)   (:c #x303C #x55 #xA832) );; No calling method defined for this trap(deftrap-inline "_WideBitShift" ((src (:pointer :wide)) (shift :signed-long))   (:pointer :wide)   () ) |#                                             ; $ENDC; $IFC GENERATING68K  & NOT GENERATING68881 ; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_Frac2X" ((x :signed-long))   (:stack :pointer)   (:stack-trap #xA845)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_Fix2X" ((x :signed-long))   (:stack :pointer)   (:stack-trap #xA843)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_X2Fix" ((x :pointer))   (:stack :signed-long)   (:stack-trap #xA844)); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator basic-stack-trap(deftrap "_X2Frac" ((x :pointer))   (:stack :signed-long)   (:stack-trap #xA846)); $ENDC#|                                              ; $ELSEC;; Generated by translator basic-stack-trap(deftrap "_Frac2X" ((x :signed-long))   (:stack :pointer)   (:stack-trap #xA845));; Generated by translator basic-stack-trap(deftrap "_Fix2X" ((x :signed-long))   (:stack :pointer)   (:stack-trap #xA843));; Generated by translator basic-stack-trap(deftrap "_X2Fix" ((x :pointer))   (:stack :signed-long)   (:stack-trap #xA844)) |#                                             ; $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := FixMathIncludes; $ENDC; __FIXMATH__; $IFC NOT UsingIncludes;; Generated by translator basic-stack-trap(deftrap "_X2Frac" ((x :pointer))   (:stack :signed-long)   (:stack-trap #xA846)); $ENDC(provide-interface 'FixMath)
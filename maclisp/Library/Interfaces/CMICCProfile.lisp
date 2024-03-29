(in-package :TRAPS); Generated from #P"HD:CCL3.0d17:Interface Translator:Source interfaces:Pascal Interfaces:CMICCProfile.p"; at Tuesday June 6,1995 2:05:54 pm.; ;  	File:		CMICCProfile.p;  ;  	Contains:	Definitions for ColorSync 2.0 profile;  ;  	Version:	Technology:	ColorSync 2.0;  				Package:	Universal Interfaces 2.1�1 in �MPW Prerelease� on ETO #17;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter;  				stack.  Include the file and version information (from above);  				in the problem description and send to:;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC; $IFC UNDEFINED __CMICCPROFILE__; $SETC __CMICCPROFILE__ := 1; $I+; $SETC CMICCProfileIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __TYPES__|#(require-interface 'Types)#|                                              ; $I Types.p |#                                             ; $ENDC; 	ConditionalMacros.p											; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $cmCS2ProfileVersion #x2000000);  Current Major version number (defconstant $cmCurrentProfileMajorVersion #x2000000);  magic cookie number for anonymous file ID (defconstant $cmMagicNumber :|acsp|);  ColorSync profile version 1.0 (defconstant $cmCS1ProfileVersion #x100); **********************************************************************; ************** ColorSync 2.0 profile specification *******************; **********************************************************************;  profile flags element values (defconstant $cmEmbeddedProfile 0)              ;  0 is not embedded profile, 1 is embedded profile (defconstant $cmEmbeddedUse 1)                  ;  0 is to use anywhere, 1 is to use as embedded profile only ;  data type element values (defconstant $cmAsciiData 0)(defconstant $cmBinaryData 1);  rendering intent element values  (defconstant $cmPerceptual 0)                   ;  Photographic images (defconstant $cmRelativeColorimetric 1)         ;  Logo Colors (defconstant $cmSaturation 2)                   ;  Business graphics (defconstant $cmAbsoluteColorimetric 3)         ;  Logo Colors ;  speed and quality flag options (defconstant $cmNormalMode 0)                   ;  it uses the least significent two bits in the high word of flag (defconstant $cmDraftMode 1)                    ;  it should be evaulated like this: right shift 16 bits first, mask off the (defconstant $cmBestMode 2)                     ;  high 14 bits, and then compare with the enum to determine the option value ;  device/media attributes element values  (defconstant $cmReflective 0)                   ;  0 is reflective media, 1 is transparency media (defconstant $cmGlossy 1)                       ;  0 is glossy, 1 is matte ;  screen encodings  (defconstant $cmPrtrDefaultScreens 0)           ;  Use printer default screens.  0 is false, 1 is ture (defconstant $cmLinesPer 1)                     ;  0 is LinesPerCm, 1 is LinesPerInch ;  2.0 tag type information (defconstant $cmNumHeaderElements 10);  public tags (defconstant $cmAToB0Tag :|A2B0|)(defconstant $cmAToB1Tag :|A2B1|)(defconstant $cmAToB2Tag :|A2B2|)(defconstant $cmBlueColorantTag :|bXYZ|)(defconstant $cmBlueTRCTag :|bTRC|)(defconstant $cmBToA0Tag :|B2A0|)(defconstant $cmBToA1Tag :|B2A1|)(defconstant $cmBToA2Tag :|B2A2|)(defconstant $cmCalibrationDateTimeTag :|calt|)(defconstant $cmCharTargetTag :|targ|)(defconstant $cmCopyrightTag :|cprt|)(defconstant $cmDeviceMfgDescTag :|dmnd|)(defconstant $cmDeviceModelDescTag :|dmdd|)(defconstant $cmGamutTag :|gamt|)(defconstant $cmGrayTRCTag :|kTRC|)(defconstant $cmGreenColorantTag :|gXYZ|)(defconstant $cmGreenTRCTag :|gTRC|)(defconstant $cmLuminanceTag :|lumi|)(defconstant $cmMeasurementTag :|meas|)(defconstant $cmMediaBlackPointTag :|bkpt|)(defconstant $cmMediaWhitePointTag :|wtpt|)(defconstant $cmNamedColorTag :|ncol|)(defconstant $cmPreview0Tag :|pre0|)(defconstant $cmPreview1Tag :|pre1|)(defconstant $cmPreview2Tag :|pre2|)(defconstant $cmProfileDescriptionTag :|desc|)(defconstant $cmProfileSequenceDescTag :|pseq|)(defconstant $cmPS2CRD0Tag :|psd0|)(defconstant $cmPS2CRD1Tag :|psd1|)(defconstant $cmPS2CRD2Tag :|psd2|)(defconstant $cmPS2CRD3Tag :|psd3|)(defconstant $cmPS2CSATag :|ps2s|)(defconstant $cmPS2RenderingIntentTag :|ps2i|)(defconstant $cmRedColorantTag :|rXYZ|)(defconstant $cmRedTRCTag :|rTRC|)(defconstant $cmScreeningDescTag :|scrd|)(defconstant $cmScreeningTag :|scrn|)(defconstant $cmTechnologyTag :|tech|)(defconstant $cmUcrBgTag :|bfd |)(defconstant $cmViewingConditionsDescTag :|vued|)(defconstant $cmViewingConditionsTag :|view|);  custom tags (defconstant $cmPS2CRDVMSizeTag :|psvm|);  technology tag descriptions (defconstant $cmTechnologyFilmScanner :|fscn|)(defconstant $cmTechnologyReflectiveScanner :|rscn|)(defconstant $cmTechnologyInkJetPrinter :|ijet|)(defconstant $cmTechnologyThermalWaxPrinter :|twax|)(defconstant $cmTechnologyElectrophotographicPrinter :|epho|)(defconstant $cmTechnologyElectrostaticPrinter :|esta|)(defconstant $cmTechnologyDyeSublimationPrinter :|dsub|)(defconstant $cmTechnologyPhotographicPaperPrinter :|rpho|)(defconstant $cmTechnologyFilmWriter :|fprn|)(defconstant $cmTechnologyVideoMonitor :|vidm|)(defconstant $cmTechnologyVideoCamera :|vidc|)(defconstant $cmTechnologyProjectionTelevision :|pjtv|)(defconstant $cmTechnologyCRTDisplay :|CRT |)(defconstant $cmTechnologyPMDisplay :|PMD |)(defconstant $cmTechnologyAMDisplay :|AMD |)(defconstant $cmTechnologyPhotoCD :|KPCD|)(defconstant $cmTechnologyPhotoImageSetter :|imgs|)(defconstant $cmTechnologyGravure :|grav|)(defconstant $cmTechnologyOffsetLithography :|offs|)(defconstant $cmTechnologySilkscreen :|silk|)(defconstant $cmTechnologyFlexography :|flex|);  type signatures (defconstant $cmSigCurveType :|curv|)(defconstant $cmSigDataType :|data|)(defconstant $cmSigDateTimeType :|dtim|)(defconstant $cmSigLut16Type :|mft2|)(defconstant $cmSigLut8Type :|mft1|)(defconstant $cmSigMeasurementType :|meas|)(defconstant $cmSigNamedColorType :|ncol|)(defconstant $cmSigProfileDescriptionType :|desc|)(defconstant $cmSigScreeningType :|scrn|)(defconstant $cmSigS15Fixed16Type :|sf32|)(defconstant $cmSigSignatureType :|sig |)(defconstant $cmSigTextType :|text|)(defconstant $cmSigU16Fixed16Type :|uf32|)(defconstant $cmSigU1Fixed15Type :|uf16|)(defconstant $cmSigUInt32Type :|ui32|)(defconstant $cmSigUInt64Type :|ui64|)(defconstant $cmSigUInt8Type :|ui08|)(defconstant $cmSigViewingConditionsType :|view|)(defconstant $cmSigXYZType :|XYZ |);  Measurement type encodings ;  Measurement Flare (defconstant $cmFlare0 #x0)(defconstant $cmFlare100 #x1);  Measurement Geometry	(defconstant $cmGeometryUnknown #x0)(defconstant $cmGeometry045or450 #x1)(defconstant $cmGeometry0dord0 #x2);  Standard Observer	(defconstant $cmStdobsUnknown #x0)(defconstant $cmStdobs1931TwoDegrees #x1)(defconstant $cmStdobs1964TenDegrees #x2);  Standard Illuminant (defconstant $cmIlluminantUnknown #x0)(defconstant $cmIlluminantD50 #x1)(defconstant $cmIlluminantD65 #x2)(defconstant $cmIlluminantD93 #x3)(defconstant $cmIlluminantF2 #x4)(defconstant $cmIlluminantD55 #x5)(defconstant $cmIlluminantA #x6)(defconstant $cmIlluminantEquiPower #x7)(defconstant $cmIlluminantF8 #x8);  Spot Function Value (defconstant $cmSpotFunctionUnknown 0)(defconstant $cmSpotFunctionDefault 1)(defconstant $cmSpotFunctionRound 2)(defconstant $cmSpotFunctionDiamond 3)(defconstant $cmSpotFunctionEllipse 4)(defconstant $cmSpotFunctionLine 5)(defconstant $cmSpotFunctionSquare 6)(defconstant $cmSpotFunctionCross 7);  Color Space Signatures (defconstant $cmXYZData :|XYZ |)(defconstant $cmLabData :|Lab |)(defconstant $cmLuvData :|Luv |)(defconstant $cmYxyData :|Yxy |)(defconstant $cmRGBData :|RGB |)(defconstant $cmGrayData :|GRAY|)(defconstant $cmHSVData :|HSV |)(defconstant $cmHLSData :|HLS |)(defconstant $cmCMYKData :|CMYK|)(defconstant $cmCMYData :|CMY |)(defconstant $cmMCH5Data :|MCH5|)(defconstant $cmMCH6Data :|MCH6|)(defconstant $cmMCH7Data :|MCH7|)(defconstant $cmMCH8Data :|MCH8|);  profileClass enumerations (defconstant $cmInputClass :|scnr|)(defconstant $cmDisplayClass :|mntr|)(defconstant $cmOutputClass :|prtr|)(defconstant $cmLinkClass :|link|)(defconstant $cmAbstractClass :|abst|)(defconstant $cmColorSpaceClass :|spac|);  platform enumerations (defconstant $cmMacintosh :|APPL|)(defconstant $cmMicrosoft :|MSFT|)(defconstant $cmSolaris :|SUNW|)(defconstant $cmSiliconGraphics :|SGI |)(defconstant $cmTaligent :|TGNT|);  ColorSync 1.0 elements (defconstant $cmCS1ChromTag :|chrm|)(defconstant $cmCS1TRCTag :|trc |)(defconstant $cmCS1NameTag :|name|)(defconstant $cmCS1CustTag :|cust|);  General element data types (defrecord CMDateTime    ;;Changing field year from signed-integer to unsigned-word to match C header (pretty-sure)   (year :unsigned-word)   ;;Changing field month from signed-integer to unsigned-word to match C header (pretty-sure)   (month :unsigned-word)   ;;Changing field dayofthemonth from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (dayOfTheMonth :unsigned-word)   ;;Changing field hours from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (hours :unsigned-word)   ;;Changing field minutes from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (minutes :unsigned-word)   ;;Changing field seconds from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (seconds :unsigned-word)   )(defrecord CMFixedXYZColor    (X :signed-long)   (Y :signed-long)   (Z :signed-long)   )(def-mactype :cmxyzcomponent (find-mactype ':signed-integer))(defrecord CMXYZColor    (X :signed-integer)   (Y :signed-integer)   (Z :signed-integer)   )(defrecord CM2Header    ;;Changing field size from signed-long to unsigned-long to match C header (pretty-sure)   (size :unsigned-long)                        ;  This is the total size of the Profile    (CMMType :ostype)                            ;  CMM signature,  Registered with CS2 consortium     ;;Changing field profileversion from signed-long to unsigned-long to match C header (pretty-darn-sure)   (profileVersion :unsigned-long)              ;  Version of CMProfile format    (profileClass :ostype)                       ;  input, display, output, devicelink, abstract, or color conversion profile type    (dataColorSpace :ostype)                     ;  color space of data    (profileConnectionSpace :ostype)             ;  profile connection color space    (dateTime :cmdatetime)                       ;  date and time of profile creation    (CS2profileSignature :ostype)                ;  'acsp' constant ColorSync 2.0 file ID    (platform :ostype)                           ;  primary profile platform, Registered with CS2 consortium    ;;Changing field flags from signed-long to unsigned-long to match C header (pretty-sure)   (flags :unsigned-long)                       ;  profile flags    (deviceManufacturer :ostype)                 ;  Registered with CS2 consortium    ;;Changing field devicemodel from signed-long to unsigned-long to match C header (pretty-sure)   (deviceModel :unsigned-long)                 ;  Registered with CS2 consortium    ;;Changing field deviceattributes from signed-long to unsigned-long to match C header (pretty-sure)   (deviceAttributes (:array :unsigned-long 2)) ;  Attributes like paper type    ;;Changing field renderingintent from signed-long to unsigned-long to match C header (pretty-darn-sure)   (renderingIntent :unsigned-long)             ;  preferred rendering intent of tagged object    (white :cmfixedxyzcolor)                     ;  profile illuminant    (reserved (:array :character 48))            ;  reserved for future use    )(defrecord CMTagRecord    (tag :ostype)                                ;  Registered with CS2 consortium    ;;Changing field elementoffset from signed-long to unsigned-long to match C header (pretty-darn-sure)   (elementOffset :unsigned-long)               ;  Relative to start of CMProfile    ;;Changing field elementsize from signed-long to unsigned-long to match C header (pretty-darn-sure)   (elementSize :unsigned-long)   )(defrecord CMTagElemTable    ;;Changing field count from signed-long to unsigned-long to match C header (pretty-sure)   (count :unsigned-long)   (tagList (:array :cmtagrecord 1))            ;  Variable size    );  External 0x02002001 CMProfile (defrecord CM2Profile    (header :cm2header)   (tagTable :cmtagelemtable)   (elemData (:array :character 1))             ;  Tagged element storage. Variable size    )(def-mactype :cm2profileptr (find-mactype '(:pointer :cm2profile)))(def-mactype :cm2profilehandle (find-mactype '(:handle :cm2profile)));  Tag Type Definitions (defrecord CMCurveType    (typeDescriptor :ostype)                     ;  'curv'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field countvalue from signed-long to unsigned-long to match C header (pretty-darn-sure)   (countValue :unsigned-long)                  ;  number of entries in table that follows    ;;Changing field data from signed-integer to unsigned-word to match C header (pretty-sure)   (data (:array :unsigned-word 1))             ;  Tagged element storage. Variable size    )(defrecord CMDataType    (typeDescriptor :ostype)                     ;  'data'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field dataflag from signed-long to unsigned-long to match C header (pretty-darn-sure)   (dataFlag :unsigned-long)                    ;  0 = ASCII, 1 = binary    (data (:array :character 1))                 ;  Tagged element storage. Variable size    )(defrecord CMDateTimeType    (typeDescriptor :ostype)                     ;  'dtim'    (reserved :signed-long)   (dateTime :cmdatetime)   )(defrecord CMLut16Type    (typeDescriptor :ostype)                     ;  'mft2'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field inputchannels from signed-byte to unsigned-byte to match C header (educated-guess)   (inputChannels :unsigned-byte)               ;  unsigned char ;  Number of input channels    ;;Changing field outputchannels from signed-byte to unsigned-byte to match C header (educated-guess)   (outputChannels :unsigned-byte)              ;  unsigned char ;  Number of output channels    ;;Changing field gridpoints from signed-byte to unsigned-byte to match C header (educated-guess)   (gridPoints :unsigned-byte)                  ;  unsigned char ;  Number of clutTable grid points    ;;Changing field reserved2 from signed-byte to unsigned-byte to match C header (educated-guess)   (reserved2 :unsigned-byte)                   ;  unsigned char ;  fill with 0x00    (matrix (:array :signed-long 3 3))           ;     ;;Changing field inputtableentries from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (inputTableEntries :unsigned-word)           ;     ;;Changing field outputtableentries from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (outputTableEntries :unsigned-word)          ;     ;;Changing field inputtable from signed-integer to unsigned-word to match C header (pretty-sure)   (inputTable (:array :unsigned-word 1))       ;  Variable size    ;;Changing field clut from signed-integer to unsigned-word to match C header (pretty-sure)   (CLUT (:array :unsigned-word 1))             ;  Variable size    ;;Changing field outputtable from signed-integer to unsigned-word to match C header (pretty-sure)   (outputTable (:array :unsigned-word 1))      ;  Variable size    )(defrecord CMLut8Type    (typeDescriptor :ostype)                     ;  'mft1'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field inputchannels from signed-byte to unsigned-byte to match C header (educated-guess)   (inputChannels :unsigned-byte)               ;  unsigned char ;     ;;Changing field outputchannels from signed-byte to unsigned-byte to match C header (educated-guess)   (outputChannels :unsigned-byte)              ;  unsigned char ;     ;;Changing field gridpoints from signed-byte to unsigned-byte to match C header (educated-guess)   (gridPoints :unsigned-byte)                  ;  unsigned char ;     ;;Changing field reserved2 from signed-byte to unsigned-byte to match C header (educated-guess)   (reserved2 :unsigned-byte)                   ;  unsigned char ;  fill with 0x00    (matrix (:array :signed-long 3 3))           ;     ;;Changing field inputtable from signed-byte to unsigned-byte to match C header (educated-guess)   (inputTable (:array :unsigned-byte 256))     ;  unsigned char ;  fixed size of 256    ;;Changing field clut from signed-byte to unsigned-byte to match C header (educated-guess)   (CLUT (:array :unsigned-byte 1))             ;  unsigned char ;  Variable size    ;;Changing field outputtable from signed-byte to unsigned-byte to match C header (educated-guess)   (outputTable (:array :unsigned-byte 256))    ;  unsigned char ;  fixed size of 256    )(defrecord CMMeasurementType    (typeDescriptor :ostype)                     ;  'meas'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field standardobserver from signed-long to unsigned-long to match C header (pretty-darn-sure)   (standardObserver :unsigned-long)            ;  0 : unknown, 1 : CIE 1931, 2 : CIE 1964    (backingXYZ :cmfixedxyzcolor)                ;  absolute XYZ values of backing    ;;Changing field geometry from signed-long to unsigned-long to match C header (pretty-darn-sure)   (geometry :unsigned-long)                    ;  0 : unknown, 1 : 0/45 or 45/0, 2 :0/d or d/0    ;;Changing field flare from signed-long to unsigned-long to match C header (pretty-darn-sure)   (flare :unsigned-long)                       ;  0 : 0%, 1 : 100% flare    ;;Changing field illuminant from signed-long to unsigned-long to match C header (pretty-darn-sure)   (illuminant :unsigned-long)                  ;  standard illuminant    )(defrecord CMNamedColorType    (typeDescriptor :ostype)                     ;  'ncol'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field vendorflag from signed-long to unsigned-long to match C header (pretty-darn-sure)   (vendorFlag :unsigned-long)                  ;     ;;Changing field count from signed-long to unsigned-long to match C header (pretty-sure)   (count :unsigned-long)                       ;  count of named colors in array that follows    ;;Changing field prefixname from signed-byte to unsigned-byte to match C header (educated-guess)   (prefixName (:array :unsigned-byte 1))       ;  unsigned char ;  Variable size, max = 32, to access fields after this one, have to count bytes    ;;Changing field suffixname from signed-byte to unsigned-byte to match C header (educated-guess)   (suffixName (:array :unsigned-byte 1))       ;  unsigned char ;  Variable size, max = 32 ; Warning: Field colorname is a recursive record   (colorName (defrecord colorName      ;;Changing field rootname from signed-byte to unsigned-byte to match C header (educated-guess)      (rootName (:array :unsigned-byte 1))      ;  unsigned char ;  Variable size, max = 32       ;;Changing field colorcoords from signed-byte to unsigned-byte to match C header (educated-guess)      (colorCoords (:array :unsigned-byte 1))   ;  unsigned char ;  Variable size        )   );  Variable size     )(defrecord CMTextDescriptionType    (typeDescriptor :ostype)                     ;  'desc'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field asciicount from signed-long to unsigned-long to match C header (pretty-darn-sure)   (ASCIICount :unsigned-long)                  ;  the count of "bytes"    ;;Changing field asciiname from signed-byte to unsigned-byte to match C header (educated-guess)   (ASCIIName (:array :unsigned-byte 2))        ;  unsigned char ;  Variable size, to access fields after this one, have to count bytes    ;;Changing field unicodecode from signed-long to unsigned-long to match C header (pretty-darn-sure)   (UniCodeCode :unsigned-long)   ;;Changing field unicodecount from signed-long to unsigned-long to match C header (pretty-darn-sure)   (UniCodeCount :unsigned-long)                ;  the count of characters, each character has two bytes    ;;Changing field unicodename from signed-byte to unsigned-byte to match C header (educated-guess)   (UniCodeName (:array :unsigned-byte 2))      ;  unsigned char ;  Variable size    (ScriptCodeCode :signed-integer)   ;;Changing field scriptcodecount from signed-byte to unsigned-byte to match C header (educated-guess)   (ScriptCodeCount :unsigned-byte)             ;  unsigned char ;  the count of "bytes"    ;;Changing field scriptcodename from signed-byte to unsigned-byte to match C header (educated-guess)   (ScriptCodeName (:array :unsigned-byte 2))   ;  unsigned char ;  Variable size    )(defrecord CMTextType    (typeDescriptor :ostype)                     ;  'text'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field text from signed-byte to unsigned-byte to match C header (educated-guess)   (text (:array :unsigned-byte 1))             ;  unsigned char ;  count of text is obtained from tag size element    )(defrecord CMScreeningType    (typeDescriptor :ostype)                     ;  'scrn'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field screeningflag from signed-long to unsigned-long to match C header (pretty-darn-sure)   (screeningFlag :unsigned-long)               ;  bit 0 : use printer default screens, bit 1 : inch/cm    ;;Changing field channelcount from signed-long to unsigned-long to match C header (pretty-darn-sure)   (channelCount :unsigned-long); Warning: Field channelscreening is a recursive record   (channelScreening (defrecord channelScreening      (frequency :signed-long)      (angle :signed-long)      ;;Changing field sportfunction from signed-long to unsigned-long to match C header (pretty-darn-sure)      (sportFunction :unsigned-long)      )   );  Variable size    )(defrecord CMSignatureType    (typeDescriptor :ostype)                     ;  'sig '    (reserved :signed-long)                      ;  fill with 0x00    (signature :ostype)   )(defrecord CMS15Fixed16ArrayType    (typeDescriptor :ostype)                     ;  'sf32'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field value from signed-long to unsigned-long to match C header (pretty-sure)   (value (:array :unsigned-long 1))            ;  Variable size    )(defrecord CMU16Fixed16ArrayType    (typeDescriptor :ostype)                     ;  'uf32'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field value from signed-long to unsigned-long to match C header (pretty-sure)   (value (:array :unsigned-long 1))            ;  Variable size    )(defrecord CMUInt16ArrayType    (typeDescriptor :ostype)                     ;  'ui16'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field value from signed-integer to unsigned-word to match C header (pretty-sure)   (value (:array :unsigned-word 1))            ;  Variable size    )(defrecord CMUInt32ArrayType    (typeDescriptor :ostype)                     ;  'ui32'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field value from signed-long to unsigned-long to match C header (pretty-sure)   (value (:array :unsigned-long 1))            ;  Variable size    )(defrecord CMUInt64ArrayType    (typeDescriptor :ostype)                     ;  'ui64'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field value from signed-long to unsigned-long to match C header (pretty-sure)   (value (:array :unsigned-long 1))            ;  Variable size (x2)    )(defrecord CMUInt8ArrayType    (typeDescriptor :ostype)                     ;  'ui08'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field value from signed-byte to unsigned-byte to match C header (educated-guess)   (value (:array :unsigned-byte 1))            ;  unsigned char ;  Variable size    )(defrecord CMViewingConditionsType    (typeDescriptor :ostype)                     ;  'view'    (reserved :signed-long)                      ;  fill with 0x00    (illuminant :cmfixedxyzcolor)                ;  absolute XYZs of illuminant  in cd/m^2    (surround :cmfixedxyzcolor)                  ;  absolute XYZs of surround in cd/m^2    ;;Changing field stdilluminant from signed-long to unsigned-long to match C header (pretty-darn-sure)   (stdIlluminant :unsigned-long)               ;  see definitions of std illuminants    )(defrecord CMXYZType    (typeDescriptor :ostype)                     ;  'XYZ '    (reserved :signed-long)                      ;  fill with 0x00    (XYZ (:array :cmfixedxyzcolor 1))            ;  variable size XYZ tristimulus values    );  Profile sequence description type (defrecord CMProfileSequenceDescType    (typeDescriptor :ostype)                     ;  'pseq '    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field count from signed-long to unsigned-long to match C header (pretty-sure)   (count :unsigned-long)                       ;  Number of descriptions; 														 * variable size fields to follow, to access them, must count bytes ; Warning: Field profiledescription is a recursive record   (profileDescription (defrecord profileDescription      (deviceMfg :ostype)                       ;  Device Manufacturer       (deviceModel :ostype)                     ;  Decvice Model       ;;Changing field attributes from signed-long to unsigned-long to match C header (pretty-darn-sure)      (attributes (:array :unsigned-long 2))    ;  Device attributes       (technology :ostype)                      ;  Technology signature       ;;Changing field mfgdescasciicount from signed-long to unsigned-long to match C header (pretty-darn-sure)      (mfgDescASCIICount :unsigned-long)        ;  the count of "bytes"       ;;Changing field mfgdescasciiname from signed-byte to unsigned-byte to match C header (educated-guess)      (mfgDescASCIIName (:array :unsigned-byte 2));  unsigned char ;  Variable size       ;;Changing field mfgdescunicodecode from signed-long to unsigned-long to match C header (pretty-darn-sure)      (mfgDescUniCodeCode :unsigned-long)      ;;Changing field mfgdescunicodecount from signed-long to unsigned-long to match C header (pretty-darn-sure)      (mfgDescUniCodeCount :unsigned-long)      ;  the count of characters, each character has two bytes       ;;Changing field mfgdescunicodename from signed-byte to unsigned-byte to match C header (educated-guess)      (mfgDescUniCodeName (:array :unsigned-byte 2));  unsigned char ;  Variable size       ;;Changing field mfgdescscriptcodecode from signed-long to unsigned-long to match C header (pretty-darn-sure)      (mfgDescScriptCodeCode :unsigned-long)      ;;Changing field mfgdescscriptcodecount from signed-long to unsigned-long to match C header (pretty-darn-sure)      (mfgDescScriptCodeCount :unsigned-long)   ;  the count of "bytes"       ;;Changing field mfgdescscriptcodename from signed-byte to unsigned-byte to match C header (educated-guess)      (mfgDescScriptCodeName (:array :unsigned-byte 2));  unsigned char ;  Variable size       ;;Changing field modeldescasciicount from signed-long to unsigned-long to match C header (pretty-darn-sure)      (modelDescASCIICount :unsigned-long)      ;  the count of "bytes"       ;;Changing field modeldescasciiname from signed-byte to unsigned-byte to match C header (educated-guess)      (modelDescASCIIName (:array :unsigned-byte 2));  unsigned char ;  Variable size       ;;Changing field modeldescunicodecode from signed-long to unsigned-long to match C header (pretty-darn-sure)      (modelDescUniCodeCode :unsigned-long)      ;;Changing field modeldescunicodecount from signed-long to unsigned-long to match C header (pretty-darn-sure)      (modelDescUniCodeCount :unsigned-long)    ;  the count of characters, each character has two bytes       ;;Changing field modeldescunicodename from signed-byte to unsigned-byte to match C header (educated-guess)      (modelDescUniCodeName (:array :unsigned-byte 2));  unsigned char ;  Variable size       (modelDescScriptCodeCode :signed-integer)      ;;Changing field modeldescscriptcodecount from signed-byte to unsigned-byte to match C header (educated-guess)      (modelDescScriptCodeCount :unsigned-byte) ;  unsigned char ;  the count of "bytes"       ;;Changing field modeldescscriptcodename from signed-byte to unsigned-byte to match C header (educated-guess)      (modelDescScriptCodeName (:array :unsigned-byte 2));  unsigned char ;  Variable size       )   )   );  Under color removal, black generation type (defrecord CMUcrBgType    (typeDescriptor :ostype)                     ;  'bfd  '    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field ucrcount from signed-long to unsigned-long to match C header (pretty-darn-sure)   (ucrCount :unsigned-long)                    ;  Number of UCR entries    ;;Changing field ucrvalues from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (ucrValues (:array :unsigned-word 1))        ;  variable size    ;;Changing field bgcount from signed-long to unsigned-long to match C header (pretty-darn-sure)   (bgCount :unsigned-long)                     ;  Number of BG entries    ;;Changing field bgvalues from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (bgValues (:array :unsigned-word 1))         ;  variable size    ;;Changing field ucrbgascii from signed-byte to unsigned-byte to match C header (educated-guess)   (ucrbgASCII (:array :unsigned-byte 1))       ;  unsigned char ;  null terminated ASCII string    )(defrecord CMIntentCRDVMSize    ;;Changing field renderingintent from signed-long to unsigned-long to match C header (pretty-darn-sure)   (renderingIntent :unsigned-long)             ;  rendering intent    ;;Changing field vmsize from signed-long to unsigned-long to match C header (pretty-darn-sure)   (VMSize :unsigned-long)                      ;  VM size taken up by the CRD    )(defrecord CMPS2CRDVMSizeType    (typeDescriptor :ostype)                     ;  'psvm'    (reserved :signed-long)                      ;  fill with 0x00    ;;Changing field count from signed-long to unsigned-long to match C header (pretty-sure)   (count :unsigned-long)                       ;  number of intent entries    (intentCRD (:array :cmintentcrdvmsize 1))    ;  variable size    ); **********************************************************************; ************** ColorSync 1.0 profile specification *******************; **********************************************************************(defconstant $cmGrayResponse 0)(defconstant $cmRedResponse 1)(defconstant $cmGreenResponse 2)(defconstant $cmBlueResponse 3)(defconstant $cmCyanResponse 4)(defconstant $cmMagentaResponse 5)(defconstant $cmYellowResponse 6)(defconstant $cmUcrResponse 7)(defconstant $cmBgResponse 8)(defconstant $cmOnePlusLastResponse 9);  Device types (defconstant $cmMonitorDevice :|mntr|)(defconstant $cmScannerDevice :|scnr|)(defconstant $cmPrinterDevice :|prtr|)(defrecord CMIString    (theScript :signed-integer)   (theString (:string 63))   );  Profile options (defconstant $cmPerceptualMatch #x0)            ;  Default. For photographic images (defconstant $cmColorimetricMatch #x1)          ;  Exact matching when possible (defconstant $cmSaturationMatch #x2)            ;  For solid colors ;  Profile flags (defconstant $cmNativeMatchingPreferred #x1)    ;  Default to native not preferred (defconstant $cmTurnOffCache #x2)               ;  Default to turn on CMM cache (def-mactype :cmmatchoption (find-mactype ':signed-long))(def-mactype :cmmatchflag (find-mactype ':signed-long))(defrecord CMHeader    ;;Changing field size from signed-long to unsigned-long to match C header (pretty-sure)   (size :unsigned-long)   (CMMType :ostype)   ;;Changing field applprofileversion from signed-long to unsigned-long to match C header (pretty-darn-sure)   (applProfileVersion :unsigned-long)   (dataType :ostype)   (deviceType :ostype)   (deviceManufacturer :ostype)   ;;Changing field devicemodel from signed-long to unsigned-long to match C header (pretty-sure)   (deviceModel :unsigned-long)   ;;Changing field deviceattributes from signed-long to unsigned-long to match C header (pretty-sure)   (deviceAttributes (:array :unsigned-long 2))   ;;Changing field profilenameoffset from signed-long to unsigned-long to match C header (pretty-darn-sure)   (profileNameOffset :unsigned-long)   ;;Changing field customdataoffset from signed-long to unsigned-long to match C header (pretty-darn-sure)   (customDataOffset :unsigned-long)   ;;Changing field flags from signed-long to unsigned-long to match C header (pretty-sure)   (flags :unsigned-long)   (options :signed-long)   (white :cmxyzcolor)   (black :cmxyzcolor)   )(defrecord CMProfileChromaticities    (red :cmxyzcolor)   (green :cmxyzcolor)   (blue :cmxyzcolor)   (cyan :cmxyzcolor)   (magenta :cmxyzcolor)   (yellow :cmxyzcolor)   )(defrecord CMProfileResponse    ;;Changing field counts from signed-integer to unsigned-word to match C header (pretty-darn-sure)   (counts (:array :unsigned-word (- (- #$cmOnePlusLastResponse 1) 0 -1)))   ;;Changing field data from signed-integer to unsigned-word to match C header (pretty-sure)   (data (:array :unsigned-word 1))             ;  Variable size    )(defrecord CMProfile    (header :cmheader)   (profile :cmprofilechromaticities)   (response :cmprofileresponse)   (profileName :cmistring)   (customData (:array :character 1))           ;  Variable size    )(def-mactype :cmprofileptr (find-mactype '(:pointer :cmprofile)))(def-mactype :cmprofilehandle (find-mactype '(:handle :cmprofile))); $IFC OLDROUTINENAMES (defconstant $kCMApplProfileVersion #$cmCS1ProfileVersion)(defconstant $grayResponse #$cmGrayResponse)(defconstant $redResponse #$cmRedResponse)(defconstant $greenResponse #$cmGreenResponse)(defconstant $blueResponse #$cmBlueResponse)(defconstant $cyanResponse #$cmCyanResponse)(defconstant $magentaResponse #$cmMagentaResponse)(defconstant $yellowResponse #$cmYellowResponse)(defconstant $ucrResponse #$cmUcrResponse)(defconstant $bgResponse #$cmBgResponse)(defconstant $onePlusLastResponse #$cmOnePlusLastResponse)(defconstant $rgbData #$cmRGBData)(defconstant $cmykData #$cmCMYKData)(defconstant $grayData #$cmGrayData)(defconstant $xyzData #$cmXYZData)(defconstant $monitorDevice #$cmMonitorDevice)(defconstant $scannerDevice #$cmScannerDevice)(defconstant $printerDevice #$cmPrinterDevice)(def-mactype :xyzcomponent (find-mactype ':signed-integer))(%define-record :xyzcolor (find-record-descriptor :cmxyzcolor))(def-mactype :cmresponsedata (find-mactype ':signed-integer))(%define-record :istring (find-record-descriptor :cmistring))(def-mactype :cmresponsecolor (find-mactype ':signed-long))(def-mactype :responsecolor (find-mactype ':signed-long)); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := CMICCProfileIncludes; $ENDC                                         ; __CMICCPROFILE__#|                                              ; $IFC NOT UsingIncludes |#                                             ; $ENDC(provide-interface 'CMICCProfile)
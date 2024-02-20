(in-package :TRAPS); Generated from #P"Cohones:Lisp:Projects:PInterface Translator:Source interfaces:Quicktime 2.5 PInterfaces:MediaHandlers.p"; at Thursday May 23,1996 2:22:46 pm.; ;  	File:		MediaHandlers.p;  ;  	Contains:	QuickTime interfaces;  ;  	Version:	Technology:	;  				Release:	QuickTime 2.5 interfaces to use with ETO #20;  ;  	Copyright:	� 1984-1996 by Apple Computer, Inc.  All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, send the file and version;  				information (from above) and the problem description to:;  ;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __MEDIAHANDLERS__; $SETC __MEDIAHANDLERS__ := 1; $I+; $SETC MediaHandlersIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __MEMORY__|#(require-interface 'Memory)#|                                              ; $I Memory.p |#                                             ; $ENDC; $IFC UNDEFINED __IMAGECOMPRESSION__(require-interface 'ImageCompression)           ; $I ImageCompression.p; $ENDC; $IFC UNDEFINED __MOVIES__(require-interface 'Movies)                     ; $I Movies.p; $ENDC; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $handlerHasSpatial #x1)(defconstant $handlerCanClip #x2)(defconstant $handlerCanMatte #x4)(defconstant $handlerCanTransferMode #x8)(defconstant $handlerNeedsBuffer #x10)(defconstant $handlerNoIdle #x20)(defconstant $handlerNoScheduler #x40)(defconstant $handlerWantsTime #x80)(defconstant $handlerCGrafPortOnly #x100)(defconstant $handlerCanSend #x200);   media task flags  (defconstant $mMustDraw #x8)(defconstant $mAtEnd #x10)(defconstant $mPreflightDraw #x20)(defconstant $mSyncDrawing #x40);   media task result flags  (defconstant $mDidDraw #x1)(defconstant $mNeedsToDraw #x4)(defconstant $mDrawAgain #x8)(defconstant $mPartialDraw #x10)(defconstant $forceUpdateRedraw #x1)(defconstant $forceUpdateNewBuffer #x2)(def-mactype :getmoviecompleteparamsptr (find-mactype '(:pointer :getmoviecompleteparams)))(defrecord GetMovieCompleteParams    (version :signed-integer)   (theMovie (:pointer :movierecord))   (theTrack (:pointer :trackrecord))   (theMedia (:pointer :mediarecord))   (movieScale :signed-long)   (mediaScale :signed-long)   (movieDuration :signed-long)   (trackDuration :signed-long)   (mediaDuration :signed-long)   (effectiveRate :signed-long)   (TimeBase (:pointer :timebaserecord))   (volume :signed-integer)   (width :signed-long)   (height :signed-long)   (trackMovieMatrix :matrixrecord)   (moviePort (:pointer :cgrafport))   (movieGD (:handle :gdevice))   (trackMatte (:handle :pixmap))   (inputMap :handle)   )(defconstant $kMediaVideoParamBrightness 1)(defconstant $kMediaVideoParamContrast 2)(defconstant $kMediaVideoParamHue 3)(defconstant $kMediaVideoParamSharpness 4)(defconstant $kMediaVideoParamSaturation 5)(defconstant $kMediaVideoParamBlackLevel 6)(defconstant $kMediaVideoParamWhiteLevel 7)(def-mactype :datahandleptr (find-mactype '(:pointer :handle)))(def-mactype :datahandlehandle (find-mactype '(:handle :handle)));   MediaCallRange2  ;   These are unique to each type of media handler  ;   They are also included in the public interfaces  ;  **** These are the calls for dealing with the Generic media handler **** ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaInitialize" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (gmc (:pointer :getmoviecompleteparams)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh gmc ((+ (ash 4 16) 1281) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetHandlerCapabilities" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (flags :signed-long) (flagsMask :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh flags flagsMask ((+ (ash 8 16) 1282) :signed-longint))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaIdle" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (atMediaTime :signed-long) (flagsIn :signed-long) (flagsOut (:pointer :signed-long)) (movieTime (:pointer :timerecord)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh atMediaTime flagsIn flagsOut movieTime ((+ (ash 16 16) 1283) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetMediaInfo" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (h :handle))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh h ((+ (ash 4 16) 1284) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaPutMediaInfo" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (h :handle))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh h ((+ (ash 4 16) 1285) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetActive" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (enableMedia :boolean))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh enableMedia ((+ (ash 2 16) 1286) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetRate" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (rate :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh rate ((+ (ash 4 16) 1287) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGGetStatus" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (statusErr (:pointer :signed-long)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh statusErr ((+ (ash 4 16) 1288) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaTrackEdited" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh ((+ (ash 0 16) 1289) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetMediaTimeScale" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (newTimeScale :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh newTimeScale ((+ (ash 4 16) 1290) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetMovieTimeScale" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (newTimeScale :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh newTimeScale ((+ (ash 4 16) 1291) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetGWorld" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (aPort (:pointer :cgrafport)) (aGD (:handle :gdevice)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh aPort aGD ((+ (ash 8 16) 1292) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetDimensions" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (width :signed-long) (height :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh width height ((+ (ash 8 16) 1293) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetClip" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (theClip (:handle :region)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh theClip ((+ (ash 4 16) 1294) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetMatrix" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (trackMovieMatrix (:pointer :matrixrecord)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh trackMovieMatrix ((+ (ash 4 16) 1295) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetTrackOpaque" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (trackIsOpaque (:pointer :boolean)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh trackIsOpaque ((+ (ash 4 16) 1296) :signed-longint))); $ENDC; CONST                                         ; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetGraphicsMode" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (mode :signed-long) (opColor (:pointer :rgbcolor)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh mode opColor ((+ (ash 8 16) 1297) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetGraphicsMode" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (mode (:pointer :signed-long)) (opColor (:pointer :rgbcolor)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh mode opColor ((+ (ash 8 16) 1298) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGSetVolume" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (volume :signed-integer))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh volume ((+ (ash 2 16) 1299) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetSoundBalance" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (balance :signed-integer))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh balance ((+ (ash 2 16) 1300) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetSoundBalance" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (balance (:pointer :signed-integer)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh balance ((+ (ash 4 16) 1301) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetNextBoundsChange" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (when (:pointer :signed-long)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh when ((+ (ash 4 16) 1302) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetSrcRgn" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (rgn (:handle :region)) (atMediaTime :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh rgn atMediaTime ((+ (ash 8 16) 1303) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaPreroll" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (time :signed-long) (rate :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh time rate ((+ (ash 8 16) 1304) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSampleDescriptionChanged" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (index :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh index ((+ (ash 4 16) 1305) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaHasCharacteristic" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (characteristic :ostype) (hasIt (:pointer :boolean)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh characteristic hasIt ((+ (ash 8 16) 1306) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetOffscreenBufferSize" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (bounds (:pointer :rect)) (depth :signed-integer) (ctab (:handle :colortable)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh bounds depth ctab ((+ (ash 10 16) 1307) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetHints" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (hints :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh hints ((+ (ash 4 16) 1308) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetName" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (name (:pointer (:string 255))) (requestedLanguage :signed-long) (actualLanguage (:pointer :signed-long)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh name requestedLanguage actualLanguage ((+ (ash 12 16) 1309) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaForceUpdate" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (forceUpdateFlags :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh forceUpdateFlags ((+ (ash 4 16) 1310) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetDrawingRgn" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (partialRgn (:pointer (:handle :region))))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh partialRgn ((+ (ash 4 16) 1311) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGSetActiveSegment" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (activeStart :signed-long) (activeDuration :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh activeStart activeDuration ((+ (ash 8 16) 1312) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaInvalidateRegion" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (invalRgn (:handle :region)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh invalRgn ((+ (ash 4 16) 1313) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetNextStepTime" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (flags :signed-integer) (mediaTimeIn :signed-long) (mediaTimeOut (:pointer :signed-long)) (rate :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh flags mediaTimeIn mediaTimeOut rate ((+ (ash 14 16) 1314) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetNonPrimarySourceData" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (inputIndex :signed-long) (dataDescriptionSeed :signed-long) (dataDescription :handle) (data :pointer) (dataSize :signed-long) (asyncCompletionProc (:pointer :icmcompletionprocrecord)) (transferProc :pointer) (refCon :pointer))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh inputIndex dataDescriptionSeed dataDescription data dataSize asyncCompletionProc transferProc refCon ((+ (ash 32 16) 1315) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaChangedNonPrimarySource" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (inputIndex :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh inputIndex ((+ (ash 4 16) 1316) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaTrackReferencesChanged" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh ((+ (ash 0 16) 1317) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetSampleDataPointer" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (sampleNum :signed-long) (dataPtr (:pointer :pointer)) (dataSize (:pointer :signed-long)) (sampleDescIndex (:pointer :signed-long)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh sampleNum dataPtr dataSize sampleDescIndex ((+ (ash 16 16) 1318) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaReleaseSampleDataPointer" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (sampleNum :signed-long))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh sampleNum ((+ (ash 4 16) 1319) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaTrackPropertyAtomChanged" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh ((+ (ash 0 16) 1320) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetTrackInputMapReference" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (inputMap :handle))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh inputMap ((+ (ash 4 16) 1321) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaSetVideoParam" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (whichParam :signed-long) (value (:pointer :signed-integer)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh whichParam value ((+ (ash 8 16) 1323) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetVideoParam" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (whichParam :signed-long) (value (:pointer :signed-integer)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh whichParam value ((+ (ash 8 16) 1324) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaCompare" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (isOK (:pointer :boolean)) (srcMedia (:pointer :mediarecord)) (srcMediaComponent (:pointer :componentinstancerecord)))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh isOK srcMedia srcMediaComponent ((+ (ash 12 16) 1325) :signed-longint))); $ENDC; $IFC NOT GENERATINGCFM;; Generated by translator push-a-constant-longword-on-stack(deftrap ("_MediaGetClock" ("QuickTimeLib")) ((mh (:pointer :componentinstancerecord)) (clock (:pointer (:pointer :componentinstancerecord))))   (:stack :signed-long)   (:stack-trap #xA82A :d0 0 mh clock ((+ (ash 4 16) 1326) :signed-longint))); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := MediaHandlersIncludes; $ENDC                                         ; __MEDIAHANDLERS__; $IFC NOT UsingIncludes; $ENDC(provide-interface 'MediaHandlers)
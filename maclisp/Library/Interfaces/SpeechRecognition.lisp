(in-package :TRAPS)             ; ;  	File:		SpeechRecognition.p;  ;  	Contains:	Apple Speech Recognition Toolbox Interfaces.;  ;  	Version:	Technology:	PlainTalk 1.5;  ;  				Release:	PlainTalk Developer Release;  ;  	Copyright:	� 1984-1996 by Apple Computer, Inc.;  ;  				All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, send the file and version;  				information (from above) and the problem description to:;  ;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __SPEECHRECOGNITION__; $SETC __SPEECHRECOGNITION__ := 1; $I+; $SETC SpeechRecognitionIncludes := UsingIncludes; $SETC UsingIncludes := 1; $IFC UNDEFINED __MEMORY__; $I Memory.p; $ENDC; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $gestaltSpeechRecognitionVersion :|srtb|)(defconstant $gestaltSpeechRecognitionAttr :|srta|)(defconstant $gestaltDesktopSpeechRecognition #X1)(defconstant $gestaltTelephoneSpeechRecognition #X2);   Error Codes [Speech recognition gets -5100 through -5199]  (defconstant $kSRNotAvailable -5100);   the service requested is not avail or applicable  (defconstant $kSRInternalError -5101);   a system internal or hardware error condition  (defconstant $kSRComponentNotFound -5102);   a needed system resource was not located  (defconstant $kSROutOfMemory -5103);   an out of memory error occurred in the toolbox memory space  (defconstant $kSRNotASpeechObject -5104);   the object specified is no longer or never was valid  (defconstant $kSRBadParameter -5105);   an invalid parameter was specified  (defconstant $kSRParamOutOfRange -5106);   when we say 0-100, don't pass in 101.  (defconstant $kSRBadSelector -5107);   an unrecognized selector was specified  (defconstant $kSRBufferTooSmall -5108);   returned from attribute access functions  (defconstant $kSRNotARecSystem -5109);   the object used was not a SRRecognitionSystem  (defconstant $kSRFeedbackNotAvail -5110);   there is no feedback window associated with SRRecognizer  (defconstant $kSRCantSetProperty -5111);   a non-settable property was specified  (defconstant $kSRCantGetProperty -5112);   a non-gettable property was specified  (defconstant $kSRCantSetDuringRecognition -5113);   the property can't be set while recognition is in progress -- do before or between utterances.  (defconstant $kSRAlreadyListening -5114);   in response to SRStartListening  (defconstant $kSRNotListeningState -5115);   in response to SRStopListening  (defconstant $kSRModelMismatch -5116);   no acoustical models are avail to match request  (defconstant $kSRNoClientLanguageModel -5117);   trying to access a non-specified SRLanguageModel  (defconstant $kSRNoPendingUtterances -5118);   nothing to continue search on  (defconstant $kSRRecognitionCanceled -5119);   an abort error occurred during search  (defconstant $kSRRecognitionDone -5120);   search has finished, but nothing was recognized  (defconstant $kSROtherRecAlreadyModal -5121);   another recognizer is modal at the moment, so can't set this recognizer's kSRBlockModally property right now  (defconstant $kSRHasNoSubItems -5122);   SRCountItems or related routine was called on an object without subelements -- e.g. a word -- rather than phrase, path, or LM.  (defconstant $kSRSubItemNotFound -5123);   returned when accessing a non-existent sub item of a container  (defconstant $kSRLanguageModelTooBig -5124);   Cant build language models so big  (defconstant $kSRAlreadyReleased -5125);   this object has already been released before  (defconstant $kSRAlreadyFinished -5126);   the language model can't be finished twice  (defconstant $kSRWordNotFound -5127);   the spelling couldn't be found in lookup(s)  (defconstant $kSRNotFinishedWithRejection -5128);   property not found because the LMObj is not finished with rejection  (defconstant $kSRExpansionTooDeep -5129);   Language model is left recursive or is embedded too many levels  (defconstant $kSRTooManyElements -5130);   Too many elements added to phrase or path or other langauge model object  (defconstant $kSRCantAdd -5131) ;   Can't add given type of object to the base SRLanguageObject (e.g.in SRAddLanguageObject)	 (defconstant $kSRSndInSourceDisconnected -5132);   Sound input source is disconnected  (defconstant $kSRCantReadLanguageObject -5133);   An error while trying to create new Language object from file or pointer -- possibly bad format  ;   non-release debugging error codes are included here  (defconstant $kSRNotImplementedYet -5199);   you'd better wait for this feature in a future release  ;   Type Definitions  (def-mactype :SRSPEECHOBJECT (find-mactype :POINTER))(def-mactype :SRRECOGNITIONSYSTEM (find-mactype :POINTER))(def-mactype :SRRECOGNIZER (find-mactype :POINTER))(def-mactype :SRSPEECHSOURCE (find-mactype :POINTER))(def-mactype :SRRECOGNITIONRESULT (find-mactype :POINTER))(def-mactype :SRLANGUAGEOBJECT (find-mactype :POINTER))(def-mactype :SRLANGUAGEMODEL (find-mactype :POINTER))(def-mactype :SRPATH (find-mactype :POINTER))(def-mactype :SRPHRASE (find-mactype :POINTER))(def-mactype :SRWORD (find-mactype :POINTER))(def-mactype :SRLANGUAGEOBJECTFLAGS (find-mactype :SIGNED-LONG));   between 0 and 100  (def-mactype :SRSPEEDSETTING (find-mactype :SIGNED-INTEGER));   between 0 and 100  (def-mactype :SRREJECTIONLEVEL (find-mactype :SIGNED-INTEGER));   When an event occurs, the user supplied proc will be called with a pointer	 ;  	to the param passed in and a flag to indicate conditions such				 ;  	as interrupt time or system background time.								 (def-mactype :SRCALLBACKSTRUCTPTR (find-mactype :POINTER))(defrecord SRCallBackStruct    (what :SIGNED-LONG)          ;   one of notification flags     (message :SIGNED-LONG)       ;   contains SRRecognitionResult id     (instance (:POINTER :SIGNED-LONG));   ID of recognizer being notified     (status :SIGNED-INTEGER)     ;   result status of last search     (flags :SIGNED-INTEGER)      ;   non-zero if occurs during interrupt     (refCon :SIGNED-LONG)        ;   user defined - set from SRCallBackParam     );   Call back procedure definition  (def-mactype :SRCALLBACKPROCPTR (find-mactype :POINTER));  PROCEDURE SRCallBack(VAR param: SRCallBackStruct); (def-mactype :SRCALLBACKUPP (find-mactype :UNIVERSALPROCPTR))(defconstant $uppSRCallBackProcInfo #XC0)(deftrap _newsrcallbackproc ((userroutine :pointer))   (:stack :universalprocptr)   (:stack-trap #x2E9F)); $ENDC#| Not in ROM - INLINE =  #x205F #x4E90(deftrap _callsrcallbackproc ((param (:pointer :srcallbackstruct)) (userroutine :universalprocptr))   nil   (:stack-trap #x0))|#; $ENDC(def-mactype :SRCALLBACKPARAMPTR (find-mactype :POINTER))(defrecord SRCallBackParam    (callBack :UNIVERSALPROCPTR)   (refCon :SIGNED-LONG)   );   Recognition System Types  (defconstant $kSRDefaultRecognitionSystemID 0);   Recognition System Properties  (defconstant $kSRRejectedWord :|rejq|);   the SRWord used to represent a rejection  (defconstant $kSRSeparationChars :|spch|);   separation chars for current dialect setting -- use pointer to SeparationChars struct, defined in Dialect.h  (defconstant $kSRCleanupOnClientExit :|clup|);   Boolean: Default is true. The rec system and everything it owns is disposed when the client application quits  (defconstant $kSRFeedbackAndListeningModes :|fbwn|);   short: one of kSRNoFeedbackHasListenModes, kSRHasFeedbackHasListenModes, kSRNoFeedbackNoListenModes  (defconstant $kSRNoFeedbackNoListenModes 0);   next allocated recognizer has no feedback window and doesn't use listening modes	 (defconstant $kSRHasFeedbackHasListenModes 1);   next allocated recognizer has feedback window and uses listening modes 			 (defconstant $kSRNoFeedbackHasListenModes 2);   next allocated recognizer has no feedback window but does use listening modes 	 ;   Speech Source Types  (defconstant $kSRDefaultSpeechSource 0)(defconstant $kSRLiveDesktopSpeechSource :|dklv|);   live desktop sound input  (defconstant $kSRCanned22kHzSpeechSource :|ca22|);   AIFF file based 16 bit, 22.050 KHz sound input  ;   Notification via Apple Event or Callback  ;   Notification Flags  (defconstant $kSRNotifyRecognitionBeginning #X1);   recognition can begin. client must now call SRContinueRecognition or SRCancelRecognition  (defconstant $kSRNotifyRecognitionDone #X2);   recognition has terminated. result (if any) is available.  ;   Apple Event selectors  ;   AppleEvent message class   (defconstant $kAESpeechSuite :|sprc|);   AppleEvent message event ids  (defconstant $kAESpeechDone :|srsd|)(defconstant $kAESpeechDetected :|srbd|);   AppleEvent Parameter ids  (defconstant $keySRRecognizer :|krec|)(defconstant $keySRSpeechResult :|kspr|)(defconstant $keySRSpeechStatus :|ksst|);   AppleEvent Parameter types  (defconstant $typeSRRecognizer :|trec|)(defconstant $typeSRSpeechResult :|tspr|);   SRRecognizer Properties  (defconstant $kSRSearchStatusParam :|stat|);   see status flags below  (defconstant $kSRNotificationParam :|noti|);   see notification flags below  (defconstant $kSRCallBackParam :|call|);   type SRCallBackParam  (defconstant $kSRAutoFinishingParam :|afin|);   automatic finishing applied on LM for search  (defconstant $kSRForegroundOnly :|fgon|);   Boolean. Default is true. If true, client recognizer only active when in foreground.	 (defconstant $kSRBlockBackground :|blbg|);   Boolean. Default is false. If true, when client recognizer in foreground, rest of LMs are inactive.	 (defconstant $kSRBlockModally :|blmd|);   Boolean. Default is false. When true, this client's LM is only active LM; all other LMs are inactive. Be nice, don't be modal for long periods!  (defconstant $kSRWantsResultTextDrawn :|txfb|);   Boolean. Default is true. If true, search results are posted to Feedback window  (defconstant $kSRWantsAutoFBGestures :|dfbr|);   Boolean. Default is true. If true, client needn't call SRProcessBegin/End to get default feedback behavior  (defconstant $kSRSoundInVolume :|volu|);   short in [0..100] log scaled sound input power. Can't set this property  (defconstant $kSRReadAudioFSSpec :|aurd|);   *FSSpec. Specify FSSpec where raw audio is to be read (AIFF format) using kSRCanned22kHzSpeechSource. Reads until EOF  (defconstant $kSRCancelOnSoundOut :|caso|);   Boolean: Default is true.  If any sound is played out during utterance, recognition is aborted.  (defconstant $kSRSpeedVsAccuracyParam :|sped|);   SRSpeedSetting between 0 and 100  ;   0 means more accurate but slower.  ;   100 means (much) less accurate but faster.  (defconstant $kSRUseToggleListen 0);   listen key modes  (defconstant $kSRUsePushToTalk 1)(defconstant $kSRListenKeyMode :|lkmd|);   short: either kSRUseToggleListen or kSRUsePushToTalk  (defconstant $kSRListenKeyCombo :|lkey|);   short: Push-To-Talk key combination; high byte is high byte of event->modifiers, the low byte is the keycode from event->message  (defconstant $kSRListenKeyName :|lnam|);   Str63: string representing ListenKeyCombo  (defconstant $kSRKeyWord :|kwrd|);   Str255: keyword preceding spoken commands in kSRUseToggleListen mode  (defconstant $kSRKeyExpected :|kexp|);   Boolean: Must the PTT key be depressed or the key word spoken before recognition can occur?  ;   Operational Status Flags  (defconstant $kSRIdleRecognizer #X1);   engine is not active  (defconstant $kSRSearchInProgress #X2);   search is in progress  (defconstant $kSRSearchWaitForAllClients #X4);   search is suspended waiting on all clients' input  (defconstant $kSRMustCancelSearch #X8);   something has occurred (sound played, non-speech detected) requiring the search to abort  (defconstant $kSRPendingSearch #X10);   we're about to start searching  ;   Recognition Result Properties  (defconstant $kSRTEXTFormat :|TEXT|);   raw text in user supplied memory  (defconstant $kSRPhraseFormat :|lmph|);   SRPhrase containing result words  (defconstant $kSRPathFormat :|lmpt|);   SRPath containing result phrases or words  (defconstant $kSRLanguageModelFormat :|lmfm|);   top level SRLanguageModel for post parse  ;   SRLanguageObject Family Properties  (defconstant $kSRSpelling :|spel|);   spelling of a SRWord or SRPhrase or SRPath, or name of a SRLanguageModel  (defconstant $kSRLMObjType :|lmtp|);   Returns one of SRLanguageObject Types listed below  (defconstant $kSRRefCon :|refc|);   4 bytes of user storage  (defconstant $kSREnabled :|enbl|);   Boolean -- true if SRLanguageObject enabled  (defconstant $kSROptional :|optl|);   Boolean -- true if SRLanguageObject is optional	 (defconstant $kSRRepeatable :|rptb|);   Boolean -- true if SRLanguageObject is repeatable  (defconstant $kSRRejectable :|rjbl|);   Boolean -- true if SRLanguageObject is rejectable (Recognition System's kSRRejectedWord  ;  		object can be returned in place of SRLanguageObject with this property)	 (defconstant $kSRPrimitive :|prim|);   Boolean -- determines what shows up in search result's list of primitives  (defconstant $kSRRejectionLevel :|rjct|);   SRRejectionLevel between 0 and 100  (defconstant $kSRFinishingFlags :|finf|);   Please use kSROptional, kSRRepeatable, and kRejetable instead. pass pointer to SRLanguageObjectFlags. Being phased out of public interfaces.  ;   LM Object Types -- returned as kSRLMObjType property of language model objects  (defconstant $kSRLanguageModelType :|lmob|);   SRLanguageModel  (defconstant $kSRPathType :|path|);   SRPath  (defconstant $kSRPhraseType :|phra|);   SRPhrase  (defconstant $kSRWordType :|word|);   SRWord  ;   a normal and reasonable rejection level  (defconstant $kSRDefaultRejectionLevel 50);   Finishing Flags - used to make up SRLanguageObjectFlags, which is used for kSRFinishingFlags and kSRAutoFinishingParam properties   ;   4/10/95 These finishing flags are being phased out of the public interfaces.  Please use kSROptional, kSRRepeatable,  ;  	and kSRRejectable Boolean SRLanguageObject properties instead.  Those Boolean properties are easier to use.			 ;   bit zero is reserved  (defconstant $kSRAddPauses #X2) ;   allows user to pause between words  (defconstant $kSRAddRejection #X4);   unrecognized words will be rejected  (defconstant $kSRAddNoise #X8)  ;   allows a some noise at beginning or end of utterance  (defconstant $kSRMakeOptional #X10);   contents of LM are optional  (defconstant $kSRMakeRepeatable #X20);   contents of LM may be repeated 0 or more times  (defconstant $kSRAddWordSpotting #X24)(defconstant $kSRDefaultFinishing #X2)(defconstant $kSRNoFinishing 0);  ****************************************************************************** ;  						NOTES ON USING THE API									 ;  																				 ;  		All operations (with the exception of SRGetRecognitionSystem) are		 ;  		directed toward an object allocated or begot from New, Get and Read		 ;  		type calls.																 ;  																				 ;  		There is a simple rule in dealing with allocation and disposal:			 ;  																				 ;  		*	all toolbox allocations are obtained from a SRRecognitionSystem		 ;  																				 ;  		*	if you obtain an object via New or Get, then you own a reference 	 ;  			to that object and it must be released via SRReleaseObject when		 ;  			you no longer need it												 ;  																				 ;  		*	when you receive a SRRecognitionResult object via AppleEvent or		 ;  			callback, it has essentially been created on your behalf and so		 ;  			you are responsible for releasing it as above						 ;  																				 ;  		*	when you close a SRRecognitionSystem, all remaining objects which		 ;  			were allocated with it will be forcefully released and any			 ;  			remaining references to those objects will be invalid.				 ;  																				 ;  		This translates into a very simple guideline:							 ;  			If you allocate it or have it allocated for you, you must release	 ;  			it.  If you are only peeking at it, then don't release it.			 ;  																				 ;  ****************************************************************************** ;   Opening and Closing of the SRRecognitionSystem  (deftrap ("_SROpenRecognitionSystem" ("SpeechRecognitionLib")) ((system (:pointer (:pointer :signed-long))) (systemid :ostype))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1024 system systemid)); $ENDC(deftrap ("_SRCloseRecognitionSystem" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 513 system)); $ENDC;   Accessing Properties of any Speech Object  (deftrap ("_SRSetProperty" ("SpeechRecognitionLib")) ((srobject (:pointer :signed-long)) (selector :ostype) (property :pointer) (propertylen :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 2050 srobject selector property propertylen)); $ENDC(deftrap ("_SRGetProperty" ("SpeechRecognitionLib")) ((srobject (:pointer :signed-long)) (selector :ostype) (property :pointer) (propertylen (:pointer :size)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 2051 srobject selector property propertylen)); $ENDC;   Any object obtained via New or Get type calls must be released  (deftrap ("_SRReleaseObject" ("SpeechRecognitionLib")) ((srobject (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 516 srobject)); $ENDC(deftrap ("_SRGetReference" ("SpeechRecognitionLib")) ((srobject (:pointer :signed-long)) (newobjectref (:pointer (:pointer :signed-long))))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1061 srobject newobjectref)); $ENDC;   Traversing SRRecognitionResult or LMObjects  (deftrap ("_SRCountItems" ("SpeechRecognitionLib")) ((container (:pointer :signed-long)) (count (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1029 container count)); $ENDC(deftrap ("_SRGetIndexedItem" ("SpeechRecognitionLib")) ((container (:pointer :signed-long)) (item (:pointer (:pointer :signed-long))) (index :signed-long))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1542 container item index)); $ENDC(deftrap ("_SRSetIndexedItem" ("SpeechRecognitionLib")) ((container (:pointer :signed-long)) (item (:pointer :signed-long)) (index :signed-long))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1543 container item index)); $ENDC(deftrap ("_SRRemoveIndexedItem" ("SpeechRecognitionLib")) ((container (:pointer :signed-long)) (index :signed-long))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1032 container index)); $ENDC;   SRRecognizer Instance Functions  (deftrap ("_SRNewRecognizer" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)) (instance (:pointer (:pointer :signed-long))) (sourceid :ostype))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1546 system instance sourceid)); $ENDC(deftrap ("_SRStartListening" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 524 instance)); $ENDC(deftrap ("_SRStopListening" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 525 instance)); $ENDC(deftrap ("_SRSetLanguageModel" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (active (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1038 instance active)); $ENDC(deftrap ("_SRGetLanguageModel" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (active (:pointer (:pointer :signed-long))))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1039 instance active)); $ENDC(deftrap ("_SRContinueRecognition" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 528 instance)); $ENDC(deftrap ("_SRCancelRecognition" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 529 instance)); $ENDC(deftrap ("_SRIdle" ("SpeechRecognitionLib")) nil   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 40)); $ENDC;   Language Model Building and Manipulation Functions  (deftrap ("_SRNewLanguageModel" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)) (model (:pointer (:pointer :signed-long))) (name :pointer) (namelength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 2066 system model name namelength)); $ENDC(deftrap ("_SRNewPath" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)) (path (:pointer (:pointer :signed-long))))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1043 system path)); $ENDC(deftrap ("_SRNewPhrase" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)) (phrase (:pointer (:pointer :signed-long))) (text :pointer) (textlength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 2068 system phrase text textlength)); $ENDC(deftrap ("_SRNewWord" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)) (word (:pointer (:pointer :signed-long))) (text :pointer) (textlength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 2069 system word text textlength)); $ENDC;   Operations on any object of the SRLanguageObject family  (deftrap ("_SRPutLanguageObjectIntoHandle" ("SpeechRecognitionLib")) ((lobj (:pointer :signed-long)) (lobjhandle :handle))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1046 lobj lobjhandle)); $ENDC(deftrap ("_SRPutLanguageObjectIntoDataFile" ("SpeechRecognitionLib")) ((lobj (:pointer :signed-long)) (frefnum :signed-integer))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 808 lobj frefnum)); $ENDC(deftrap ("_SRNewLanguageObjectFromHandle" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)) (lobj (:pointer (:pointer :signed-long))) (lobjhandle :handle))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1047 system lobj lobjhandle)); $ENDC(deftrap ("_SRNewLanguageObjectFromDataFile" ("SpeechRecognitionLib")) ((system (:pointer :signed-long)) (lobj (:pointer (:pointer :signed-long))) (frefnum :signed-integer))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1063 system lobj frefnum)); $ENDC(deftrap ("_SREmptyLanguageObject" ("SpeechRecognitionLib")) ((lobj (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 536 lobj)); $ENDC(deftrap ("_SRChangeLanguageObject" ("SpeechRecognitionLib")) ((lobj (:pointer :signed-long)) (text :pointer) (textlength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1561 lobj text textlength)); $ENDC(deftrap ("_SRAddLanguageObject" ("SpeechRecognitionLib")) ((base (:pointer :signed-long)) (addon (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1050 base addon)); $ENDC(deftrap ("_SRAddText" ("SpeechRecognitionLib")) ((base (:pointer :signed-long)) (text :pointer) (textlength :size) (refcon :signed-long))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 2075 base text textlength refcon)); $ENDC(deftrap ("_SRRemoveLanguageObject" ("SpeechRecognitionLib")) ((base (:pointer :signed-long)) (toremove (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1052 base toremove)); $ENDC;   Utilizing the System Feedback Window  (deftrap ("_SRProcessBegin" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (failed :boolean))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 797 instance failed)); $ENDC(deftrap ("_SRProcessEnd" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (failed :boolean))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 798 instance failed)); $ENDC(deftrap ("_SRSpeakAndDrawText" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (text :pointer) (textlength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1567 instance text textlength)); $ENDC(deftrap ("_SRSpeakText" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (speaktext :pointer) (speaklength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1568 instance speaktext speaklength)); $ENDC(deftrap ("_SRStopSpeech" ("SpeechRecognitionLib")) ((recognizer (:pointer :signed-long)))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 547 recognizer)); $ENDC(deftrap ("_SRSpeechBusy" ("SpeechRecognitionLib")) ((recognizer (:pointer :signed-long)))   (:stack :boolean)   (:stack-trap #xAA56 :d0 548 recognizer)); $ENDC(deftrap ("_SRDrawText" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (disptext :pointer) (displength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1569 instance disptext displength)); $ENDC(deftrap ("_SRDrawRecognizedText" ("SpeechRecognitionLib")) ((instance (:pointer :signed-long)) (disptext :pointer) (displength :size))   (:stack :signed-integer)   (:stack-trap #xAA56 :d0 1570 instance disptext displength)); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := SpeechRecognitionIncludes; $ENDC                         ; __SPEECHRECOGNITION__; $IFC NOT UsingIncludes; $ENDC(export '($KSRNOFINISHING $KSRDEFAULTFINISHING $KSRADDWORDSPOTTING          $KSRMAKEREPEATABLE $KSRMAKEOPTIONAL $KSRADDNOISE $KSRADDREJECTION          $KSRADDPAUSES $KSRDEFAULTREJECTIONLEVEL $KSRWORDTYPE $KSRPHRASETYPE          $KSRPATHTYPE $KSRLANGUAGEMODELTYPE $KSRFINISHINGFLAGS          $KSRREJECTIONLEVEL $KSRPRIMITIVE $KSRREJECTABLE $KSRREPEATABLE          $KSROPTIONAL $KSRENABLED $KSRREFCON $KSRLMOBJTYPE $KSRSPELLING          $KSRLANGUAGEMODELFORMAT $KSRPATHFORMAT $KSRPHRASEFORMAT          $KSRTEXTFORMAT $KSRPENDINGSEARCH $KSRMUSTCANCELSEARCH          $KSRSEARCHWAITFORALLCLIENTS $KSRSEARCHINPROGRESS $KSRIDLERECOGNIZER          $KSRKEYEXPECTED $KSRKEYWORD $KSRLISTENKEYNAME $KSRLISTENKEYCOMBO          $KSRLISTENKEYMODE $KSRUSEPUSHTOTALK $KSRUSETOGGLELISTEN          $KSRSPEEDVSACCURACYPARAM $KSRCANCELONSOUNDOUT $KSRREADAUDIOFSSPEC          $KSRSOUNDINVOLUME $KSRWANTSAUTOFBGESTURES $KSRWANTSRESULTTEXTDRAWN          $KSRBLOCKMODALLY $KSRBLOCKBACKGROUND $KSRFOREGROUNDONLY          $KSRAUTOFINISHINGPARAM $KSRCALLBACKPARAM $KSRNOTIFICATIONPARAM          $KSRSEARCHSTATUSPARAM $TYPESRSPEECHRESULT $TYPESRRECOGNIZER          $KEYSRSPEECHSTATUS $KEYSRSPEECHRESULT $KEYSRRECOGNIZER          $KAESPEECHDETECTED $KAESPEECHDONE $KAESPEECHSUITE          $KSRNOTIFYRECOGNITIONDONE $KSRNOTIFYRECOGNITIONBEGINNING          $KSRCANNED22KHZSPEECHSOURCE $KSRLIVEDESKTOPSPEECHSOURCE          $KSRDEFAULTSPEECHSOURCE $KSRNOFEEDBACKHASLISTENMODES          $KSRHASFEEDBACKHASLISTENMODES $KSRNOFEEDBACKNOLISTENMODES          $KSRFEEDBACKANDLISTENINGMODES $KSRCLEANUPONCLIENTEXIT          $KSRSEPARATIONCHARS $KSRREJECTEDWORD $KSRDEFAULTRECOGNITIONSYSTEMID          $UPPSRCALLBACKPROCINFO $KSRNOTIMPLEMENTEDYET          $KSRCANTREADLANGUAGEOBJECT $KSRSNDINSOURCEDISCONNECTED $KSRCANTADD          $KSRTOOMANYELEMENTS $KSREXPANSIONTOODEEP $KSRNOTFINISHEDWITHREJECTION          $KSRWORDNOTFOUND $KSRALREADYFINISHED $KSRALREADYRELEASED          $KSRLANGUAGEMODELTOOBIG $KSRSUBITEMNOTFOUND $KSRHASNOSUBITEMS          $KSROTHERRECALREADYMODAL $KSRRECOGNITIONDONE $KSRRECOGNITIONCANCELED          $KSRNOPENDINGUTTERANCES $KSRNOCLIENTLANGUAGEMODEL $KSRMODELMISMATCH          $KSRNOTLISTENINGSTATE $KSRALREADYLISTENING          $KSRCANTSETDURINGRECOGNITION $KSRCANTGETPROPERTY $KSRCANTSETPROPERTY          $KSRFEEDBACKNOTAVAIL $KSRNOTARECSYSTEM $KSRBUFFERTOOSMALL          $KSRBADSELECTOR $KSRPARAMOUTOFRANGE $KSRBADPARAMETER          $KSRNOTASPEECHOBJECT $KSROUTOFMEMORY $KSRCOMPONENTNOTFOUND          $KSRINTERNALERROR $KSRNOTAVAILABLE $GESTALTTELEPHONESPEECHRECOGNITION          $GESTALTDESKTOPSPEECHRECOGNITION $GESTALTSPEECHRECOGNITIONATTR          $GESTALTSPEECHRECOGNITIONVERSION))(provide-interface 'SpeechRecognition)
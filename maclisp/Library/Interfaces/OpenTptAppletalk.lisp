(in-package :TRAPS)             ; ;  	File:		OpenTptAppleTalk.p;  ;  	Contains:	Public AppleTalk definitions;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ; ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __OPENTPTAPPLETALK__; $SETC __OPENTPTAPPLETALK__ := 1; $I+; $SETC OpenTptAppleTalkIncludes := UsingIncludes; $SETC UsingIncludes := 1; $IFC UNDEFINED __OPENTRANSPORT__; $I OpenTransport.p; $ENDC; 	Types.p														; 		ConditionalMacros.p										; 	MixedMode.p													; 	Strings.p													; $PUSH; $ALIGN MAC68K; $LibExport+(defconstant $ATK_DDP :|DDP |)(defconstant $ATK_AARP :|AARP|)(defconstant $ATK_ATP :|ATP |)(defconstant $ATK_ADSP :|ADSP|)(defconstant $ATK_ASP :|ASP |)(defconstant $ATK_PAP :|PAP |)(defconstant $ATK_NBP :|NBP |)(defconstant $ATK_ZIP :|ZIP |); ******************************************************************************; ** Some prefixes for shared libraries; *******************************************************************************(defconstant $kATalkVersion "1.0")(defconstant $kATalkPrefix "ot:atlk$")(defconstant $kATBinderID "ot:atbd$"); ;  Module Names; (defconstant $kDDPName "ddp")(defconstant $kATPName "atp")(defconstant $kADSPName :|adsp|)(defconstant $kASPName "asp")(defconstant $kPAPName "pap")(defconstant $kNBPName "nbp")(defconstant $kZIPName "zip")(defconstant $kLTalkName :|ltlk|)(defconstant $kLTalkAName "ltlkA")(defconstant $kLTalkBName "ltlkB"); ******************************************************************************; ** Protocol-specific Options; **; ** NOTE:; ** All Protocols support OPT_CHECKSUM (Value is (unsigned long)T_YES/T_NO); ** ATP supports OPT_RETRYCNT (# Retries, 0 = try once) and; **				OPT_INTERVAL (# Milliseconds to wait); *******************************************************************************(defconstant $DDP_OPT_CHECKSUM #$OPT_CHECKSUM)(defconstant $DDP_OPT_SRCADDR #X2101)(defconstant $ATP_OPT_REPLYCNT #X2110);  AppleTalk - ATP Resp Pkt Ct Type			;  Value is (unsigned long)  pkt count		(defconstant $ATP_OPT_DATALEN #X2111);  AppleTalk - ATP Pkt Data Len Type		;  Value is (unsigned long) length			(defconstant $ATP_OPT_RELTIMER #X2112);  AppleTalk - ATP Release Timer Type; 									 * Value is (unsigned long) timer; 									 * (See Inside AppleTalk, second edition	(defconstant $ATP_OPT_TRANID #X2113);  Value is (unsigned long) Boolean			(defconstant $PAP_OPT_OPENRETRY #X2120);  AppleTalk - PAP OpenConn Retry count; 									 * Value is (unsigned long) T_YES/T_NO		; ******************************************************************************; ** Protocol-specific events; *******************************************************************************(defconstant $kAppleTalkEvent (+ #$KPROTOCOLEVENT #X10000)); ; 	 * If you send the IOCTL: OTIoctl(I_OTGetMiscellaneousEvents, 1),; 	 * you will receive these events on your endpoint.; 	 * NOTE: The endpoint does not need to be bound.; 	 *; 	 * No routers have been seen for a while.  If the cookie is NULL,; 	 * all routers are gone.  Otherwise, there is still an ARA router; 	 * hanging around being used, and only the local cable has been ; 	 * timed out.; 	 (defconstant $T_ATALKROUTERDOWNEVENT (+ #$KAPPLETALKEVENT 51)); ; 		 * This indicates that all routers are offline; 		 (defconstant $kAllATalkRoutersDown 0); ; 		 * This indicates that all local routers went offline, but; 		 * an ARA router is still active; 		 (defconstant $kLocalATalkRoutersDown -1); ; 		 * This indicates that ARA was disconnected, do it's router went offline,; 		 * and we have no local routers to fall back onto.; 		 (defconstant $kARARouterDisconnected -2); ; 	 * We didn't have a router, but now one has come up.; 	 * Cookie is NULL for a normal router coming up, non-NULL; 	 * for an ARA router coming on-line; 	 (defconstant $T_ATALKROUTERUPEVENT (+ #$KAPPLETALKEVENT 52)); ; 		 * We had no local routers, but an ARA router is now online.; 		 (defconstant $kARARouterOnline -1); ; 		 * We had no routers, but a local router is now online; 		 (defconstant $kATalkRouterOnline 0); ; 		 * We have an ARA router, but now we've seen a local router as well; 		 (defconstant $kLocalATalkRouterOnline -2); ; 	 * A Zone name change was issued from the router, so our; 	 * AppleTalk Zone has changed.; 	 (defconstant $T_ATALKZONENAMECHANGEDEVENT (+ #$KAPPLETALKEVENT 53)); ; 	 * An ARA connection was established (cookie != NULL),; 	 * or was disconnected (cookie == NULL); 	 (defconstant $T_ATALKCONNECTIVITYCHANGEDEVENT (+ #$KAPPLETALKEVENT 54)); ; 	 * A router has appeared, and our address is in the startup; 	 * range.  Cookie is hi/lo of new cable range.; 	 (defconstant $T_ATALKINTERNETAVAILABLEEVENT (+ #$KAPPLETALKEVENT 55)); ; 	 * A router has appeared, and it's incompatible withour; 	 * current address.  Cookie is hi/lo of new cable range.; 	 (defconstant $T_ATALKCABLERANGECHANGEDEVENT (+ #$KAPPLETALKEVENT 56)); 	-------------------------------------------------------------------------; 		ECHO; 		------------------------------------------------------------------------- (defconstant $kECHO_TSDU 585)   ;  Max. # of data bytes.; 	-------------------------------------------------------------------------; 		NBP; 		------------------------------------------------------------------------- (defconstant $kNBPMaxNameLength 32)(defconstant $kNBPMaxTypeLength 32)(defconstant $kNBPMaxZoneLength 32)(defconstant $kNBPSlushLength 9);  Extra space for @, : and a few escape chars(defconstant $kNBPMaxEntityLength (+ 0 (+ #$KNBPMAXNAMELENGTH (+ #$KNBPMAXTYPELENGTH (+ #$KNBPMAXZONELENGTH 3)))))(defconstant $kNBPEntityBufferSize (+ 0 (+ #$KNBPMAXNAMELENGTH (+ #$KNBPMAXTYPELENGTH (+ #$KNBPMAXZONELENGTH #$KNBPSLUSHLENGTH)))))(defconstant $kNBPWildCard #X3D);  NBP name and type match anything '='(defconstant $kNBPImbeddedWildCard #XC5);  NBP name and type match some '�'(defconstant $kNBPDefaultZone #X2A);  NBP default zone '*'; 	-------------------------------------------------------------------------; 		ZIP; 		------------------------------------------------------------------------- (defconstant $kZIPMaxZoneLength #$KNBPMAXZONELENGTH); 	-------------------------------------------------------------------------; 		Address-related values; 		------------------------------------------------------------------------- (defconstant $kDDPAddressLength 8);  value to use in netbuf.len field;  Maximum length of AppleTalk address(defconstant $kNBPAddressLength #$KNBPENTITYBUFFERSIZE)(defconstant $kAppleTalkAddressLength (+ #$KDDPADDRESSLENGTH #$KNBPENTITYBUFFERSIZE)); ******************************************************************************; ** CLASS TAppleTalkServices; *******************************************************************************; $IFC NOT OTKERNEL ; $IFC UNDEFINED __cplusplus (def-mactype :ATSVCREF (find-mactype :POINTER)); $ELSEC(defrecord TAppleTalkServices    )(def-mactype :ATSVCREF (find-mactype :POINTER)); $ENDC; $SETC kDefaultAppleTalkServicesPath := (-3)(deftrap ("_OTAsyncOpenAppleTalkServices" ("OpenTransportSupport")) ((cfig (:pointer :otconfiguration)) (flags :otopenflags) (notifyproc :otnotifyprocptr) (contextptr :pointer))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTOpenAppleTalkServices" ("OpenTransportSupport")) ((cfig (:pointer :otconfiguration)) (flags :otopenflags) (err (:pointer :osstatus)))   (:no-trap (:pointer :tappletalkservices))   (:no-trap))(deftrap ("_OTATalkGetMyZone" ("OTATalkClientLib")) ((ref (:pointer :tappletalkservices)) (zone (:pointer :tnetbuf)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTATalkGetLocalZones" ("OTATalkClientLib")) ((ref (:pointer :tappletalkservices)) (zones (:pointer :tnetbuf)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTATalkGetZoneList" ("OTATalkClientLib")) ((ref (:pointer :tappletalkservices)) (zones (:pointer :tnetbuf)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTATalkGetInfo" ("OTATalkClientLib")) ((ref (:pointer :tappletalkservices)) (info (:pointer :tnetbuf)))   (:no-trap :osstatus)   (:no-trap))(defrecord DDPAddress    (fAddressType :OTADDRESSTYPE)   (fNetwork :UINT16)   (fNodeID :SINT8)             ;  UInt8    (fSocket :SINT8)             ;  UInt8    (fDDPType :SINT8)            ;  UInt8    (fPad :SINT8)                ;  UInt8    )(defrecord NBPAddress    (fAddressType :OTADDRESSTYPE)   (fNBPNameBuffer (:ARRAY :SINT8 (- (- #$KNBPENTITYBUFFERSIZE 1) 0 -1)));  UInt8    )(defrecord DDPNBPAddress    (fAddressType :OTADDRESSTYPE)   (fNetwork :UINT16)   (fNodeID :SINT8)             ;  UInt8    (fSocket :SINT8)             ;  UInt8    (fDDPType :SINT8)            ;  UInt8    (fPad :SINT8)                ;  UInt8    (fNBPNameBuffer (:ARRAY :SINT8 (- (- #$KNBPENTITYBUFFERSIZE 1) 0 -1)));  UInt8    )(defrecord NBPEntity    (fEntity (:ARRAY :SINT8 (- (- #$KNBPMAXENTITYLENGTH 1) 0 -1)));  UInt8    ); 	---------------------------------------------------------------------; 		These are some utility routines for dealing with NBP and DDP addresses. ; 		--------------------------------------------------------------------- ; ;  Functions to initialize the various AppleTalk Address types; (deftrap ("_OTInitDDPAddress" ("OTATalkSharedLib")) ((addr (:pointer :ddpaddress)) (net :uint16) (node :byteparameter) (socket :byteparameter) (ddptype :byteparameter))   nil   (:no-trap))(deftrap ("_OTInitNBPAddress" ("OTATalkSharedLib")) ((addr (:pointer :nbpaddress)) (name :constcstringptr))   (:no-trap :size_t)   (:no-trap))(deftrap ("_OTInitDDPNBPAddress" ("OTATalkSharedLib")) ((addr (:pointer :ddpnbpaddress)) (name :constcstringptr) (net :uint16) (node :byteparameter) (socket :byteparameter) (ddptype :byteparameter))   (:no-trap :size_t)   (:no-trap))(deftrap ("_OTCompareDDPAddresses" ("OTATalkSharedLib")) ((addr1 (:pointer :ddpaddress)) (addr2 (:pointer :ddpaddress)))   (:no-trap :boolean)   (:no-trap))(deftrap ("_OTInitNBPEntity" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)))   nil   (:no-trap))(deftrap ("_OTGetNBPEntityLengthAsAddress" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)))   (:no-trap :size_t)   (:no-trap))(deftrap ("_OTSetAddressFromNBPEntity" ("OTATalkSharedLib")) ((namebuf (:pointer :uint8)) (entity (:pointer :nbpentity)))   (:no-trap :size_t)   (:no-trap))(deftrap ("_OTSetAddressFromNBPString" ("OTATalkSharedLib")) ((addrbuf (:pointer :uint8)) (name :constcstringptr) (len :sint32))   (:no-trap :size_t)   (:no-trap))(deftrap ("_OTSetNBPEntityFromAddress" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)) (addrbuf (:pointer :uint8)) (len :size_t))   (:no-trap :boolean)   (:no-trap))(deftrap ("_OTSetNBPName" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)) (name :constcstringptr))   (:no-trap :boolean)   (:no-trap))(deftrap ("_OTSetNBPType" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)) (typeval :constcstringptr))   (:no-trap :boolean)   (:no-trap))(deftrap ("_OTSetNBPZone" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)) (zone :constcstringptr))   (:no-trap :boolean)   (:no-trap))(deftrap ("_OTExtractNBPName" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)) (name :cstringptr))   nil   (:no-trap))(deftrap ("_OTExtractNBPType" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)) (typeval :cstringptr))   nil   (:no-trap))(deftrap ("_OTExtractNBPZone" ("OTATalkSharedLib")) ((entity (:pointer :nbpentity)) (zone :cstringptr))   nil   (:no-trap))(defconstant $AF_ATALK_FAMILY #X100)(defconstant $AF_ATALK_DDP #$AF_ATALK_FAMILY)(defconstant $AF_ATALK_DDPNBP (+ #$AF_ATALK_FAMILY 1))(defconstant $AF_ATALK_NBP (+ #$AF_ATALK_FAMILY 2))(defconstant $AF_ATALK_MNODE (+ #$AF_ATALK_FAMILY 3)); 	-------------------------------------------------------------------------; 		AppleTalkInfo - filled out by the OTGetATalkInfo function; 	------------------------------------------------------------------------- (defrecord AppleTalkInfo    (fOurAddress :DDPADDRESS)    ;  Our DDP address (network # & node)   (fRouterAddress :DDPADDRESS) ;  The address of a router on our cable   (fCableRange (:ARRAY :UINT16 2));  The current cable range   (fFlags :UINT16)             ;  See below   ); ;  For the fFlags field in AppleTalkInfo; (defconstant $kATalkInfoIsExtended #X1);  This is an extended (phase 2) network(defconstant $kATalkInfoHasRouter #X2);  This cable has a router(defconstant $kATalkInfoOneZone #X4);  This cable has only one zone; $SETC UsingIncludes := OpenTptAppleTalkIncludes; $ENDC                         ; __OPENTPTAPPLETALK__; $IFC NOT UsingIncludes; $ENDC(export '($KATALKINFOONEZONE $KATALKINFOHASROUTER $KATALKINFOISEXTENDED          $AF_ATALK_MNODE $AF_ATALK_NBP $AF_ATALK_DDPNBP $AF_ATALK_DDP          $AF_ATALK_FAMILY $KAPPLETALKADDRESSLENGTH $KNBPADDRESSLENGTH          $KDDPADDRESSLENGTH $KZIPMAXZONELENGTH $KNBPDEFAULTZONE          $KNBPIMBEDDEDWILDCARD $KNBPWILDCARD $KNBPENTITYBUFFERSIZE          $KNBPMAXENTITYLENGTH $KNBPSLUSHLENGTH $KNBPMAXZONELENGTH          $KNBPMAXTYPELENGTH $KNBPMAXNAMELENGTH $KECHO_TSDU          $T_ATALKCABLERANGECHANGEDEVENT $T_ATALKINTERNETAVAILABLEEVENT          $T_ATALKCONNECTIVITYCHANGEDEVENT $T_ATALKZONENAMECHANGEDEVENT          $KLOCALATALKROUTERONLINE $KATALKROUTERONLINE $KARAROUTERONLINE          $T_ATALKROUTERUPEVENT $KARAROUTERDISCONNECTED $KLOCALATALKROUTERSDOWN          $KALLATALKROUTERSDOWN $T_ATALKROUTERDOWNEVENT $KAPPLETALKEVENT          $PAP_OPT_OPENRETRY $ATP_OPT_TRANID $ATP_OPT_RELTIMER $ATP_OPT_DATALEN          $ATP_OPT_REPLYCNT $DDP_OPT_SRCADDR $DDP_OPT_CHECKSUM $KLTALKBNAME          $KLTALKANAME $KLTALKNAME $KZIPNAME $KNBPNAME $KPAPNAME $KASPNAME          $KADSPNAME $KATPNAME $KDDPNAME $KATBINDERID $KATALKPREFIX          $KATALKVERSION $ATK_ZIP $ATK_NBP $ATK_PAP $ATK_ASP $ATK_ADSP $ATK_ATP          $ATK_AARP $ATK_DDP))(provide-interface 'opentptappletalk)
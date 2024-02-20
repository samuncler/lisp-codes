(in-package :TRAPS)             ; ;  	File:		OpenTptInternet.p;  ;  	Contains:	Public TCP/IP definitions;  ;  	Copyright:	� 1984-1995 by Apple Computer, Inc.;  				All rights reserved.;  ; ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __OPENTPTINTERNET__; $SETC __OPENTPTINTERNET__ := 1; $I+; $SETC OpenTptInternetIncludes := UsingIncludes; $SETC UsingIncludes := 1; $IFC UNDEFINED __OPENTRANSPORT__; $I OpenTransport.p; $ENDC; 	Types.p														; 		ConditionalMacros.p										; 	MixedMode.p													; 	Strings.p													; $PUSH; $ALIGN MAC68K; $LibExport+(def-mactype :INETPORT (find-mactype :UINT16))(def-mactype :INETHOST (find-mactype :UINT32)); ; 	Enums used as address type designations.; (defconstant $AF_INET 2)        ;  Traditonal(defconstant $AF_DNS 42)        ;  Obviously, the answer to...; ; 	Enum which can be used to bind to all IP interfaces; 	rather than a specific one.; (defconstant $kOTAnyInetAddress 0);  Wildcard(def-mactype :INETSVCREF (find-mactype :POINTER)); ******************************************************************************; ** XTI Options; *******************************************************************************;  Protocol levels(defconstant $INET_IP #X0)(defconstant $INET_TCP #X6)(defconstant $INET_UDP #X11); ******************************************************************************; ** Some prefixes for shared libraries; *******************************************************************************(defconstant $kDNRName "dnr")(defconstant $kTCPName "tcp")(defconstant $kUDPName "udp")(defconstant $kRawIPName "rawip");  TCP Level Options(defconstant $TCP_NODELAY #X1)(defconstant $TCP_MAXSEG #X2)(defconstant $TCP_NOTIFY_THRESHOLD #X10); * not a real XTI option (defconstant $TCP_ABORT_THRESHOLD #X11); * not a real XTI option (defconstant $TCP_CONN_NOTIFY_THRESHOLD #X12); * not a real XTI option (defconstant $TCP_CONN_ABORT_THRESHOLD #X13); * not a real XTI option (defconstant $TCP_OOBINLINE #X14); * not a real XTI option (defconstant $TCP_URGENT_PTR_TYPE #X15); * not a real XTI option (defconstant $TCP_KEEPALIVE #X8);  keepalive defined in OpenTransport.h (defconstant $T_GARBAGE 2);  UDP Level Options(defconstant $UDP_CHECKSUM #X600)(defconstant $UDP_RX_ICMP #X2);  IP Level Options(defconstant $IP_OPTIONS #X1)(defconstant $IP_TOS #X2)(defconstant $IP_TTL #X3)(defconstant $IP_REUSEADDR #X4)(defconstant $IP_DONTROUTE #X10)(defconstant $IP_BROADCAST #X20)(defconstant $IP_HDRINCL #X1002)(defconstant $IP_RCVOPTS #X1005)(defconstant $IP_RCVDSTADDR #X1007)(defconstant $IP_MULTICAST_IF #X1010);  set/get IP multicast interface	(defconstant $IP_MULTICAST_TTL #X1011);  set/get IP multicast timetolive	(defconstant $IP_MULTICAST_LOOP #X1012);  set/get IP multicast loopback	(defconstant $IP_ADD_MEMBERSHIP #X1013);  add an IP group membership		(defconstant $IP_DROP_MEMBERSHIP #X1014);  drop an IP group membership		(defconstant $IP_BROADCAST_IF #X1015);  Set interface for broadcasts 	(defconstant $IP_RCVIFADDR #X1016);  Set interface for broadcasts 	; 	DVMRP-specific setsockopt commands, from ip_mroute.h(defconstant $DVMRP_INIT #X64)(defconstant $DVMRP_DONE #X65)(defconstant $DVMRP_ADD_VIF #X66)(defconstant $DVMRP_DEL_VIF #X67)(defconstant $DVMRP_ADD_LGRP #X68)(defconstant $DVMRP_DEL_LGRP #X69)(defconstant $DVMRP_ADD_MRT #X6A)(defconstant $DVMRP_DEL_MRT #X6B);  IP_TOS precdence levels(defconstant $T_ROUTINE 0)(defconstant $T_PRIORITY 1)(defconstant $T_IMMEDIATE 2)(defconstant $T_FLASH 3)(defconstant $T_OVERRIDEFLASH 4)(defconstant $T_CRITIC_ECP 5)(defconstant $T_INETCONTROL 6)(defconstant $T_NETCONTROL 7); 	IP_TOS type of service(defconstant $T_NOTOS #X0)(defconstant $T_LDELAY 16)(defconstant $T_HITHRPT 8)(defconstant $T_HIREL 4);  IP Multicast option structures(defrecord TIPAddMulticast    (multicastGroupAddress :UINT32)   (interfaceAddress :UINT32)   ); ******************************************************************************; ** Protocol-specific events; *******************************************************************************(defconstant $T_DNRSTRINGTOADDRCOMPLETE (+ #$KPRIVATEEVENT 1))(defconstant $T_DNRADDRTONAMECOMPLETE (+ #$KPRIVATEEVENT 2))(defconstant $T_DNRSYSINFOCOMPLETE (+ #$KPRIVATEEVENT 3))(defconstant $T_DNRMAILEXCHANGECOMPLETE (+ #$KPRIVATEEVENT 4))(defconstant $T_DNRQUERYCOMPLETE (+ #$KPRIVATEEVENT 5)); ******************************************************************************; ** InetAddress; *******************************************************************************(defrecord InetAddress    (fAddressType :OTADDRESSTYPE);  always AF_INET   (fPort :UINT16)              ;  Port number    (fHost :UINT32)              ;  Host address in net byte order   (fUnused (:ARRAY :SINT8 8))  ;  UInt8 ;  Traditional unused bytes   ); ******************************************************************************; ** Domain Name Resolver (DNR) ; *******************************************************************************(defconstant $kMaxHostAddrs 10)(defconstant $kMaxSysStringLen 32)(defconstant $kMaxHostNameLen 255)(defrecord InetDomainName (array (ARRAY :CHARACTER 256)))(defrecord InetHostInfo    (name :INETDOMAINNAME)   (addrs (:ARRAY :UINT32 10))   )(defrecord InetSysInfo    (cpuType (:ARRAY :CHARACTER 32))   (osType (:ARRAY :CHARACTER 32))   )(defrecord InetMailExchange    (preference :UINT16)   (exchange :INETDOMAINNAME)   )(def-mactype :INETMAILEXCHANGEPTR (find-mactype :POINTER))(defrecord DNSQueryInfo    (qType :UINT16)   (qClass :UINT16)   (ttl :UINT32)   (name :INETDOMAINNAME)   (responseType :UINT16)       ;  answer, authority, or additional   (resourceLen :UINT16)        ;  actual length of array which follows   (resourceData :OSTYPE)       ;  size varies   ); ******************************************************************************; ** DNSAddress; **; **		The DNSAddress format is optional and may be used in connects,; **		datagram sends, and resolve address calls.   The name takes the ; **		format "somewhere.com" or "somewhere.com:portnumber" where; **		the ":portnumber" is optional.   The length of this structure; **		is arbitrarily limited to the overall max length of a domain; **		name (255 chars), although a longer one can be use successfully; **		if you use this as a template for doing so.   However, the domain name ; **		is still limited to 255 characters.; *******************************************************************************(defrecord DNSAddress    (fAddressType :OTADDRESSTYPE);  always AF_DNS   (fName :INETDOMAINNAME)   ); ******************************************************************************; ** InetInterfaceInfo; *******************************************************************************(defrecord InetInterfaceInfo    (fAddress :UINT32)   (fNetmask :UINT32)   (fBroadcastAddr :UINT32)   (fDefaultGatewayAddr :UINT32)   (fDNSAddr :UINT32)   (fVersion :UINT16)   (fHWAddrLen :UINT16)   (fHWAddr (:POINTER :UINT8))   (fIfMTU :UINT32)   (fReservedPtrs (:ARRAY (:POINTER :UINT8) 2))   (fDomainName :INETDOMAINNAME)   (fReserved (:ARRAY :SINT8 256));  UInt8    ); ******************************************************************************; ** Static helper functions; *******************************************************************************(deftrap ("_OTInitInetAddress" ("OTInetClientLib")) ((addr (:pointer :inetaddress)) (port :uint16) (host :uint32))   nil   (:no-trap))(deftrap ("_OTInitDNSAddress" ("OTInetClientLib")) ((addr (:pointer :dnsaddress)) (str :cstringptr))   (:no-trap :size_t)   (:no-trap))(deftrap ("_OTInetStringToHost" ("OTInetClientLib")) ((str :cstringptr) (host (:pointer :uint32)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTInetHostToString" ("OTInetClientLib")) ((host :uint32) (str :cstringptr))   nil   (:no-trap))(deftrap ("_OTInetGetInterfaceInfo" ("OTInetClientLib")) ((info (:pointer :inetinterfaceinfo)) (val :sint32))   (:no-trap :osstatus)   (:no-trap))(defconstant $kDefaultInternetServicesPath -3); $IFC NOT OTKERNEL (deftrap ("_OTOpenInternetServices" ("OpenTransportSupport"))((cfig :otconfigurationptr) (oflag :otopenflags) (err (:pointer :osstatus)))   (:no-trap :pointer)   (:no-trap))(deftrap ("_OTAsyncOpenInternetServices" ("OpenTransportSupport")) ((cfig :otconfigurationptr) (oflag :otopenflags) (proc :otnotifyprocptr) (contextptr :pointer))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTInetStringToAddress" ("OTInetClientLib")) ((ref :pointer) (name :cstringptr) (hinfo (:pointer :inethostinfo)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTInetAddressToName" ("OTInetClientLib")) ((ref :pointer) (addr :uint32) (name (:pointer :inetdomainname)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTInetSysInfo" ("OTInetClientLib")) ((ref :pointer) (name :cstringptr) (sysinfo (:pointer :inetsysinfo)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTInetMailExchange" ("OTInetClientLib")) ((ref :pointer) (name :cstringptr) (num (:pointer :uint16)) (mx (:pointer :inetmailexchange)))   (:no-trap :osstatus)   (:no-trap))(deftrap ("_OTInetQuery" ("OTInetClientLib")) ((ref :pointer) (name :cstringptr) (qclass :uint16) (qtype :uint16) (buf :cstringptr) (buflen :size_t) (argv :pointer) (argvlen :size_t) (flags :otflags))   (:no-trap :osstatus)   (:no-trap))(defconstant $kDefaultInetInterface -1)(defconstant $kInetInterfaceInfoVersion 2); $ENDC; $ALIGN RESET; $POP; $SETC UsingIncludes := OpenTptInternetIncludes; $ENDC                         ; __OPENTPTINTERNET__; $IFC NOT UsingIncludes; $ENDC(export '($KINETINTERFACEINFOVERSION $KDEFAULTINETINTERFACE          $KDEFAULTINTERNETSERVICESPATH $KMAXHOSTNAMELEN $KMAXSYSSTRINGLEN          $KMAXHOSTADDRS $T_DNRQUERYCOMPLETE $T_DNRMAILEXCHANGECOMPLETE          $T_DNRSYSINFOCOMPLETE $T_DNRADDRTONAMECOMPLETE          $T_DNRSTRINGTOADDRCOMPLETE $T_HIREL $T_HITHRPT $T_LDELAY $T_NOTOS          $T_NETCONTROL $T_INETCONTROL $T_CRITIC_ECP $T_OVERRIDEFLASH $T_FLASH          $T_IMMEDIATE $T_PRIORITY $T_ROUTINE $DVMRP_DEL_MRT $DVMRP_ADD_MRT          $DVMRP_DEL_LGRP $DVMRP_ADD_LGRP $DVMRP_DEL_VIF $DVMRP_ADD_VIF          $DVMRP_DONE $DVMRP_INIT $IP_RCVIFADDR $IP_BROADCAST_IF          $IP_DROP_MEMBERSHIP $IP_ADD_MEMBERSHIP $IP_MULTICAST_LOOP          $IP_MULTICAST_TTL $IP_MULTICAST_IF $IP_RCVDSTADDR $IP_RCVOPTS          $IP_HDRINCL $IP_BROADCAST $IP_DONTROUTE $IP_REUSEADDR $IP_TTL $IP_TOS          $IP_OPTIONS $UDP_RX_ICMP $UDP_CHECKSUM $T_GARBAGE $TCP_KEEPALIVE          $TCP_URGENT_PTR_TYPE $TCP_OOBINLINE $TCP_CONN_ABORT_THRESHOLD          $TCP_CONN_NOTIFY_THRESHOLD $TCP_ABORT_THRESHOLD $TCP_NOTIFY_THRESHOLD          $TCP_MAXSEG $TCP_NODELAY $KRAWIPNAME $KUDPNAME $KTCPNAME $KDNRNAME          $INET_UDP $INET_TCP $INET_IP $KOTANYINETADDRESS $AF_DNS $AF_INET))(provide-interface 'opentptinternet)
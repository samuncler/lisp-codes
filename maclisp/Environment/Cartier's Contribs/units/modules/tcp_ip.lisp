;;; -*- package: CC -*-;;;;;;; Unit for module TCP/IP;;;(in-package "CC");; from the extensions unit(export 'curry)(defunit "TCP/IP"  (:requires "MACTCP"             "MACTCP-PATCH"             "MAC-FILE-IO")  (:depends-on "EXTENSIONS"               "REPORTER"               "BULLETIN")  (:source-pathname "cc:modules;tcp/ip;")  (:binary-pathname "cc:binaries;modules;tcp/ip;")  (:components "tcp"               "telnet"               "mail"               "ftp"               "various"))
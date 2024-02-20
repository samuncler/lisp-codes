(require :oou (format nil                                  "~Aoodles-of-utils:oou-init.lisp"                                  (mac-default-directory)))(oou-dependencies :help-svm                              :processes                              :wilma                              :for-save-application)(window-close (oou::make-librarian))(set-menu-item-action-function  (find-menu-item (find-menu "File") "Open�")  #'oou::edit-readable-file)(defun load-and-detach (type id)  (let* ((res (#_get1resource type id)))    (#_loadresource res)    (#_detachresource res)    res))(defun save-Wilma-Application (file-name &aux resources)   ;(setf ccl::*default-editor-class*  'oou::wilma)   (setf *listener-window-position* (make-point (- *screen-width* 390)                                                                              (- *screen-height* 125)))   (setf *listener-window-size* #@(315 119))   (with-res-file ("Goman:Wilma;Wilma-Resources")       (dolist (id '(130 131 1000 1001 1002 1003))          (dolist (type '("FREF" "ics#" "ICN#" "icl4" "icl8" "ics4" "ics8"))             (push (list (load-and-detach type id) type id) resources)))       (push (list (load-and-detach "vers" 1) "vers" 1) resources)       (push (list (load-and-detach "vers" 2) "vers" 2) resources)       ; We don't want a "CCL2" resource ...       (push (list nil "CCL2" 0) resources)       ; We -do- want a resource of type WLMA       (push (list (#_NewHandle 0) :WLMA 0 "Owner Resource") resources)       ; Grab "BNDL"(128) from our resource file, replacing MCL's       (push (list (load-and-detach "BNDL" 128) "BNDL" 128) resources))   (with-res-file ("oou:resources stuff")       (dolist (id '(128 129 130 149 150 151 152 154 156 159 161 165 166 167 168 169 170 171 176 177 178 179 180))          (push (list (load-and-detach :PICT id) :PICT id) resources))     (dolist (id '(6500 6501 6502 6503 6504 6505 6506))          (push (list (load-and-detach :CURS id) :CURS id) resources))     (push (list (load-and-detach "FOND" 128) "FOND" 128 "GoMan Helvetica") resources))   (unless (find #'oou::make-all-wilma-commands *restore-lisp-functions*)      (setf *restore-lisp-functions*                (append *restore-lisp-functions*                            (list #'oou::make-all-wilma-commands))))   (save-application file-name :creator :WLMA :resources resources))#|(setf *restore-lisp-functions* (butlast *restore-lisp-functions*))(setf *restore-lisp-functions*          (append *restore-lisp-functions*                      (list #'oou::make-tool-bar)))|#         
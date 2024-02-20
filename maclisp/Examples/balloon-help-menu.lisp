;;-*- Mode: Lisp; Package: CCL -*-;;	Change History (most recent first):;;  1 2/16/95  slh  menu alist -> hash table; new to examples project;;  (do not edit before this line!!);; ballon-help-menu.lisp; Copyright 1989-1994 Apple Computer, Inc.; Copyright 1995 Digitool, Inc. The 'tool rules!; Modification History;;  5/19/95 slh    tweaked for loading with MCL;  2/16/95 slh    use *menu-id-object-table*, not *menu-id-object-alist*;  7/08/93 straz  started; This lets you add your own menu items to the Balloon Help ; menu, which appears on the System 7 menubar.; For example of how to use this, see the end of this file.(in-package :ccl);-------; Test for Help Manager when loading(unless *help-manager-present*  (error "Help Manager is not running on this machine. Perhaps you need System 7"));-------; Variables(defvar *balloon-menu*  nil  "This is the balloon help menu item.   Instantiating it adds a grey separator line after the   predefined System help items. Your own items will be installed   after this separator.")(defvar *help-menu-item-offset*  (1+ #$kHMShowBalloonsItem)  "The first N (usually 4) menu items are managed by the Help Manager");--------; The Balloon Help menu class  (defclass help-menu (menu)  ((menu-id :initform #$kHMHelpMenuID :reader menu-id)   (menu-handle :initform (rlet ((mh :pointer))                            (#_HMGetHelpMenuHandle mh)                            (%get-ptr mh))                :reader menu-handle))  (:default-initargs :menu-title "[?]"))(defmethod initialize-instance ((menu help-menu) &rest rest)  (declare (ignore rest))  (call-next-method)  (init-menu-id menu));---------------------; Overridden menu methods (from l1-menus.lisp);--; Register menu by ID number(defmethod init-menu-id ((menu help-menu))  ; menu id should already be #$kHMHelpMenuID  (setf (gethash (menu-id menu) *menu-id-object-table*) menu));--; Start counting menu items from 3 (bypassing system help menu items); instead of 1 (like a normal menu does);(defmethod add-menu-items ((menu help-menu) &rest args &aux item mh)  (declare (dynamic-extent args))  (do* ((number (+ 1 *help-menu-item-offset*                   (list-length (slot-value menu 'item-list)))                (%i+ number 1)))       ((null args) nil)    (setq item (require-type (pop args) 'menu-element))    (when (typep item 'menu)      (when (slot-value item 'menu-handle)        (error "Menu ~s is already installed" item)))    (setf (slot-value menu 'item-list)          (nconc (slot-value menu 'item-list) (list item)))    (setf (slot-value item 'owner) menu)    (when (string= (slot-value item 'title) "-")      (setf (slot-value item 'enabledp) nil))    (when (typep item 'menu)      (menu-install item))    (when (setq mh (slot-value menu 'menu-handle))      (install-menu-item mh item number))    (set-part-color-loop item (slot-value item 'color-list))));--; You can't add or remove the balloon help menu(defmethod menu-install ((menu help-menu))  nil)(defmethod menu-deinstall ((menu help-menu))  nil);--; Standard Help Menu items are automatically handled for you; by the system. This method handles the ones you add yourself.;(defmethod menu-select ((menu help-menu) item)  (call-next-method menu (- item *help-menu-item-offset*)));--; Patch to l1-menus.lisp; menu item number is +4 if owner is the balloon help menu;(let ((*warn-if-redefine-kernel* nil))  (defmethod menu-item-number ((item menu-element) &aux owner)    (when (setq owner (slot-value item 'owner))      (+ 1 (position item (the list (slot-value owner 'item-list))                     :test 'eq)         (if (eq owner *balloon-menu*)           *help-menu-item-offset*            0))))); Instantiating the help-menu adds a grey separator line after the; predefined System help items. Your own items will be installed; after this separator.(unless *balloon-menu*  (setq *balloon-menu* (make-instance 'help-menu)))#|;=========================; Example of how to add your own Balloon Help menu item:; Add a simple menu item(add-menu-items *balloon-menu*                (make-instance 'menu-item                  :menu-item-title "Example Help"                            :menu-item-action #'(lambda ()                                        (y-or-n-dialog "Is this great or what?"                                                       :yes-text "What"                                                       :no-text nil                                                       :cancel-text nil))))|#; End of balloon-help-menu.lisp
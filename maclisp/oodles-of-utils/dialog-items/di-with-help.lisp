(in-package :oou)(oou-provide :di-with-help);*****************************************************************                                    ;; Copyright � 1991 Institut fuer Informatik, University of Basel, Switzerland ; All Rights Reserved;; Author: Dieter Holz;; some dialog-items with the help-mixin; ; ;; Changes (worth to be mentioned):; ------------------------------; none ;;*****************************************************************;*****************************************************************(oou-dependencies :scroll-bar-di                              :help-svm                              :splitter-di                              :menu-di                              :editable-text-di                              :unibas-button-di                              :unibas-pop-up-menu-di                              :scrollable-static-text-dim                              )(export '(scroll-bar-di-with-help window-menu-item-with-help                ;menu-item-with-help                ;menu-with-help                button-dialog-item-with-help                radio-button-dialog-item-with-help                static-text-dialog-item-with-help               window-with-help               view-splitter-with-help               ;menu-di-with-help               editable-text-di-with-help               unibas-button-dialog-item-with-help unibas-default-button-dialog-item-with-help               ;shaded-button-di-with-help               ;unibas-pop-up-menu-with-help               editable-text-dialog-item-with-help                editable-text-di-with-help               insertion-menu-item-with-help               ;scrollable-static-text-di-with-help               ));---------------------------------------------------------------------------(defclass window-menu-item-with-help (help-mixin window-menu-item)   ())(defclass menu-item-with-help (help-mixin menu-item)   ())(defclass menu-with-help (help-mixin menu)   ())(defclass button-dialog-item-with-help (help-mixin button-dialog-item)   ())(defclass radio-button-dialog-item-with-help (help-mixin radio-button-dialog-item)   ())(defclass static-text-dialog-item-with-help (help-mixin static-text-dialog-item)   ())(defclass editable-text-dialog-item-with-help (help-mixin editable-text-dialog-item)   ())(defclass window-with-help (help-mixin window)   ())(defclass scroll-bar-di-with-help (help-mixin scroll-bar-di)   ()) (defclass view-splitter-with-help (help-mixin view-splitter)   ())(defclass embedded-visible-menu-di-with-help (help-mixin embedded-visible-menu-di)   ())(defclass menu-di-with-help (help-mixin menu-di)   ()   (:default-initargs :view-class 'embedded-visible-menu-di-with-help))(defclass unibas-button-dialog-item-with-help (help-mixin unibas-button-dialog-item)   ())(defclass shaded-button-di-with-help (help-mixin shaded-button-di)   ())(defclass unibas-default-button-dialog-item-with-help (help-mixin unibas-default-button-dialog-item)   ())(defclass unibas-pop-up-menu-with-help (help-mixin unibas-pop-up-menu)   ())(defclass editable-text-di-with-help (help-mixin editable-text-di)   ()   (:default-initargs      :editable-text-class 'editable-text-dialog-item-with-help      :static-text-class 'static-text-dialog-item-with-help     :menu-class 'unibas-pop-up-menu-with-help))(defclass insertion-menu-item-with-help (help-mixin insertion-menu-item)   ())(defclass scrollable-static-text-di-with-help (help-mixin scrollable-static-text-dim static-text-dialog-item)   ())
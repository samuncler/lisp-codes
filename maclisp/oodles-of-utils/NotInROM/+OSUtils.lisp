;; -*- package: NotInROM -*-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; +OSUtils.Lisp;;;; Copyright � 1992 Northwestern University Institute for the Learning Sciences;; All Rights Reserved;;;; author: Michael S. Engber;;;; Provides the Operating System Utilites Routines;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(eval-when (:compile-toplevel :load-toplevel :execute)  (require    :NotInROM-u)  (in-package :NotInROM));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(deftrap-NotInROM _NGetTrapAddress :long ((trapNum :signed-integer) (tType :TrapType))  (%ptr-to-int (ecase tType                 (#.#$OSTrap   (#_GetOSTrapAddress   trapNum))                 (#.#$ToolTrap (#_GetToolTrapAddress trapNum)))))(deftrap-NotInROM _NSetTrapAddress :none ((trapAddr :signed-long) (trapNum :signed-integer) (tType :TrapType))  (ecase tType    (#.#$OSTrap   (#_SetOSTrapAddress   (%int-to-ptr trapAddr) trapNum))    (#.#$ToolTrap (#_SetToolTrapAddress (%int-to-ptr trapAddr) trapNum))));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(deftrap-NotInROM _Environs :none ((rom (:pointer :signed-integer)) (machine (:pointer :signed-integer)))  (with-macptrs ((ROMBase (%get-ptr (%int-to-ptr #$ROMBase))))    (let ((hi (%get-unsigned-byte ROMBase 8))          (lo (%get-unsigned-byte ROMBase 9)))      (if (= lo #xFF)        (progn          (%put-word machine 0)          (%put-word rom hi))        (progn          (%put-word rom lo)          (%put-word machine (1+ hi)))))));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
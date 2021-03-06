;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
(defpackage #:tut-asd
  (:use :cl :asdf))

(in-package :tut-asd)

(defsystem tut
    :name "tut"
    :version "0.0.1"
    :maintainer ""
    :author ""
    :licence ""
    :description "tut"
    :depends-on (:weblocks :hu.dwim.defclass-star)
    :components ((:file "tut")
		 (:module conf
		  :components ((:file "stores"))
		  :depends-on ("tut"))
		 (:module src
		  :components ((:file "init-session")
                               (:file "models"))
		  :depends-on ("tut" conf))))


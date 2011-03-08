
(defpackage #:tut
  (:use :cl :weblocks
        :f-underscore :anaphora)
  (:import-from :hunchentoot #:header-in
		#:set-cookie #:set-cookie* #:cookie-in
		#:user-agent #:referer)
  (:documentation
   "A web application based on Weblocks."))

(in-package :tut)

(export '(start-tut stop-tut))

;; A macro that generates a class or this webapp

(defwebapp tut
    :prefix "/"
    :description "tut: A new application"
    :init-user-session 'tut::init-user-session
    :autostart nil                   ;; have to start the app manually
    :ignore-default-dependencies nil ;; accept the defaults
    :debug t
    )

;; Top level start & stop scripts

(defun start-tut (&rest args)
  "Starts the application by calling 'start-weblocks' with appropriate
arguments."
  (apply #'start-weblocks args)
  (start-webapp 'tut))

(defun stop-tut ()
  "Stops the application by calling 'stop-weblocks'."
  (stop-webapp 'tut)
  (stop-weblocks))


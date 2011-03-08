
(in-package :tut)

(defwidget firstpage ()
 ((num :initform 10)))

(defmethod render-widget-body ((obj firstpage) &rest args)
    (with-html (:p "first page")))

;; Define callback function to initialize new sessions
(defun init-user-session (root)
  (setf (widget-children root)
	(list (make-instance 'firstpage))))

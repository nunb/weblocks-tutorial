
(in-package :tut)

;;; Multiple stores may be defined. The last defined store will be the
;;; default.
(defstore *tut-store* :prevalence
  (merge-pathnames (make-pathname :directory '(:relative "data"))
		   (asdf-system-directory :tut)))


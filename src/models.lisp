(in-package :tut)

(defclass* votable ()
  ((upvotes :initform 0)
   (downvotes :initform 0)))

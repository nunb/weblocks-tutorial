(in-package :tut)

(defclass* votable ()
  ((upvotes :initform 0)
   (downvotes :initform 0)))

(defclass* question (votable)
  ((title :initform "")))

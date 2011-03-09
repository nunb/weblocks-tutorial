
(in-package :tut)

(defwidget firstpage ()
 ((num :initform 10)))

;; 3 utility fns for cl-persistence

(defun all-of (type)
  "Accepts an argument symbol, finds stored objects of that type"
  (declare (ignore arg))
  (find-persistent-objects (class-store type) type :order-by (cons 'name :asc)))

(defun o-save (object)
  (persist-object *default-store* object))

(defun o-delete (object)
  "Delete an object from the store. Performs check first."
  (when object
    (awhen (object-id object)
      (delete-persistent-object *default-store* object))))

(defmethod render-widget-body ((obj firstpage) &rest args)
    (with-html (:p "List of top-voted questions for Weblocks tutorial")
               (dolist (q (all-of 'question))
                 (with-html (:p (str (slot-value q 'title)))))))

(defview question-form-view (:type form)
  (id :hidep t)
  (upvotes :hidep t)
  (downvotes :hidep t)
  (title))
  
(defun make-question-form (qitem)
  (make-instance 'dataform :data qitem :form-view 'question-form-view))

(defun init-user-session (root)
  (setf (widget-children root)
	(list
         (make-widget (f_% (render-link (f_% (let ((newq (make-instance 'question)))
                                               (do-dialog "Add question" (make-instance 'dataform :data newq :on-cancel (f_ (answer _)) :form-view 'question-form-view))))
                           "Add new question")))
         (make-instance 'firstpage))))

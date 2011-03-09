
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

(defun render-question (q parent)
   (with-html (:table
               (:tr (:td (render-link (f_% (incf (upvotes-of q))
                                           (o-save q) (mark-dirty parent))
                                      "like"))
                    (:td (str (slot-value q 'title)))
                    (:td (render-link (f_% (decf (upvotes-of q))
                                           (o-save q) (mark-dirty parent))
                                      "dislike"))))))

(defmethod render-widget-body ((obj firstpage) &rest args)
    (with-html (:p "List of top-voted questions for Weblocks tutorial")
               (let ((q (all-of 'question)))
                 (dolist (q (stable-sort q #'> :key #'upvotes-of))
                   (render-widget (make-widget (f_% (render-question q obj))))))))
                                         

(defview question-form-view (:type form)
  (id :hidep t)
  (upvotes :parse-as integer :hidep t)
  (downvotes :parse-as integer :hidep t)
  (title))
  

(defun init-user-session (root)
  (setf (widget-children root)
	(list
         (make-widget (f_% (render-link (f_% (let ((newq (make-instance 'question :title "")))
                                               (do-dialog "Add question" (make-instance 'dataform :data newq
                                                                                        :ui-state :form
                                                                                        :on-success (f_ (mark-dirty (root-composite)) (answer _))
                                                                                        :on-cancel (f_ (answer _))
                                                                                        :form-view 'question-form-view))))
                           "Add new question")))
         (make-instance 'firstpage))))


(in-package :tut)

(defwidget firstpage ()
 ((num :initform 10)))

;; 3 utility fns for cl-persistence

(defun all-of (type)
  (find-persistent-objects (class-store type) type :order-by (cons 'name :asc)))

(defun o-save (object)
  (persist-object *default-store* object))

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
    (with-html (:p "What shall we cover?"
                   (render-link (f_% (let ((newq (make-instance 'question :title "")))
                                       (do-dialog " + question" (make-instance 'dataform :data newq
                                                                               :ui-state :form
                                                                               :on-success (f_ (mark-dirty (root-composite)) (answer _))
                                                                               :on-cancel (f_ (answer _))
                                                                               :form-view 'question-form-view))))
                                " + question"))
               (let ((q (all-of 'question)))
                 (dolist (q (stable-sort q #'> :key #'upvotes-of))
                   (render-widget (make-widget (f_% (render-question q obj))))))))
                                         

(defview question-form-view (:type form)
  (title))
  
(defun init-user-session (root)
  (setf (widget-children root)
	(list
         (make-instance 'firstpage))))

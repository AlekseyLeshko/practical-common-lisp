(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(print (make-cd "Roses" "Kathy Mattea" 7 t))

(defvar *db* nil)
(print *db*)

(defun add-record (cd) (push cd *db*))

(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
(print "====")
(print *db*)
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(print "====")
(print *db*)
(add-record (make-cd "Home" "Dixie Chicks" 9 t))
(print "====")
(print *db*)

(add-record (make-cd "Test-title" "Test" 6.5 t))
(print "====")
(print *db*)

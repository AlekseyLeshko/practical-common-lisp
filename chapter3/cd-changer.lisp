(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(print (make-cd "Roses" "Kathy Mattea" 7 t))

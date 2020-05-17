(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

; (print (make-cd "Roses" "Kathy Mattea" 7 t))

(defvar *db* nil)
; (print *db*)

(defun add-record (cd) (push cd *db*))

; (add-record (make-cd "Roses" "Kathy Mattea" 7 t))
; (print "====")
; (print *db*)
; (add-record (make-cd "Fly" "Dixie Chicks" 8 t))
; (print "====")
; (print *db*)
; (add-record (make-cd "Home" "Dixie Chicks" 9 t))
; (print "====")
; (print *db*)

; (add-record (make-cd "Test-title" "Test" 6.5 t))
; (print "====")
; (print *db*)

(defun dump-db ()
  (format t "====~%")
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd))
  (format t "====~%~%")
)

(dump-db)

; (defun dump-db-2 ()
  ; (format t "====~%")
  ; (format t "~{~{~a:~10t~a~%~}~%~}" *db*))
  ; (format t "====~%~%")

; (dump-db-2)

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
    (prompt-read "Title")
    (prompt-read "Artist")
    (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
    (y-or-n-p "Ripped [y/n]: ")))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
      (if (not (y-or-n-p "Another? [y/n]: ")) (return))))

; (add-cds)

; (dump-db)

; (defun save-db (filename)
  ; (with-open-file (out filename
                   ; :direction :output
                   ; :if-exists :supersede)
    ; (with-standard-io-syntax
      ; (print *db* out))))

; (save-db "test.txt")

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(load-db "test.txt")
(dump-db)

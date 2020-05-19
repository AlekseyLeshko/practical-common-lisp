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

; (dump-db)

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

(defun select (select-fn)
  (remove-if-not select-fn *db*))

; (defparameter *newString* "artist")
; (print (find-symbol "artist"))
; (print (getf (nth 1 *db*) (find-symbol *newString*)))
; (defun get-x (field)
  ; (getf cd 1))


(defun get-artist (cd) (getf cd :artist))
(defun get-ripped (cd) (getf cd :ripped))

(defun select-by-artist (artist)
  (remove-if-not
    #'(lambda (cd) (equal (get-artist cd) artist))
    *db*))

; (print (remove-if-not
  ; #'(lambda (cd) (equal (getf cd :artist) "Dixie Chicks")) *db*))

; (print (select-by-artist "Dixie Chicks"))

(defun artist-selector (artist)
  #'(lambda (cd) (equal (get-artist cd) artist)))

(print
  (select (artist-selector "Dixie Chicks")))

; (print
  ; (select #'(lambda (cd) (equal (get-artist cd) "Dixie Chicks"))))
; (print
  ; (select #' (lambda (cd) (equal (get-ripped cd) T))))

(defun where (&key title artist rating (ripped nil ripped-p))
  #'(lambda (cd)
    (and
      (if title (equal (getf cd :title) title) t)
      (if artist (equal (getf cd :artist) artist) t)
      (if rating (equal (getf cd :rating) rating) t)
      (if ripped-p (equal (getf cd :ripped) ripped) t))))


(print (select (where :artist "Dixie Chicks")))
(print (select (where :rating 10 :ripped nil)))

(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
  (setf *db*
        (mapcar
         #'(lambda (row)
             (when (funcall selector-fn row)
               (if title    (setf (getf row :title) title))
               (if artist   (setf (getf row :artist) artist))
               (if rating   (setf (getf row :rating) rating))
               (if ripped-p (setf (getf row :ripped) ripped)))
             row) *db*)))

(update (where :artist "Dixie Chicks") :rating 11)
(print (select (where :artist "Dixie Chicks")))

(defun delete-rows (selector-fn)
  (setf *db* (remove-if selector-fn *db*)))

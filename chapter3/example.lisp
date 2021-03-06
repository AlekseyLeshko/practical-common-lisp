(print (list 1 2 3 4))
(print (list :a 1 :b 2 :c 3))
(print (getf (list :a 1 :b 2 :c 3) :a))
(print (getf (list :a 1 :b 2 :c 3) :b))

(format t "~%~s~%" "Dixie Chicks")
(format t "~%~a~%" "Dixie Chicks")
(format t "~%~a~%" :title)
(format t "~a:~10t~a~%~%" :artist "Dixie Chicks")
(format t "~{~a:  ~a~%~}~%" (list :a 1 :b 2))

(print (remove-if-not #'evenp '(1 2 3 4 5 6 7 8 10)))
(print (remove-if-not #'(lambda (x) (= 0 (mod x 2))) '(1 2 3 4 5 6 7 8 9 10)))
(print (remove-if-not #'(lambda (x) (= 1 (mod x 2))) '(1 2 3 4 5 6 7 8 9 10)))

(defun foo (&key a b c)
  (list a b c))
(print (foo))
(print (foo :a 1 :b 2))
(print (foo :c 1 :a 5))

(defun foo1 (&key a (b 20) (c 30 c-p))
  (list a b c c-p))

(print "====")
(print (foo1 :a 1 :b 2 :c 3))
(print (foo1 :c 3 :b 2 :a 1))
(print (foo1 :a 1 :c 3))
(print (foo1))
(print "====")

(print (foo1 :a 1 :b 2))
(print (foo1 :c 1 :a 5))


(let ((plist (list 'a 'b 'c 'd)))
  (getf plist 'c))


(print "===")
(defmacro backwards (expr) (reverse expr))
(print (backwards ("~%hello, world" t format)))

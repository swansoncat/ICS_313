;;;;This lisp file contains the functions for assignment 2.

(defparameter +ID+ "Kalen Bagano") ;The variable +ID+ contains my name

;;;The function ID() takes two integers as parameters, one for the course number and one for the assignment number. It prints an error message if the user inputs anything that isn't an
;;;integer.
;;;
;;;The function works by printing to the terminal preset sentences that are concatenated to the users input which has been transformed from integers into strings.
(defun ID (course assignment)
	(if (and (typep course 'integer) (typep assignment 'integer))
		(progn
			(print (concatenate 'string "Name: " +ID+))
			(print (concatenate 'string "Course: ICS " (write-to-string course)))
			(print (concatenate 'string "Assignment #: " (write-to-string assignment))))
		(print "Error: one of your input was not an integer"))
	nil
)

;;;The function my-finder takes two parameters, an integer to be searched for and a list to be searched in. It prints an error message if the user inputs something that isn't an integer
;;;or something that isn't a list into the first and second parameters respectively. It returns the item if it is found in the list, and NIL otherwise.
;;;
;;;The function works by checking if the head of the list is equal to the item, and if it isn't, the function is called again recursively on the remainder of the list.
(defun my-finder (item list)
	(cond ((equal NIL (typep item 'integer)) (print "Error: You input a non integer value for a parameter"))
	      ((equal NIL (typep list 'list)) (print "Error: You input a non integer value for a parameter"))
	      ((equal list ()) NIL)
	      ((equal item (car list)) (car list))
	      (t (my-finder item (cdr list)))
	)
)

;;;The function eat-last takes a list as a parameter.
(defun eat-last (list)
	(cond ((eq NIL (typep list 'list)) (print "Error: You passed something that isn't a list as the parameter"))
	      ((equal NIL list) NIL)
	      ((equal NIL (cdr list)) NIL)
	      (t (cons (car list) (eat-last (cdr list))))
	)     
)

(defun symbols-only (list)
	(cond ((equal NIL list) NIL)
	      ((symbolp (car list)) (cons (car list) (symbols-only (cdr list))))
	      ((equal NIL (symbolp (car list))) (symbols-only (cdr list)))
	)
)

(defun matchp (item-one item-two)
	(cond ((and (equal item-one item-two) (typep item-one 'list)) (cons (car item-one) (cdr item-one)))
	      ((equal item-one item-two) item-one)
	      (t (print "No match") NIL)
	)
)


(defun fibo (number)
	(if (> number 1)
		(* number (fibo (- number 1)))
		1
	)
)
	

(defun recurse (list)
	(print (car list))
	(if (eq '() (cdr list))
		NIL
		(recurse (cdr list))
	)
)

(defun testif (word)
	(if (parse-integer word :junk-allowed t)
		(print "Input was integer")
		(print "Not Integer")))

(defun test (word)
	(if (typep word 'integer)
		(print "This was a integer")
		(print "Not Integer")))

(defun test2 (word1 word2)
	(print (cdr word1)))


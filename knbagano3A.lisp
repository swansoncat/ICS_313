;;;;This file contains the functions for part A of assignment 3.

(defparameter +ID+ "Kalen Bagano") ;The variable +ID+ contains my name.

;;;The function ID() takes two integers as parameters, one for the course number and one for the assignment number. It prints an error message if the user inputs anything that isn't an
;;;integer. The function prints out the user's (me) name, the ICS class they said they're taking, and the assignment they said this is for.
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

;;;This function finds the fibonacci number of a given integer input using 3 local variables and a loop. The loop starts at fibonacci 2 and uses the preset variables 'a' 
;;;and 'b' as its base cases. It sets variable 'c' as the fibonacci result. It then sets the base cases for the next fibonacci number by setting 'a' to the value of 'b',
;;;'b' to the value of 'c'. If the loop counter 'i' is equal to the inputted parameter, the loop ends and the function returns variable 'c' which would be the fibonacci number.
(defun fibonacci (number)
	(let ((a 0) (b 1) (c 0))
		(cond
			((not (typep number 'integer)) (print "Error: You entered a non integer value as a parameter"))
			((= number 0) 0)
			((= number 1) 1)
			(t (loop for i from 2 below (+ 1 number) do (setf c (+ a b)) do (setf a b) do (setf b c)) c)
		)
	)
)

;;;This function recursively calculates the fibonacci number of a given integer input. It uses fibonacci 0 and 1 as the base cases to calculate all further fibonacci numbers.
(defun fibonacciR (number)
	(cond 
		((not (typep number 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((= number 0) 0)
		((= number 1) 1)
		(t (+ (fibonacciR (- number 1)) (fibonacciR (- number 2))))
	)
)

;;;This function recursively finds the greatest common denominator of 2 or 3 numbers using Euclid's algorithm and by feeding the results of Euclid's algorithm back into the function.
(defun gcdR (number1 number2 &optional number3)
	(cond
		((not (typep number1 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((not (typep number2 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((and (not (typep number3 'integer)) (not (eq number3 NIL))) (print "Error: You entered a non integer value as a parameter"))
		((= number1 0) (cond ((equal number3 NIL) number2) ((> number2 number3) number2) (t number3)))
		((= number2 0) (cond ((equal number3 NIL) number1) ((> number1 number3) number1) (t number3)))
		;;Note to self: ((= number3 0) number3) like for the prior two lines doesn't work because = only compares numbers
		((equal number3 0) (if (> number2 number1) number2 number1))
		((typep number3 'integer) (let ((firstgcd (gcdR number1 number2)) (secondgcd (gcdR number2 number3))) (gcdR firstgcd secondgcd)))
		((= (mod number1 number2) 0) number2)
		((= (mod number2 number1) 0) number1)
		((> number1 number2) (multiple-value-bind (q r) (floor number1 number2) (gcdR number2 r)))
		(t (multiple-value-bind (q r) (floor number2 number1) (gcdR number1 r)))
	) 
)

;;;This function iteratively finds the greatest common denominator of 2 or 3 numbers by using Euclid's algorithm in a loop and holding the results in variables that put are back into that loop.
(defun gcdi (number1 number2 &optional number3)
	(cond
		((not (typep number1 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((not (typep number2 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((and (not (typep number3 'integer)) (not (eq number3 NIL))) (print "Error: You entered a non integer value as a parameter"))
		((= number1 0) (cond ((equal number3 NIL) number2) ((> number2 number3) number2) (t number3)))
		((= number2 0) (cond ((equal number3 NIL) number1) ((> number1 number3) number1) (t number3)))
		;;Note to self: ((= number3 0) number3) like for the prior two lines doesn't work because = only compares numbers
		((equal number3 0) (if (> number2 number1) number2 number1))
		;;The variable 's' is the quotient which is thrown away every loop
		((typep number3 'integer) (let ((firstgcd number1) (r number2) (finalgcd number3)) 
										(loop while (> r 0) do (multiple-value-bind (s u) (floor firstgcd r) (setf firstgcd r) (setf r u)))
										(setf r firstgcd)
								    	(loop while (> r 0) do (multiple-value-bind (s u) (floor finalgcd r) (setf finalgcd r) (setf r u)))
										finalgcd))
		((= (mod number1 number2) 0) number2)
		((= (mod number2 number1) 0) number1)	
		((> number1 number2) (let ((q number1) (r number2)) (loop while (> r 0) do (multiple-value-bind (s u) (floor q r) (setf q r) (setf r u))) q))		
		(t (let ((q number2) (r number1)) (loop while (> r 0) do (multiple-value-bind (s u) (floor q r) (setf q r) (setf r u))) q))
	)
)

;;;This function recursively finds the least common multiple of two or three numbers recursively using the recursive greatest common denominator function. Least Common multiple is
;;;the product of all the numbers divided by the greatest common denominator so the only part that can be done recursively really is getting the greatest common denominator.
(defun lcmR (number1 number2 &optional number3)
	(cond
		((not (typep number1 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((not (typep number2 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((and (not (typep number3 'integer)) (not (eq number3 NIL))) (print "Error: You entered a non integer value as a parameter"))
		((= number1 0) 0)
		((= number2 0) 0)
		((equal number3 0) 0)
		((and (eq number3 NIL) (= (mod number1 number2) 0)) number1)
		((and (eq number3 NIL) (= (mod number2 number1) 0)) number2)
		((and (not (eq number3 NIL)) (= (mod number1 number2) 0) (= (mod number1 number3) 0)) number1)
		((and (not (eq number3 NIL)) (= (mod number2 number1) 0) (= (mod number2 number3) 0)) number2)
		((and (not (eq number3 NIL)) (= (mod number3 number1) 0) (= (mod number3 number2) 0)) number3)
		((and (not (eq number3 NIL)) (= (mod number1 number2) 0)) (let ((gcd (gcdR number1 number3))) (/ (* number1 number3) gcd)))
		((and (not (eq number3 NIL)) (= (mod number1 number3) 0)) (let ((gcd (gcdR number1 number2))) (/ (* number1 number2) gcd)))
		((and (not (eq number3 NIL)) (= (mod number2 number1) 0)) (let ((gcd (gcdR number2 number3))) (/ (* number2 number3) gcd)))
		((and (not (eq number3 NIL)) (= (mod number2 number3) 0)) (let ((gcd (gcdR number2 number1))) (/ (* number2 number1) gcd)))
		((and (not (eq number3 NIL)) (= (mod number3 number1) 0)) (let ((gcd (gcdR number3 number2))) (/ (* number3 number2) gcd)))
		((and (not (eq number3 NIL)) (= (mod number3 number2) 0)) (let ((gcd (gcdR number3 number1))) (/ (* number3 number1) gcd)))
		((typep number3 'integer) (let ((gcd (gcdR number1 number2 number3))) (/ (* number1 number2 number3) gcd)))
		(t (let ((gcd (gcdR number1 number2))) (/ (* number1 number2) gcd)))
	) 
)

;;;This function finds the least common multiple of two numbers iteratively by using the iterative greatest common denominator function. Again, the least common multiple is the
;;;product of all the numbers divided by the greatest common denominator, so the bulk of the work in calculating the least common multiple is in finding the greatest common
;;;denominator.
(defun lcmI (number1 number2 &optional number3)
	(cond
		((not (typep number1 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((not (typep number2 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((and (not (typep number3 'integer)) (not (eq number3 NIL))) (print "Error: You entered a non integer value as a parameter"))
		((= number1 0) 0)
		((= number2 0) 0)
		((equal number3 0) 0)
		((and (eq number3 NIL) (= (mod number1 number2) 0)) number1)
		((and (eq number3 NIL) (= (mod number2 number1) 0)) number2)
		((and (not (eq number3 NIL)) (= (mod number1 number2) 0) (= (mod number1 number3) 0)) number1)
		((and (not (eq number3 NIL)) (= (mod number2 number1) 0) (= (mod number2 number3) 0)) number2)
		((and (not (eq number3 NIL)) (= (mod number3 number1) 0) (= (mod number3 number2) 0)) number3)
		((and (not (eq number3 NIL)) (= (mod number1 number2) 0)) (let ((gcd (gcdI number1 number3))) (/ (* number1 number3) gcd)))
		((and (not (eq number3 NIL)) (= (mod number1 number3) 0)) (let ((gcd (gcdI number1 number2))) (/ (* number1 number2) gcd)))
		((and (not (eq number3 NIL)) (= (mod number2 number1) 0)) (let ((gcd (gcdI number2 number3))) (/ (* number2 number3) gcd)))
		((and (not (eq number3 NIL)) (= (mod number2 number3) 0)) (let ((gcd (gcdI number2 number1))) (/ (* number2 number1) gcd)))
		((and (not (eq number3 NIL)) (= (mod number3 number1) 0)) (let ((gcd (gcdI number3 number2))) (/ (* number3 number2) gcd)))
		((and (not (eq number3 NIL)) (= (mod number3 number2) 0)) (let ((gcd (gcdI number3 number1))) (/ (* number1 number1) gcd)))
		((typep number3 'integer) (let ((gcd (gcdI number1 number2 number3))) (/ (* number1 number2 number3) gcd)))
		(t (let ((gcd (gcdI number1 number2))) (/ (* number1 number2) gcd)))
	) 
)

;;;This functions recursively removes from a list all numbers in it and that are in any lists within itself. This is done by the function calling itself recursively whenever it comes across a list.
;;;The function works by returning a cons of either the head of the light + the function called on the remainder if the head is not a number, or by returning the function call on the remainder of the
;;;list if the head is a number.
(defun remove-numbers-r (l)
	(cond
		((not (typep l 'list)) (print "Error: You entered a parameter that wasn't a list"))
		((equal NIL l) NIL)
		((typep (car l) 'list)  (cons (remove-numbers-r (car l)) (remove-numbers-r (cdr l))))
		((typep (car l) 'number) (remove-numbers-r (cdr l) ))
		(t (cons (car l) (remove-numbers-r (cdr l))))
	)
)

;;;This function iteratively removes the numbers from a list by using a loop to check the head of the list and adding it to a empty list 'b' if its not a number. When the entire list has been checked
;;;the function loops over the new list and adds the head of the new list to the now empty list 'a', and the new list is set the to cdr of itself and the goes through the loop again. This does not work
;;;with lists in the list. The following function was my attempt to make one to do lists in a list.
(defun remove-numbers-i (l)
	(cond
		((not (typep l 'list)) (print "Error: You entered a parameter that wasn't a list"))
		((equal NIL l) NIL)
		(t (let ((i 0) (a l) (b ())) (loop while (< i (list-length l)) do (if (not (typep (car a) 'integer)) (setf b (cons (car a) b)) (setf b b)) do (setf a (cdr a)) do (setf i (1+ i)) )
									 (setf a ())
									 (setf i (list-length b))
									 (loop while (> i 0) do (setf a (cons (car b) a)) do (setf b (cdr b)) do (setf i (1- i)))a)
		)
	)
)

;;;This function iteratively removes the numbers from a list and list inside of the list. It works except for lists within a list within a list (it will remove the numbers but
;;;It will be printed in reverse order. The first part of the function removes the numbers but puts the items in a new list but in reverse order. The second part attempts to put
;;;the items back in order. It is mostly successful but after 20+ hours on this one function I give up.
(defun rni (l)
	(cond ((not (typep l 'list)) (print "Error: You entered a parameter that wasn't a list"))
		  		((equal NIL l) NIL)
		(t (let ((x l) (y ()) (a ()) (i 0) (list-depth 0) (listlengths (list 0)) (temp ()) (temp2 ()) (flip 0))
			(loop while (< i (list-length l)) do (setf i (1+ i)) do
				(cond

					((or(and (not (typep (car x) 'number)) (not (typep (car x) 'list))) (eq (car x) nil)) (setf y (cons (car x) y)) (setf x (cdr x)) )
					((typep (car x) 'number) (setf x (cdr x)))  
					;;if we get list, then next block looks at first item on list
					(t (setf temp (car x)) (setf list-depth (1+ list-depth)) (setf listlengths (cons (list-length (car x)) listlengths))  
						(loop while (and (> list-depth 0) (> (car listlengths) 0)) 
							do (cond ((and (not (typep (car temp) 'number)) (not (typep (car temp) 'list)) (= flip 0)) 
										(setf temp2 (cons (car temp) temp2)) 
										(setf temp (cdr temp)) 
										(setf (car listlengths) (1- (car listlengths))) 
										(cond ((= (car listlengths) 0) 
												(setf listlengths (cdr listlengths))
												(setf list-depth (1- list-depth))
												(setf (car listlengths) (1- (car listlengths)))
												(setf flip (1+ flip))
												(setf temp (cdr temp)) )
											  (t 'nothing)))
									((and (not (typep (car temp) 'number)) (not (typep (car temp) 'list)))
										(setf temp2 (cons (cons (car temp) (car temp2)) (cdr temp2))) 
										(setf temp (cdr temp)) 
										(setf (car listlengths) (1- (car listlengths))) 
										(cond ((= (car listlengths) 0) 
												(setf listlengths (cdr listlengths))
												(setf list-depth (1- list-depth))
												(setf (car listlengths) (1- (car listlengths)))
												(setf flip (1- flip))												
												(setf temp (cdr temp)) )
											  (t 'nothing)))		  
											  
									 ((typep (car temp) 'number) 
										(setf temp (cdr temp)) 
										(setf (car listlengths) (1- (car listlengths))) 
										(cond ((= (car listlengths) 0) 
												(setf listlengths (cdr listlengths))
												(setf list-depth (1- list-depth))
												(setf (car listlengths) (1- (car listlengths)))
												(setf temp (cdr temp)))
											  (t 'nothing)
										))
									  ;;below is for lists
									 (t (if (eq (car temp) nil) 'donothing (setf listlengths (cons (list-length (car temp)) listlengths))) 
										(setf list-depth (1+ list-depth))
										(setf flip (1+ flip))
										(setf temp2 (cons (cons (caar temp) ()) temp2)) 
										(setf temp (cdar temp))
										(setf (car listlengths) (1- (car listlengths)))
										(cond ((= (car listlengths) 0) 
												(setf listlengths (cdr listlengths))
												(setf list-depth (1- list-depth))
												(setf (car listlengths) (1- (car listlengths)))
												(setf flip (1+ flip))
												(setf temp (cdr temp)))
											  (t 'nothing)
										)  )) 
								)  (setf x (cdr x)) (setf y (cons temp2 y)) (setf temp2 ()) (setf temp2 (cdr temp2)) (setf flip 0)
					) 
				) (setf temp2 (cdr temp2)) (setf list-depth 0) (setf listlengths (list 0)) (setf flip 0)
			) (setf i (list-length y)) (setf temp y) (setf temp2 ()) (setf flip 0) (setf x y)
			  (setf listlengths (list 0)) 
			  (loop while (> i 0) do (cond ((and (not (typep (car x) 'list)) (= flip 0) ) 'normal
												(setf a (cons (car x) a))
												(setf temp (cdr temp))
												(setf x (cdr x))
												(setf i (1- i))
											)
											((and (eq (car x) NIL) (= flip 0))
												(setf a (cons (car x) a))
												(setf temp (cdr temp))
												(setf x (cdr x))
												(setf i (1- i))											
											)
											((OR (and (not (typep (car temp) 'list)) (> flip 0)) (and (> flip 0) (eq (car temp) nil))) 
												(setf temp2 (cons (car temp) temp2)) 
												(setf temp (cdr temp))
												(setf (car listlengths) (1- (car listlengths))) 
												(cond ((<= (car listlengths) 0) 
															(setf listlengths (cdr listlengths))
															(setf (car listlengths) (1- (car listlengths)))
															(setf flip (1- flip))												
															(setf temp (cdr x)) 
															(setf x (cdr x))
															(if (<= flip 0) (setf a (cons temp2 a)) 'donothing)
															(if (<= flip 0) (setf temp2 ()) 'donothing))
														(t 'nothing))
												)
											(t  (setf (car listlengths) (1- (car listlengths)))
												(setf listlengths (cons (list-length (car temp)) listlengths))	
												(setf (car listlengths) (1- (car listlengths)))
												(if (typep (caar temp) 'list) (setf temp2 (cons (cons (caar temp) ()) temp2 )) (setf temp2 (cons (caar temp) temp2))) 
												(setf temp (cdar temp))
												(if (= flip 0) (setf i (1- i)))
												(setf flip (1+ flip))											
											))
										) a
		)))																
)



;;;;Below functions are things not part of the homework that were made to try and test how things work while creating the other functions.
(defun opt (one &optional two)
	(if (eq two NIL)
		one
		(+ one two)
	)
)

;;;Used this function to prove that there will be an issue with the remove numbers iteratively if you have a list that contains nils
(defun testendoflist (l)
	(let ((a l)) (loop while (not (equal (car a) nil)) do (print (car a)) do (setf a (cdr a))))

)


(defun k (l)
	(let ((i 0) (a l)) (loop while (< i (list-length l)) do (print (car a)) do (setf i (1+ i)) do (setf a (cdr a))))
)

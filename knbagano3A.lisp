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

(defun lcmR (number1 number2 &optional number3)
	(cond
		((not (typep number1 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((not (typep number2 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((and (not (typep number3 'integer)) (not (eq number3 NIL))) (print "Error: You entered a non integer value as a parameter"))
		((= number1 0) 0)
		((= number2 0) 0)
		((equal number3 0) 0)
		((typep number3 'integer) (let ((gcd (gcdR number1 number2 number3))) (/ (* number1 number2 number3) gcd)))
		(t (let ((gcd (gcdR number1 number2))) (/ (* number1 number2) gcd)))
	) 
)

(defun lcmI (number1 number2 &optional number3)
	(cond
		((not (typep number1 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((not (typep number2 'integer)) (print "Error: You entered a non integer value as a parameter"))
		((and (not (typep number3 'integer)) (not (eq number3 NIL))) (print "Error: You entered a non integer value as a parameter"))
		((= number1 0) 0)
		((= number2 0) 0)
		((equal number3 0) 0)
		((typep number3 'integer) (let ((gcd (gcdI number1 number2 number3))) (/ (* number1 number2 number3) gcd)))
		(t (let ((gcd (gcdI number1 number2))) (/ (* number1 number2) gcd)))
	) 
)

(defun remove-numbers-r (l)
	(cond
		((not (typep l 'list)) (print "Error: You entered a parameter that wasn't a list"))
		((equal NIL l) NIL)
		((typep (car l) 'list)  (cons (remove-numbers-r (car l)) (remove-numbers-r (cdr l))))
		((typep (car l) 'number) (remove-numbers-r (cdr l) ))
		(t (cons (car l) (remove-numbers-r (cdr l))))
	)
)

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

;;new idea for iteratively removing numbers. Move through list looking for lists, modify list, then go back up.
;;;Also could try doing something like break lists into individuals parts and reindex after having everything in
(defun rni (l)
;;The variable lists will holds the length of each list in the depth chain of lists
	(let ((x l) (y ()) (i 0) (list-depth 0) (listlengths (list 0)) (temp ()) (temp2 ()))
		(loop while (< i (list-length l)) do (setf i (1+ i)) do
			(cond
				((and (not (typep (car x) 'number)) (not (typep (car x) 'list))) (setf y (cons (car x) y)) (setf x (cdr x)))
				((typep (car x) 'number) (setf x (cdr x)))
				;;below originall said (typep (car x) 'list) instead of t
				(t (setf temp (car x)) (setf list-depth (1+ list-depth)) (setf listlengths (cons (list-length (car x)) listlengths)) 
					(loop while (and (> list-depth 0) (> (car listlengths) 0))  
						do (cond ((and (not (typep (car temp) 'number)) (not (typep (car temp) 'list))) 
									(setf temp2 (cons (car temp) temp2))
									(setf temp (cdr temp)) 
									(setf (car listlengths) (1- (car listlengths))) 
									(cond ((= (car listlengths) 0) 
											(setf listlengths (cdr listlengths)) 
											(setf temp (cdr temp)) )
										  (t 'nothing)))
								 ((typep (car temp) 'number) 
									(setf temp (cdr temp)) 
									(setf (car listlengths) (1- (car listlengths))) 
									(cond ((= (car listlengths) 0) 
											(setf listlengths (cdr listlengths)) 
											(setf temp (cdr temp)))
										  (t 'nothing)
									))
								  ;;below is for lists
								 (t 
									(cons (list-length (car temp)) listlengths) 
									(cons (car temp) temp)
									(setf (car listlengths) (1- (car listlengths)))
									(cond ((= (car listlengths) 0) 
											(setf listlengths (cdr listlengths)) 
											(setf temp (cdr temp)))
										  (t 'nothing)
									))) do (print temp2) 
							) (setf y (cons temp2 y)) (setf x (cdr x)) (setf temp2 ())
				)
			) 
		) y
	)																
)

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

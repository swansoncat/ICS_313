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

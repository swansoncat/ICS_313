;;;;This lisp file has the program "Guess My Number" in which the software uses binary search

(defparameter *small* 1) ;The variable *small* is changed to the software's guess plus one whenever the number is larger than the software's guess.
(defparameter *big* 100) ;The variable *big* is changed to the software's guess minus one whenever the number is smaller than the software's guess.
(defparameter +ID+ "Kalen") ;The variable +ID+ contains my name.

;;;The function guess-my-number() takes the average of the variables *small* and *big* by doing a rightward shift of the binary form of their sum. 
(defun guess-my-number ()
     (ash (+ *small* *big*) -1))

;;;The function smaller() sets the variable *big* to the software's prior guess decremented by one, and then tells it to guess once more.
(defun smaller ()
     (setf *big* (1- (guess-my-number)))
     (guess-my-number))

;;;The function bigger() sets the variable *small* to the software's prior guess incremented by one, and then tells it to guess once more.
(defun bigger ()
     (setf *small* (1+ (guess-my-number)))
     (guess-my-number))

;;;The function start-over() resets the variables *small* and *big* to 1 and 100 respectively and tells the software to start guessing again
(defun start-over ()
   (defparameter *small* 1)
   (defparameter *big* 100)
   (guess-my-number))

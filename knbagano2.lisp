
(defparameter +ID+ "Kalen Bagano")

(defun ID (course assignment)
	(if (and (typep course 'integer) (typep assignment 'integer))
		(progn
			(print (concatenate 'string "Name: " +ID+))
			(print (concatenate 'string "Course: ICS " (write-to-string course)))
			(print (concatenate 'string "Assignment #: " (write-to-string assignment))))
		(print "Error: one of your input was not an integer"))
	nil
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


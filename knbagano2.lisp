
(defparameter +ID+ "Kalen Bagano")

(defun ID (course assignment)
	(print (concatenate 'string "Name: " +ID+))
	(print (concatenate 'string "Course: ICS " (write-to-string course)))
	(print (concatenate 'string "Assignment #: " (write-to-string assignment)))
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


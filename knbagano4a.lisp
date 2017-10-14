;;;; This lisp file has the functions to run the Wizard's Adventure Game for assignment 3.

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

;;;This variable holds the locations in the game and their descriptions.
(defparameter *nodes* '((living-room (you are in the living-room.
                            a wizard is snoring loudly on the couch.))
                        (garden (you are in a beautiful garden.
                            there is a well in front of you.))
                        (attic (you are in the attic.
                            there is a giant welding torch in the corner.))
						(bedroom (you are in the bedroom.
                            there is a lady wizard sleeping quietly on the bed.))
						(kitchen (you are in the kitchen. there is a large
						fridge along the wall.))))

;;;This function describes to location that you give to it as a parameter.						
(defun describe-location (location nodes)
   (cadr (assoc location nodes)))

;;;This variable holds the paths to the various locations in the game.
(defparameter *edges* '((living-room (garden west door)  
                                     (attic upstairs ladder)
									 (bedroom north door)
									 (kitchen east door))
						(bedroom (living-room south door))									 
						(kitchen (living-room west door))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

;;;This function describes a path that you give to it as a parameter.						
(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

;;;This is a function that gives the paths from whatever location you pass as a parameter to it.
(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

;;;This variable holds a list of objects in the game.
(defparameter *objects* '(whiskey bucket beer pie hat shirt frog chain back-tire bike-chain front-tire handle-bar bike-frame))

;;;This parameter holds the list of 5 objects that make up a bicycle
(defparameter *bikeparts* '(back-tire bike-chain front-tire handle-bar bike-frame))

;;;This variable holds a list of the locations for the objects in the previous variable.
(defparameter *object-locations* '((whiskey living-room)
                                   (bucket living-room)
								   (back-tire living-room)
								   (beer kitchen)
								   (pie kitchen)
								   (bike-chain kitchen)
								   (hat bedroom)
								   (shirt bedroom)
								   (front-tire bedroom)
								   (handle-bar attic)
								   (bike-frame garden)
                                   (chain garden)
                                   (frog garden)))

;;;This function returns the objects in the location you pass as a parameter.								   
(defun objects-at (loc objs obj-loc)
   (labels ((is-at (obj)
              (eq (cadr (assoc obj obj-loc)) loc)))
       (remove-if-not #'is-at objs)))

;;;This function describes the objects in the location you pass as a parameter.
(defun describe-objects (loc objs obj-loc)
   (labels ((describe-obj (obj)
                `(you see a ,obj on the floor.)))
      (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

;;;This variable holds the location your character is at in the game.
(defparameter *location* 'living-room)

;;;This function describes what location you are in currently, the paths out of that location to another area, and whatever objects are in the area.
(defun look ()
  (append (describe-location *location* *nodes*)
          (describe-paths *location* *edges*)
          (describe-objects *location* *objects* *object-locations*)))

;;;This function changes the location of your character and describes the new location, paths from it, and objects in it.
(defun walk (direction)
  (labels ((correct-way (edge)
             (eq (cadr edge) direction)))
    (let ((next (find-if #'correct-way (cdr (assoc *location* *edges*)))))
      (if next 
          (progn (setf *location* (car next)) 
                 (look))
          '(you cannot go that way.)))))

;;;This function allows the player to pick up a object. This has been modified from the original to remove the objects old location from the *object-location*
;;;list after picking it up.
(defun pickup (object)
  (cond ((member object (objects-at *location* *objects* *object-locations*))
		  (setf *object-locations* (remove `(,object ,*location*) *object-locations* :test #'equal))
		  (print `(,object ,*location*))
         (push (list object 'body) *object-locations*)
         `(you are now carrying the ,object))
	  (t '(you cannot get that.))))

;;;This function returns what objects the player is carrying.
(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))

;;;This function returns whether or not a player is carrying a given object.
(defun have (object) 
    (member object (cdr (inventory))))
	
;;;This function creates the bicycle if the user has all 5 bicycle parts
(defun create-bicycle ()
	(let ((kalenz 0)) (loop for i in (inventory) do (if (member i *bikeparts*) (setf kalenz (1+ kalenz)) 'donothing))
				 (if (eq kalenz 5) (progn (loop for j in *object-locations* do (if (member (car j) *bikeparts*) (setf *object-locations* (remove j *object-locations* :test #'equal)))
																		do (if (member (car j) *objects*) (setf *objects* (remove j *objects*)))
																		)
									 (push 'bicycle *objects*) (push '(bicycle body) *object-locations*)
									 (prin1 "You have created the bicycle"))
							  (prin1 "You do not have all 5 bicycle parts"))
	)  
)	


;  wizards_game part 2

(defun game-repl ()
    (let ((cmd (game-read)))
        (unless (eq (car cmd) 'quit)
            (game-print (game-eval cmd))
            (game-repl))))

(defun game-read ()
    (let ((cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
         (flet ((quote-it (x)
                    (list 'quote x)))
             (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defparameter *allowed-commands* '(look walk pickup inventory))

(defun game-eval (sexp)
    (if (member (car sexp) *allowed-commands*)
        (eval sexp)
        '(i do not know that command.)))

(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
          (rest (cdr lst)))
      (cond ((eql item #\space) (cons item (tweak-text rest caps lit)))
            ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
            ((eql item #\") (tweak-text rest caps (not lit)))
            (lit (cons item (tweak-text rest nil lit)))
            (caps (cons (char-upcase item) (tweak-text rest nil lit)))
            (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
    (princ (coerce (tweak-text (coerce (string-trim "() " (prin1-to-string lst)) 'list) t nil) 'string))
    (fresh-line))	
	
	

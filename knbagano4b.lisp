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
(defparameter *objects* '(whiskey bucket beer pie hat shirt frog chain))

;;;This variable holds a list of the locations for the objects in the previous variable.
(defparameter *object-locations* '((whiskey living-room)
                                   (bucket living-room)
								   (beer kitchen)
								   (pie kitchen)
								   (hat bedroom)
								   (shirt bedroom)
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

;;;This function allows the player to pick up a object.		  
(defun pickup (object)
  (cond ((member object (objects-at *location* *objects* *object-locations*))
         (push (list object 'body) *object-locations*)
         `(you are now carrying the ,object))
	  (t '(you cannot get that.))))

;;;This function returns what objects the player is carrying.
(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))

;;;This function returns whether or not a player is carrying a given object.
(defun have (object) 
    (member object (cdr (inventory))))
	
	
(defmacro new-object (obj loc)
	`(progn (push ,obj *objects*)
			(push (list ,obj ,loc) *object-locations*)
	 )
)



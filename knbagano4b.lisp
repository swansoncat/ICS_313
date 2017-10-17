;;;; This lisp file has the functions to run the Wizard's Adventure Game for assignment 4, part B.

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
	
;;;This macro adds an item to the game. It works by first pushing all the locations in the game onto a list that can be checked against, and then it performs error checking
;;;to see whether or not the object already exists, and whether or not the location exists or not. If the object does not already exist and the location is a real location,
;;;the macro places the object there by expanding into push functions that push the object onto the global variable list *objects* and the pair (object, location) onto the 
;;;global variable list *object-locations*.
(defmacro new-object (obj loc)
	`(let ((temp ()))
		(loop for i in *nodes* 
			do (push (car i) temp)
		) 
		(cond ((member ,obj *objects*) (print "The object already exists"))
			  ((not (member ,loc temp)) (print "The location does not exist"))
			  (t (push (list ,obj ,loc) *object-locations*) (push ,obj *objects*) (format t "You placed ~A at ~A." ,obj ,loc))
		)
	 )
)

;;;This macro creates new paths between locations in the game. The locations need to exist and the macro checks for that and returns an error message if a location that doesn't
;;;exist is passed as a parameter. Additionally the path cannot already exist and the macro will also return an error message if it does. This function works by modifying the 
;;;*edges* global variable. It pushes the locations/edges that aren't being modified onto one list and puts the location/edges being modified on another. The cdr function is
;;;is used on the list with the one location to retrive the list of edges, and the new edge is added to this list. The single location is then added to all the other locations,
;;;and then the *edges* global varible is set to our combined list. The last optional variable indicates whether or not we are creating a two way edge or a one way edge. 
;;;The parameter 'wayback' should be interpreted as being the opposite of whatever the parameter 'direction' is. For example, if you are making a door that is in the south of 
;;;the location, 'wayback' would be set to north. This is not a strict rule though, as the player would be allowed to create something like a portal that could be anywhere in a 
;;;location.
(defmacro new-path (loc-from loc-to direction path &optional wayBack)
	`(let ((temp ()) (temp2 ()) (modNode ()))
		(loop for i in *nodes* 
			do (push (car i) temp) 
		)
		(cond ((not (member ,loc-from temp)) (print "The location does not exist"))
			  ((not (member ,loc-to temp)) (print "The location does not exist"))
			  ((member (list ,loc-to ,direction ,path) (cdr (assoc ,loc-from *edges*)) :test #'equal) (print "The path already exists"))
			  (t (loop for k in *edges* do (print (car k)) do (if (not (equal (car k) ,loc-from)) (push k temp2) (setf modNode k))) 
				(push (list ,loc-to ,direction ,path) (cdr modNode)) (push modNode temp2) 
				(format t "You placed a ~A from ~A to ~A.~C" ,path ,loc-from ,loc-to #\linefeed) (setf *edges* temp2))
		)
		(cond ((null ,wayBack) *edges*)
			  (t (new-path ,loc-to ,loc-from ,wayBack ,path)) 
		)
	)
)

;;;This macro creates a new location. It works first by getting all the locations in the *nodes* global variable and putting it into a list for error checking, like
;;;in the new-object macro. It first does error checking to see whether or not the location already exists, and then it creates the new location by adding the location
;;;name and description onto the *nodes* global variable by expanding into a normal push function with the given information.
(defmacro new-location (loc desc)
	`(let ((temp ()))
		(loop for i in *nodes* 
			do (push (car i) temp)
		) 
		(cond ((member ,loc temp) (print "The location already exists"))
			  (t (push (list ,loc ,desc) *nodes*) (push (list ,loc) *edges* ) (format t "You created a new location, ~A. Its description is ~A." ,loc ,desc))
		)
	 )
)

;;;This is a macro that combines the previous three macros. It creates a new location, places a object there, and creates either a path from the new location to an already
;;;existing location, or if the last parameter in the (new-path) macro is set it then creates a two way path.
(defmacro combined-mod (new-loc desc obj loc-to direction path &optional wayback)
	`(progn (new-location ,new-loc ,desc) (new-object ,obj ,new-loc) (new-path ,new-loc ,loc-to ,direction ,path ,wayback)
	 )
)



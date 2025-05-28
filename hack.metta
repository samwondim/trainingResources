;;define expression to determine recommendable movie
;;a movie M is watchable by a person P if M is engaging and interesting 

;;define the kb
;;define predicates (person, movie, is_engaging, is_interesting, watch)
(= (kb) (superpose ( 
            (: Movie Type)
            (: Person Type)
            ;define predicates (person, movie, is_engaging, is_interesting, watch)
            (: X Movie) 
            (: Y Movie)
            (: P Person)
            (: Q Person)
            (movie X)
            (movie Y)
            (watch P X)
            (watch Q Y) 
            (is_engaging X)
            (is_interesting X)
            (is_engaging Y)
            )
          )
   )

!(add-reduct &self (kb))

(: watch (-> Person Movie Bool))
(= (watch $person $movie) 
   (
    match &self (watch $person $movie) 
                  (if (== (collapse $person) ()) 
                    False
                    True 
                    )
    )
)

(: movie (-> Movie Bool))
(= (movie $m) 
    (== (get-type $m) Movie)
)

(: person (-> Person Bool))
(= (person $p) 
  (== (get-type $p) Person)
)

(: interesting (-> Movie Bool))
(= (interesting $movie) 
   (match &self (is_interesting $movie) (not (== (collapse $movie) ())))
)

(: engaging (-> Movie Bool))
(= (engaging $movie) 
   (match &self (is_engaging $movie) (not (== (collapse $movie) ())))
)

(: is_watchable (-> Person Movie Expression))
(= (is_watchable $person $movie) 
   (
    if (
        and 
          (and (person $person) (movie $movie))
          (and (engaging $movie) (interesting $movie))
        )
        (Movie $movie is Watchable by Person $person)
        (Movie $movie is Not Watchable by Person $person)
    )
)

!(assertEqual (watch P X) True)
!(assertEqual (interesting X) True)
!(assertEqual (engaging X) True)
!(assertEqual (is_watchable P X) (Movie X is Watchable by Person P))

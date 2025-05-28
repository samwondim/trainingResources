;Knowledge Representation
(Male Aman)
(Male Abenezer)
(Male Leul)

(Parent Alem)
(Parent Kebede)
(Parent Genet)
;
;(operator/procedure $x $y)
(Child Aman Alem)
(Child Abenezer Alem)
(Child Leul Genet)

;
(Sibling Aman Abenezer)
;
;
;Pattern Matching
;$x, $y, $z
;!(match &self (Male $x) $x)
;!(match &self (Child Aman $parent) $parent)
;
(= (isMale $item) (if (== () (collapse (match &self (Male $item) $item))) False True)) ;() (Aman) (Abenezer)
;!(isMale Aman)
;!(isMale Beza)


; if (expression) option1 option2 
;
;
;if expression, let, let*, println! 
;(let $var (expresion) (do something with $var))

;!(let $output (+ 100 2) (- $output 2))
;!(let* 
;    (
;     ($first (+ 1 2))
;     ($second (* $first 100))
;     ($last (/ $second 2))
;     )
;    $last
;    )
;
;
;MeTTa functions
;
;
;
;superpose and collapse, decons-atom

;(= (bin) 0)
;(= (bin) 1)

;!(bin)
;!(+ 1 (superpose (0 1)))
;!(superpose (1 2 3))
;map, filter
;
;(1 (2 (3 (4))))
;(cons-atom)
;(decons-atom)
;!(cons-atom 1 (1 2 3))
;!(decons-atom (1 2 3))
;()
;(= (map $f $list $acc)
;   (if (== () $list) ;base case
;     $acc
;     (let* (
;            (($head $tail) (decons-atom $list))
;            ($res ($f $head))
;            ($newAcc (cons-atom $res $acc))
;            ($rest (map $f $tail $newAcc))
;            )
;       $rest
;      )
;        ;recursive case
;     ) 
;   )

;(= (map $f $list) 
;   (collapse ($f (superpose $list)))
;   )
;

;(= (sqr $x) (* $x $x))
;!(map sqr (1 2 3 4) )

;(= (isEven $x) (== (% $x 2) 0))

;(= (filter $f $list $acc)
;   (if (== () $list)
;     $acc
;     (let* (
;            (($head $tail) (decons-atom $list))
;            ($res ($f $head))
;            )
;       (if $res 
;         (filter $f $tail (cons-atom $head $acc))
;         (filter $f $tail $acc)
;         )
;      )
;    )
;   )
;!(filter isEven (1 2 3 4 5 6 7 8 9) () )
;

;!(empty)
;
;(= (filter $f $list)
;   (collapse (let $element (superpose $list) (if ($f $element) $element (empty))))
;   )
;!(filter isEven (1 2 3 4 5 6 7 8 9) )

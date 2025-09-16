; Q1: Ascending
(define (ascending? s) 
        (if (or (null? s) (null? (cdr s)))
            #t
            (if ( > (car s) (car (cdr s)))
                #f
                (ascending? (cdr s))
            )
        )
)




; Q2: My Filter
(define (my-filter pred s) 
        (cond ((null? s) '())
              ((pred (car s)) (cons (car s) (my-filter pred (cdr s))) )
              (else (my-filter pred (cdr s)) )
        )
)




; Q3: Interleave
(define (interleave lst1 lst2) 
        (cond ((null? lst1) lst2) 
              ((null? lst2) lst1) 
              (else (cons (car lst1) 
                          (interleave lst2 (cdr lst1))
                    )
              )
        )
)




; Q4: No Repeats
(define (no-repeats s) 
        (if (null? s)
            '()
            (
                let ((rest (no-repeats (cdr s))))
                (if (contains? (car s) rest)
                    rest
                    (cons (car s) rest)
                )
            )
        )
)

(define (contains? e vis) 
    (not (null? (filter (lambda (a) (= a e))
                        vis
                )
         )
    )
)
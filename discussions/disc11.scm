
;;; Q1: Mystery Macr

(define-macro (mystery-macro expr old new)
    (mystery-helper expr old new)
)
(define (mystery-helper e o n)
; (print e) (print o) (print n)
    (if (pair? e)
        (cons (mystery-helper (car e) o n) (mystery-helper (cdr e) o n))
        (if (eq? e o) n e)
    )
)

(define five 5)
; five
(print (mystery-macro (* x x) x five) )
; 25
(print (mystery-macro (* x x) x (+ five 1)) )
; 36
(print (mystery-macro '(* x x) x y) )
; (* y y)
(print (mystery-macro (> (x) (> (y) (+ x y))) > lambda) )
; (lambda (x) (lambda (y) (+ x y)))
(mystery-macro (begin e e e) e (print five)) 
; 5
; 5
; 5


;;; Q2: Multiple Assignment

(define-macro (assign sym1 sym2 expr1 expr2)
    `(begin
    (define ,sym1 ,expr1)
    (define ,sym2 ,(eval expr2))
    )
)

(assign x y (+ 1 1) 3)
(assign x y y x)
(expect x 3)
(expect y 2)


;;; Q3: Switch

(define-macro (switch expr cases)
    `(let ((val ,expr))
        ,(cons 'cond
                (map (lambda (case) (cons
                    `(equal? val ,(car case))
                    (cdr case))
                    )
                    cases
                )
        )
    )
)

(switch (+ 1 1) ((1 (print 'a)) 
                 (2 (print 'b)) 
                 (3 (print 'c)))
)
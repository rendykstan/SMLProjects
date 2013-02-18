
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; basic function
(define cube1 
  (lambda (x)
    (* x (* x x))))

; many functions, such as *, take a variable number of arguments
(define cube2
  (lambda (x)
    (* x x x)))

; syntactic sugar for function definitions
(define (cube3 x)
  (* x x x))


; Problem 1

(define (sequence low high stride)
  (if (> (+ low stride) high)
     ( if (> low high) null (list low)   ) 
     (cons low (sequence (+ low stride) high stride))
   )
 )


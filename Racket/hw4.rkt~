
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

(define (sequence_bad_style low high stride)
  (if (> (+ low stride) high)
     ( if (> low high) null (list low)   ) 
     (cons low (sequence (+ low stride) high stride))
   )
 )


(define (sequence low high stride)
  ( cond 
     [ (> (+ low stride) high) null]    
     [ (> low high) (list low)]
     [ #t (cons low (sequence (+ low stride) high stride))]
  )
  
  )

; Problem 2
(define (string-append-map xs suffix)
        (map 
          (lambda (x)  
            (string-append x suffix)  
          ) 
          xs
         )  
  )

; Problem 3
(define (list-nth-mod xs n)
     (cond
        [ (null? xs)  (error "list-nth-mod: empty list")]
        [ (< n 0) (error "list-nth-mod: negative number") ]
        [ #t (last
              (take 
               xs 
               (+ 
                1 
                (modulo 
                  (length xs)
                  n
                )
               ) 
              )
             )]
     )
 )

; Problem 4



(define (stream-for-n-steps a_stream n)
  (letrec (
        [f (lambda (shortened_stream new_list acc) 
             (cond
                [(> acc n) new_list]
                [ #t (f (car shortened_stream) (append new_list (cdr shortened_stream) ) (+ 1 acc) )]
              )
           )
        ]
        )
      (f a_stream '() 0)
   )
 )
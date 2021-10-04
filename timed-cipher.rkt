#lang racket/base

(require racket/contract
         racket/math)

(provide
 now-pass
 get-passes
 verify-pass)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; duration type: seconds ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define/contract (now-pass duration)
  (-> positive-integer? positive-integer?)
  (let* ([s (round (/ (current-milliseconds) 1000))]
         [current-s (round (/ s duration))])
    current-s))

(define/contract (get-passes duration)
  (-> positive-integer? (listof positive-integer?))
  (let* ([s (round (/ (current-milliseconds) 1000))]
         [current-s (round (/ s duration))]
         [next-s (+ current-s duration)]
         [previous-s (- current-s duration)])
    (list previous-s current-s next-s)))


(define/contract (verify-pass pass duration)
  (-> positive-integer? positive-integer? (or/c #f (listof positive-integer?)))
  (member pass (get-passes duration)))


;;; TESTS
(module+ test
  (require rackunit)
  (check-true (list? (verify-pass (now-pass 1) 1)))
  (check-true (list? (verify-pass (now-pass 2) 2)))
  (check-true (list? (verify-pass (now-pass 3) 3)))
  (check-true (list? (verify-pass (now-pass 4) 4)))
  (check-true (list? (verify-pass (now-pass 5) 5)))
  (check-true (list? (verify-pass (now-pass 11) 11))))

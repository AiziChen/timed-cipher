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
  (parameterize ([current-locale "UTC"])
               (let* ([s (round (/ (current-milliseconds) 1000))]
                      [remain (remainder s duration)]
                      [current-s (- s remain)])
                 current-s)))

(define/contract (get-passes duration)
  (-> positive-integer? (listof positive-integer?))
  (parameterize ([current-locale "UTC"])
    (let* ([s (round (/ (current-milliseconds) 1000))]
           [remain (remainder s duration)]
           [current-s (- s remain)]
           [next-s (+ current-s duration)]
           [previous-s (- current-s duration)])
      (list previous-s current-s next-s))))


(define/contract (verify-pass pass duration)
  (-> positive-integer? positive-integer? (or/c #f (listof positive-integer?)))
  (member pass (get-passes duration)))


;;; TESTS
(module+ test
  (require rackunit)
  ;; simple test
  (check-true (list? (verify-pass (now-pass 1) 1)))
  (check-true (list? (verify-pass (now-pass 2) 2)))
  (check-true (list? (verify-pass (now-pass 3) 3)))
  (check-true (list? (verify-pass (now-pass 4) 4)))
  (check-true (list? (verify-pass (now-pass 5) 5)))
  (check-true (list? (verify-pass (now-pass 11) 11)))
  ;; test on now-pass dely
  (define p1 (now-pass 3))
  (sleep 1)
  (check-true (list? (verify-pass p1 3)))
  (sleep 1)
  (check-true (list? (verify-pass p1 3)))
  ;; test on get-passes dely
  (define ps (get-passes 3))
  (sleep 1)
  (check-true (list? (member (now-pass 3) ps)))
  (sleep 1)
  (check-true (list? (member (now-pass 3) ps)))) 

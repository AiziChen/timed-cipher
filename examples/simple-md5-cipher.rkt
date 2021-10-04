#lang racket/base

(require file/md5
         "../timed-cipher.rkt")

;;; This is a very simple timed md5 cipher
;;; Do not use this cipher in production !!!


(define (md5-now-pass duration)
  (define np (now-pass duration))
  (md5 (number->string np)))


(define (md5-get-passes duration)
  (define passes (get-passes duration))
  (map (lambda (p)
         (md5 (number->string p)))
       passes))


;;; TEST
(module+ test
  (require rackunit)
  (check-true (list? (member (md5-now-pass 1) (md5-get-passes 1)))))

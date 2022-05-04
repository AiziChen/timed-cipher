#lang racket/base

(require file/md5
         "../timed-cipher.rkt")

;;; salt timed md5 cipher

(define (md5-now-pass salt duration)
  (define np (now-pass duration))
  (md5 (string-append (number->string np) salt)))


(define (md5-get-passes salt duration)
  (define passes (get-passes duration))
  (for/list ([p passes])
    (md5 (string-append (number->string p) salt))))


;;; TEST
(module+ test
  (require rackunit)
  (define *msalt* "quanye")
  (check-true (list? (member (md5-now-pass *msalt* 2) (md5-get-passes *msalt* 2))))
  (check-true (list? (member (md5-now-pass *msalt* 7) (md5-get-passes *msalt* 7)))))

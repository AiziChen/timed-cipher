#lang racket/base

(require file/md5
         "../timed-cipher.rkt")

;;; salt timed md5 cipher

(define (md5-now-pass salt duration)
  (define np (now-pass duration))
  (let ([sp (number->string np)])
    (md5 (string-append sp salt))))


(define (md5-get-passes salt duration)
  (define passes (get-passes duration))
  (map (lambda (p)
         (let ([sp (number->string p)])
           (md5 (string-append sp salt))))
       passes))


;;; TEST
(module+ test
  (require rackunit)
  (define *pass* "quanye")
  (check-true (list? (member (md5-now-pass *pass* 2) (md5-get-passes *pass* 2))))
  (check-true (list? (member (md5-now-pass *pass* 7) (md5-get-passes *pass* 7)))))

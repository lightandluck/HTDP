;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Chapter 2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))


(define (cvolume length)
  (* length length length))

(define (string-first str)
  (substring str 0 1))

(define (string-last str)
  (substring str (- (string-length str) 1) (string-length str)))

(define (==> sunny friday)
  (or (not sunny) friday))

(define sunny #false)
(define friday #true)

(define (string-insert str i)
  (if (= (string-length str) 0) "_"
  (string-append (substring str 0 i) "_" (substring str i))))

(define (ff x)
  (* x 10))

(define (dist x y)
  (sqrt (+ (sqr x) (sqr y))))

(dist 3 4)

(==> #true #false)

(require 2htdp/batch-io)

(define (letter fst lst sig)
  (string-append
   (opening fst)
   "\n\n"
   (body fst lst)
   "\n\n"
   (closing sig)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "Please call us back " fst " " lst))

(define (closing sig)
  (string-append
   "Sincerely,"
   "\n\n"
   sig
   "\n"))

(define (number->square s)
  (square s "solid" "red"))

(define (reset s ke)
  100)

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

(define (main y)
  (big-bang y
            [on-tick sub1]
            [stop-when zero?]
            [to-draw place-dot-at]
            [on-key stop]))
            
(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))

(define (stop y ke)
  0)
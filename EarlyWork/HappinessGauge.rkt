;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HappinessGauge) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define MAX-HAPPINESS 100)
(define MIN-HAPPINESS 0)
(define HAPPY-DECREASE -.1)
(define LARGE-DELTA (/ 1 3))
(define SMALL-DELTA (/ 1 5))

(define BG (empty-scene 100 20 "black"))

; WorldState -> WorldState
; reduces happiness by -.1 each clock tick, does not go pass 0 or 100
(check-expect (tock 0) 0)
(check-expect (tock 100) 99.9)
(check-expect (tock -.1) 0)
(check-expect (tock 101) 100)

(define (tock ws)
  (cond
    [(<= ws MIN-HAPPINESS) MIN-HAPPINESS]
    [(> ws MAX-HAPPINESS) MAX-HAPPINESS]
    [else (+ ws HAPPY-DECREASE)]))


; WorldState -> Image
; creates happiness gauge
(define (render ws)
  (cond
    ; check for edge-case, so we never try to create a rect with negative width
    [(<= ws 1) (place-image/align
   (rectangle 1 (image-height BG) "solid" "red")
   0 0 "left" "top" BG)]
    [else (place-image/align
   (rectangle ws (image-height BG) "solid" "red")
   0 0 "left" "top" BG)]))

; WorldState Key-Event -> WorldState
; increases happiness by amount dependent on which key was pressed
(check-expect (ke-h 50 "down") 60)
(check-expect (ke-h 78 "left") 78)
(check-expect (ke-h 30 "up") 40)
(check-expect (ke-h 76 "right") 76)

(define (ke-h ws ke)
  (cond
    [(<= ws 1) 5] ; guarantees that increases begin at a decent, whole number, so we aren't
    ; multiplying fractional values
    [(key=? ke "down") (+ ws (* ws SMALL-DELTA))]
    [(key=? ke "up") (+ ws (* ws LARGE-DELTA))]
    [else ws]))

; Main
(define (main ws)
  (big-bang ws
            [on-key ke-h]
            [on-tick tock]
            [to-draw render]))
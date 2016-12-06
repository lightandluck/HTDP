;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Chapter3 - World-Design|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; World Design Example
; 1. DEFINE CONSTANTS, RESOURCES AND CYCLES THAT ARE REGENERATIVE

; a. Physical constants
(define WHEEL-RADIUS 5) ; single point of control for how car is rendered
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

; b. Graphical constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-RADIUS WHEEL-RADIUS "solid" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR-BODY
  (rectangle (* WHEEL-DISTANCE 2) (* 2 WHEEL-RADIUS)  "solid" "red"))

(define CAR-WINDOW
  (rectangle (image-width BOTH-WHEELS) WHEEL-RADIUS "solid" "red"))

(define CAR-SCENE
  (rectangle (* WHEEL-DISTANCE 2)
             (+ (image-height BOTH-WHEELS)
                (image-height CAR-BODY)
                (image-height CAR-WINDOW)) "solid" "white"))

(define CAR-LAYER-A
  (place-image CAR-BODY
               (/ (image-width CAR-SCENE) 2)
               (/ (image-height CAR-SCENE) 2) CAR-SCENE))

(define CAR-LAYER-B
  (place-image BOTH-WHEELS
               (/ (image-width CAR-SCENE) 2)
               (- (image-height CAR-SCENE) WHEEL-RADIUS)
               CAR-LAYER-A))

(define CAR
  (place-image CAR-WINDOW
               (/ (image-width CAR-SCENE) 2)
               WHEEL-RADIUS
               CAR-LAYER-B))

(define WIDTH-OF-WORLD (* (image-width CAR) 5))
(define BG (empty-scene WIDTH-OF-WORLD (* (image-height CAR) 2)  "white"))
(define Y-CAR (+ (/ (image-height BG) 2) (/ (image-height CAR) 2) -1))

; 2. DATA REPRESENTATION FOR ALL STATES OF THE WORLD
; Choose simple forms of data to represent the state of the world

; A WorldState is a Number.
; interpretion: the number of humans fed, clothed, and sheltered

; 3. FUNCTIONS TO DEAL WITH CHANGING STATE OF WORLD
; render
; clock-tick-handler
; key-stroke-handler
; mouse-event-handler
; end?


; Wish List

; WorldState -> Image
; places the image of the car x pixels from
; the left margin of the BG
(define (render ws)
  (place-image CAR (+ (/ (image-width CAR) 2) ws -1) Y-CAR BG))


; WorldState -> WorldState
; moves the car by 3 pixels for every clock tick
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(define (tock ws)
  (+ ws 3))

; WorldState Number Number String -> WorldState
; places car at x-coordinate if me == "button-down"
;(check-expect (hyper 21 10 20 "enter") 21)
;(check-expect (hyper 45 15 20 "button-down") 15)
;(check-expect (hyper 42 10 20 "move") 42)
(define (hyper x-coord x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) (- x-mouse (/ (image-width CAR) 2))]
    [else x-coord]))


; WorldState -> Boolean
; checks whether mid-point of car has moved pass the width of the background
(check-expect (end? 30) #false)
(define (end? ws)
  (> ws (+ (/ (image-width CAR) 2) (image-width BG))))


; WorldState -> WorldState
; launches program from initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [on-mouse hyper]
            [stop-when end?]))












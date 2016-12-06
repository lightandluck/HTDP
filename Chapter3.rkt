;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Chapter3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; String -> String
; Takes string and returns the first character from it as string
; Given: "Kevin", Expect: "K"
; Given: "Hello", Expect: "H"
(define (string-first str)
  (string-ith str 0))

; String -> String
; Takes string and returns last character as string
; Given: "Kevin", Expect: "n"
; Given: "Hello", Expect: "o"
(define (string-last str)
  (substring str (- (string-length str) 1) (string-length str)))

; Image -> Number
; Takes image and returns area as number
; Given: (empty-scene 100 100), Expect: 10000
; Given: (empty-scene 20 20), Expect: 400
(define (image-area img)
  (* (image-width img) (image-height img)))

; Number -> Number
; converts Fahrenheit temp to Celsius
(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)

(define (f2c f)
  (* 5/9 (- f 32)))

; Number -> Image
; Takes number s and creates red square with length of s
(define (number->square s)
  (square s "solid" "red"))


(define (place-triangle background)
  (place-image (triangle 10 "solid" "red")
               (/ (image-width background) 2) (/ (image-height background) 2)
               background))

(define (shrink background)
  (rectangle
   (- (image-width background) 2)
   (- (image-height background) 2) "solid" "black"))


(define (stop-world background)
  (<= (image-width background) 10))

(define (reset s ke)
  BG)


; World Design Example
; 1. DEFINE CONSTANTS, RESOURCES AND CYCLES THAT ARE REGENERATIVE

; a. Physical constants
(define BG (rectangle 100 WIDTH-OF-WORLD "solid" "white"))
(define WIDTH-OF-WORLD 200)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

; b. Graphical constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-RADIUS WHEEL-RADIUS "solid" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

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
(define (render x)
  BG)

; WorldState -> WorldState
; adds 3 to x to move the car right
(define (tock x)
  x)

; WorldState -> WorldState
; launches program from initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]))












(use-modules (chickadee)
             (chickadee math vector)
             (chickadee math rect)
             (chickadee render sprite)
             (chickadee render texture)
             (chickadee sdl)
             (ice-9 match))

(define camera          #v(256.0 176.0))
(define sprite                       #f)
(define sprite_left                  #f)
(define sprite_right                 #f)
(define sprite_forward               #f)
(define sprite_w_left1               #f)
(define sprite_w_left2               #f)
(define sprite_w_right1              #f)
(define sprite_w_right2              #f)
(define sprite_backward              #f)
(define sprite_w_forward1            #f)
(define sprite_w_forward2            #f)
(define sprite_w_backward1           #f)
(define sprite_w_backward2           #f)

(define (load)
  (set! sprite_left        (load-image "users/user_left.png"))
  (set! sprite_right       (load-image "users/user_right.png"))
  (set! sprite_forward     (load-image "users/user_forward.png"))
  (set! sprite_w_left1     (load-image "users/user_w_left1.png"))
  (set! sprite_w_left2     (load-image "users/user_w_left2.png"))
  (set! sprite_w_right1    (load-image "users/user_w_right1.png"))
  (set! sprite_w_right2    (load-image "users/user_w_right2.png"))
  (set! sprite_backward    (load-image "users/user_backward.png"))
  (set! sprite_w_forward1  (load-image "users/user_w_forward1.png"))
  (set! sprite_w_forward2  (load-image "users/user_w_forward2.png"))
  (set! sprite_w_backward1 (load-image "users/user_w_backward1.png"))
  (set! sprite_w_backward2 (load-image "users/user_w_backward2.png"))
  (set! sprite             sprite_forward))

(define (draw alpha)
  (draw-sprite sprite camera))

(define (key-press key scancode modifiers repeat?)
  (match key
    ('up    (begin
              (if (equal? sprite sprite_w_backward2)
                  (set! sprite sprite_w_backward1)
                (set! sprite sprite_w_backward2))
              (set-vec2-y! camera (1+ (vec2-y camera)))))
    ('down  (begin
              (if (equal? sprite sprite_w_forward2)
                  (set! sprite sprite_w_forward1)
                (set! sprite sprite_w_forward2))
              (set-vec2-y! camera (1- (vec2-y camera)))))
    ('right (begin
              (if (equal? sprite sprite_w_right2)
                  (set! sprite sprite_w_right1)
                (set! sprite sprite_w_right2))
              (set-vec2-x! camera (1+ (vec2-x camera)))))
    ('left  (begin
              (if (equal? sprite sprite_w_left2)
                  (set! sprite sprite_w_left1)
                (set! sprite sprite_w_left2))
              (set-vec2-x! camera (1- (vec2-x camera)))))
    ('q     (abort-game))
    (_      #t)))

(define (key-release key scancode modifiers)
  (match key
    ('up    (set! sprite sprite_backward))
    ('down  (set! sprite sprite_forward))
    ('right (set! sprite sprite_right))
    ('left  (set! sprite sprite_left))
    (_      #t)))

(run-game/sdl #:load load #:draw draw #:key-press key-press #:key-release key-release)

(defpackage :adventofcode-2023.challenges.day-02
  (:use :cl :arrow-macros :cl-ppcre)
  (:export :main
           :game->colors
           :is-good-game
           :sum-good-games
           :get-minimal-game
           :sum-minimal-games))
(in-package :adventofcode-2023.challenges.day-02)

(defun flatten (l)
  (if (atom l)
    (list l)
    (append (flatten (car l)) (if (cdr l) (flatten (cdr l))))))

(defun game->colors (game)
  (->> game
       (ppcre:split ":")
       #'rest
       #'first
       (ppcre:split ";")
       (mapcar #'(lambda (colors)
                   (ppcre:split "," colors)))
       #'flatten
       (mapcar #'(lambda (colors)
                   (->> colors
                        (string-trim '(#\Space))
                        (ppcre:split " "))))
       (map 'list #'(lambda (cur)
                      (let ((color (first (last cur)))
                            (value (parse-integer (first cur))))
                        (cons color value))))))

;; Part 1
(defun is-good-game (game)
  (-<>> game
        #'game->colors
        (reduce #'(lambda (acc cur)
                    (let ((color (first cur))
                          (value (cdr cur)))
                      (or acc 
                          (and (string= color "red")
                               (> value 12))
                          (and (string= color "green")
                               (> value 13))
                          (and (string= color "blue")
                               (> value 14)))))
                <>
                :initial-value nil)
        #'not))

(defun sum-good-games (games) 
  (->> games
       (remove-if-not #'is-good-game)
       (map 'list #'(lambda (game)
                      (-<>> game
                            (ppcre:split ":")
                            #'first
                            (ppcre:regex-replace "Game " <> "")
                            #'parse-integer)))
       (reduce #'+)))

;; Part 2
(defun get-minimal-game (game)
  (-<>> game
        #'game->colors
        (reduce #'(lambda (acc cur)
                    (let* ((color (first cur))
                           (cur-value (cdr cur))
                           (acc-value (cdr (assoc color acc :test #'string=))))
                      (when (> cur-value (or acc-value 0))
                        (rplacd (assoc color acc :test #'string=) cur-value))
                      acc))
                <> 
                :initial-value (list (cons "green" NIL)
                                     (cons "blue" NIL)
                                     (cons "red" NIL)))
        (reduce #'(lambda (acc cur) (* (cdr cur) acc)) <> :initial-value 1)))

(defun sum-minimal-games (games)
  (->> games
       (map 'list #'get-minimal-game)
       (reduce #'+)))

(defun main (part)
  (let ((value part))
    (cond ((string= value '"part-1") (->> "resources/day-02/input.txt"
                                          #'uiop:read-file-lines
                                          #'sum-good-games))
          ((string= value '"part-2") (->> "resources/day-02/input.txt"
                                          #'uiop:read-file-lines
                                          #'sum-minimal-games)))))

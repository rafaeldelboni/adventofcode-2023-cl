(defpackage :adventofcode-2023.challenges.day-01
  (:use :cl :uiop :arrow-macros :cl-ppcre)
  (:export :main
           :line->first-last-digits
           :calibration-list->total-sum
           :calibration-list->total-sum-with-spelled-digits))
(in-package :adventofcode-2023.challenges.day-01)

;; Part 1
(defun line->first-last-digits (line)
  ;; let* behaves like clojure let
  ;; in common lisp, let run all var forms in parallel
  ;; let* is sequential allowing to use pre declared vars in another var declaration
  (let* ((line-numbers (remove-if-not #'digit-char-p line))
         (first-number (char line-numbers 0))
         (last-number (char line-numbers (1- (length line-numbers)))))
    (-> (concatenate 'string
                     (string first-number)
                     (string last-number))
        #'parse-integer)))

(defun calibration-list->total-sum (calibration-list) 
  (->> calibration-list
       (mapcar #'line->first-last-digits)
       (reduce #'+)))

;; Part 2

;; Ugly way to solve this, maybe I found a issue with the regex lib 
;; https://github.com/edicl/cl-ppcre/issues/54
(defun line-spelled-digits->line-digits (line)
  (-<> line
       (cl-ppcre:regex-replace-all "one" <> "o1ne")
       (cl-ppcre:regex-replace-all "two" <> "t2wo")
       (cl-ppcre:regex-replace-all "three" <> "th3ree")
       (cl-ppcre:regex-replace-all "four" <> "fo4ur")
       (cl-ppcre:regex-replace-all "five" <> "fi5ve")
       (cl-ppcre:regex-replace-all "six" <> "s6ix")
       (cl-ppcre:regex-replace-all "seven" <> "se7ven")
       (cl-ppcre:regex-replace-all "eight" <> "ei8ght")
       (cl-ppcre:regex-replace-all "nine" <> "ni9ne")))

(defun calibration-list->total-sum-with-spelled-digits (calibration-list) 
  (->> calibration-list
       (mapcar #'line-spelled-digits->line-digits)
       (mapcar #'line->first-last-digits)
       (reduce #'+)))

(defun main (part)
  (let ((value part))
    (cond ((string= value '"part-1") (-> "resources/day-01/input.txt"
                                         #'uiop:read-file-lines
                                         #'calibration-list->total-sum))
          ((string= value '"part-2") (-> "resources/day-01/input.txt"
                                         #'uiop:read-file-lines
                                         #'calibration-list->total-sum-with-spelled-digits)))))

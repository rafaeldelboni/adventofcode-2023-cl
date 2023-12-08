(defpackage :adventofcode-2023.challenges.day-03
  (:use :cl :arrow-macros)
  (:export :main))
(in-package :adventofcode-2023.challenges.day-03)

(defun main (part)
  (let ((value part))
    (cond ((string= value '"part-1") (->> "resources/day-03/sample.txt"
                                          #'uiop:read-file-lines))
          ((string= value '"part-2") "not implemented"))))

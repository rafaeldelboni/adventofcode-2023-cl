(defpackage :adventofcode-2023.challenges.day-03-tests
  (:use :common-lisp
        :fiveam
        :adventofcode-2023.challenges.day-03))
(in-package :adventofcode-2023.challenges.day-03-tests)

(def-suite test-day-03
           :description "test suite day 03")

(in-suite test-day-03)

(test test-dummy
      (is (= 48
             48)))

 ;; (run! 'test-day-03)

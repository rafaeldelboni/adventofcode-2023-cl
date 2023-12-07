(defpackage :adventofcode-2023.challenges.day-01-tests
  (:use :common-lisp
        :fiveam
        :adventofcode-2023.challenges.day-01))
(in-package :adventofcode-2023.challenges.day-01-tests)

(def-suite test-day-01
    :description "test suite day 01")

(in-suite test-day-01)

(test test-line->first-last-digits
      (is (= (adventofcode-2023.challenges.day-01:line->first-last-digits "pqr3stu8vwx")
             38))
      (is (= (adventofcode-2023.challenges.day-01:line->first-last-digits "treb7uchet")
             77)))

(test test-calibration-list->total-sum
      (is (= (adventofcode-2023.challenges.day-01:calibration-list->total-sum '("pqr3stu8vwx"
                                                                                "treb7uchet"))
             115)))

(test test-calibration-list->total-sum-with-spelled-digits
      (is (= (adventofcode-2023.challenges.day-01:calibration-list->total-sum-with-spelled-digits '("pqr3stu8vwx"
                                                                                                    "treb7uchet"))
             115))
      (is (= (adventofcode-2023.challenges.day-01:calibration-list->total-sum-with-spelled-digits '("eighthree"
                                                                                                    "sevenine"))
             162)))

;; (run! 'test-day-01)

(defpackage :adventofcode-2023-tests
  (:use :common-lisp
        :fiveam
        :adventofcode-2023))
(in-package :adventofcode-2023-tests)

(def-suite testmain
    :description "test suite for main file")

(in-suite testmain)

(test dummy-test
  (is (= (+ 1 1)
         2)))

;; (run 'testmain)
;; (run-all-tests)

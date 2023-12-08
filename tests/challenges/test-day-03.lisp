(defpackage :adventofcode-2023.challenges.day-03-tests
  (:use :common-lisp
        :fiveam
        :adventofcode-2023.challenges.day-03))
(in-package :adventofcode-2023.challenges.day-03-tests)

(def-suite test-day-03
           :description "test suite day 03")

(in-suite test-day-03)

(test test-partitions
      (is (equal (partitions '(1 2 3 4 5 6 7 8 9) 2)
                 '((9) (7 8) (5 6) (3 4) (1 2))))
      (is (equal (partitions '(1 2 3 4 5 6 7 8 9) 3)
                 '((7 8 9) (4 5 6) (1 2 3)))))

(test test-idx-in-range
      (is (equal (assoc 6 '(((5 8) . "114") ((0 3) . "467"))
                        :test #'idx-in-range)
                 '((5 8) . "114"))))

(test test-idx-in-range-remove
      (is (equal (remove 6 '(((5 8) . "114") ((0 3) . "467") ((9 12) . "123"))
                         :test #'idx-in-range-remove)
                 '(((0 3) . "467") ((9 12) . "123")))))

(test test-lines->range-number-alist
      (is (equal (lines->range-number-alist (list "467..114.."
                                                  "...*......" "..35..633."))
                 '((((5 8) . "114") ((0 3) . "467"))
                   NIL
                   (((6 9) . "633") ((2 4) . "35"))))))

(test test-map-index
      (is (equal (map-index 'list (lambda (x a) (cons x a))
                            (list "467..114.." "...*......"))
                 '((0 . "467..114..") (1 . "...*......")))))

(test test-get-search-range
      (is (equal (get-search-range 1 5)
                 '(0 1 2)))
      (is (equal (get-search-range 8 8)
                 '(7 8)))
      (is (equal (get-search-range 0 8)
                 '(0 1))))

 ;; (run! 'test-day-03)

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
                 '((((5 7) . "114") ((0 2) . "467"))
                   NIL
                   (((6 8) . "633") ((2 3) . "35"))))))

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

(test test-line->symbol-coords
      (is (equal (line->symbol-coords 0 "617*...$..")
                 '((0 . 3) (0 . 7)))))

(test test-indexed-symbols->search-coords
      (is (equal (indexed-symbols->search-coords 9 9 '((1 . 3) (3 . 6)))
                 '((0 2 3 4) (1 2 3 4) (2 2 3 4) (2 5 6 7) (3 5 6 7) (4 5 6 7)))))

(test test-indexed-cogs->search-coords
      (is (equal (indexed-cogs->search-coords 9 9 '((1 . 3) (4 . 6)))
                 '(((1 . 3) 0 2 3 4)
                   ((1 . 3) 1 2 3 4)
                   ((1 . 3) 2 2 3 4)
                   ((4 . 6) 3 5 6 7)
                   ((4 . 6) 4 5 6 7)
                   ((4 . 6) 5 5 6 7)))))

(test test-find-adjacent-digits
      (is (equal (find-adjacent-digits
                   (map-index 'list #'cons
                              '((((5 7) . "114") ((0 2) . "467"))
                                NIL (((6 8) . "633") ((2 3) . "35"))
                                NIL (((0 2) . "617")) (((7 8) . "58")) (((2 4) . "592"))
                                (((6 8) . "755")) NIL (((5 7) . "598") ((1 3) . "664"))))
                   '((0 2 3 4) (1 2 3 4) (2 2 3 4) (2 5 6 7) (3 5 6 7) (4 5 6 7) (3 2 3 4)
                               (4 2 3 4) (5 2 3 4) (4 4 5 6) (5 4 5 6) (6 4 5 6) (7 2 3 4) (8 2 3 4)
                               (9 2 3 4) (7 4 5 6) (8 4 5 6) (9 4 5 6)))
                 4361)))

;; (run! 'test-day-03)

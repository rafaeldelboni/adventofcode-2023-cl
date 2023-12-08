(defpackage :adventofcode-2023.challenges.day-03
  (:use :cl :uiop :arrow-macros :cl-ppcre)
  (:export :main
           :partitions
           :idx-in-range
           :idx-in-range-remove
           :lines->range-number-alist
           :map-index
           :get-search-range))
(in-package :adventofcode-2023.challenges.day-03)

(defun partitions (input-list size &optional out)
  (if (> (length input-list) 0)
    (partitions (nthcdr size input-list)
                size
                (if (> (length input-list) size)
                  (push (subseq input-list 0 size) out)
                  (push (subseq input-list 0 (length input-list)) out)))
    out))

(defun lines->range-number-alist (lines)
  (->> lines
       (mapcar #'(lambda (line)
                   (let ((matches (cl-ppcre:all-matches "\\d+" line)))
                     (when matches
                       (pairlis
                         (reverse (partitions matches 2))
                         (cl-ppcre:all-matches-as-strings "\\d+" line))))))))

;; (setq sample
;;       (list "467..114.."
;;             "...*......"
;;             "..35..633."
;;             "......#..."
;;             "617*......"
;;             ".....+.58."
;;             "..592....."
;;             "......755."
;;             "...$.*...."
;;             ".664.598.."))
;; (lines->range-number-alist sample)

(defun idx-in-range (index range)
  (and (>= index (first range))
       (<= index (first (cdr range)))))

(defun idx-in-range-remove (index range)
  (and (>= index (first (first range)))
       (<= index (first (last (first range))))))

(defun map-index (type fn &rest seqs)
  (let ((index -1))
    (apply #'map
           type
           (lambda (&rest args)
             (incf index)
             (apply fn index args))
           seqs)))

(defun get-search-range (index max-lenght)
  (remove-if-not #'identity
             (list (when (>= (1- index) 0) (1- index))
                   index
                   (when (<= (1+ index) max-lenght) (1+ index)))))

(defun main (part)
  (let ((value part))
    (cond ((string= value '"part-1") (->> "resources/day-03/sample.txt"
                                          #'uiop:read-file-lines))
          ((string= value '"part-2") "not implemented"))))

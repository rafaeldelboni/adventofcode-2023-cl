(defpackage :adventofcode-2023.challenges.day-03
  (:use :cl :uiop :arrow-macros :cl-ppcre)
  (:export :main
           :partitions
           :idx-in-range
           :idx-in-range-remove
           :lines->range-number-alist
           :map-index
           :get-search-range
           :line->symbol-coords
           :indexed-symbols->search-coords
           :find-adjacent-digits
           :lines->sum-symbol-adjacent-digits
           :line->cog-coords
           :indexed-cogs->search-coords))
(in-package :adventofcode-2023.challenges.day-03)

(defun map-index (type fn &rest seqs)
  (let ((index -1))
    (apply #'map
           type
           (lambda (&rest args)
             (incf index)
             (apply fn index args))
           seqs)))

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
                   (let ((matches (->> (cl-ppcre:all-matches "\\d+" line)
                                       ;; ppcre return end coords incremented by 1
                                       ;; this decrements it for sanity
                                       (map-index 'list #'(lambda (idx cur)
                                                            (if (oddp idx)
                                                              (decf cur)
                                                              cur))))))
                     (when matches
                       (pairlis
                         (reverse (partitions matches 2))
                         (cl-ppcre:all-matches-as-strings "\\d+" line))))))))

(defun idx-in-range (index range)
  (and (>= index (first range))
       (<= index (first (cdr range)))))

(defun idx-in-range-remove (index range)
  (and (>= index (first (first range)))
       (<= index (first (last (first range))))))


(defun get-search-range (index max-lenght)
  (remove-if-not #'identity
                 (list (when (>= (1- index) 0) (1- index))
                       index
                       (when (<= (1+ index) max-lenght) (1+ index)))))

(defun line->symbol-coords (index line)
  (-<> (cl-ppcre:all-matches "[^\\s\\d\\.]" line)
       (partitions 2)
       (mapcar #'(lambda (line)
                   (cons index (first line))) <>)
       reverse))

(defun indexed-symbols->search-coords (num-lines num-columns indexed-symbols)
  (->> indexed-symbols
       (map 'list
            #'(lambda (cur) 
                (map 'list #'(lambda (lines) (cons lines (get-search-range (cdr cur) num-columns)))
                     (get-search-range (first cur) num-lines))))
       (reduce #'append)))

(defun find-adjacent-digits (indexed-digits search-coords)
  (->> (mapcar
         #'(lambda (line-coord)
             (mapcar #'(lambda (coord)
                         (let* ((current-line (cdr (assoc (first line-coord) indexed-digits)))
                                (found-digit (cdr (assoc coord current-line :test #'idx-in-range))))
                           (rplacd (assoc (first line-coord) indexed-digits)
                                   (remove coord current-line :test #'idx-in-range-remove))
                           found-digit))
                     (rest line-coord)))
         search-coords)
       (reduce #'append)
       (remove-if-not #'identity)
       (mapcar #'parse-integer)
       (reduce #'+)))

(defun lines->sum-symbol-adjacent-digits (lines)
  (let* ((num-lines (length lines))
         (num-columns (length (first lines)))
         (indexed-digits (map-index 'list #'cons (lines->range-number-alist lines)))
         (search-coords (->> lines
                             (map-index 'list #'line->symbol-coords)
                             (reduce #'append)
                             (indexed-symbols->search-coords num-lines num-columns))))
    (find-adjacent-digits indexed-digits search-coords)))

;; part 2

(defun line->cog-coords (index line)
  (-<> (cl-ppcre:all-matches "[/\*]" line)
       (partitions 2)
       (mapcar #'(lambda (line)
                   (cons index (first line))) <>)
       reverse))

(defun indexed-cogs->search-coords (num-lines num-columns indexed-symbols)
  (->> indexed-symbols
       (map 'list
            #'(lambda (cur)
                (map 'list #'(lambda (lines)
                               (cons cur (cons lines (get-search-range (cdr cur) num-columns))))
                     (get-search-range (first cur) num-lines))))
       (reduce #'append)))

(defun find-cog-adjacent-digits (indexed-digits search-coords)
  (-<>> (mapcar
          #'(lambda (line-coord)
              (mapcar #'(lambda (coord)
                          (let* ((current-cog (first line-coord))
                                 (current-line (cdr (assoc (second line-coord) indexed-digits)))
                                 (found-digit (cdr (assoc coord current-line :test #'idx-in-range))))
                            (when found-digit
                              (cons current-cog found-digit))))
                      (rest (rest line-coord))))
          search-coords)
        (reduce #'append)
        (remove-if-not #'identity)
        (reduce #'(lambda (acc cur)
                    (let ((cog-digit-found (assoc (first cur) acc :test #'equal)))
                      (if cog-digit-found
                        (progn ; like clojure do block
                          (rplacd cog-digit-found
                                  (append (cdr cog-digit-found)
                                          (list (cdr cur))))
                          acc)
                        (append acc (list (cons (first cur) (list (cdr cur))))))))
                <> :initial-value nil)
        (mapcar #'(lambda (line)
                           (cons (first line) (remove-duplicates (rest line)))))
        (remove-if-not #'(lambda (line) (= (length (cdr line)) 2)))
        (mapcar #'(lambda (line)
                    (* (parse-integer (first (cdr line)))
                       (parse-integer (first (last (cdr line)))))))
        (reduce #'+)))

(defun lines->sum-cogs-adjacent-digits (lines)
  (let* ((num-lines (length lines))
         (num-columns (length (first lines)))
         (indexed-digits (map-index 'list #'cons (lines->range-number-alist lines)))
         (search-coords (->> lines
                             (map-index 'list #'line->cog-coords)
                             (reduce #'append)
                             (indexed-cogs->search-coords num-lines num-columns))))
    (find-cog-adjacent-digits indexed-digits search-coords)))

(defun main (part)
  (let ((value part))
    (cond ((string= value '"part-1") (->> "resources/day-03/input.txt"
                                          #'uiop:read-file-lines
                                          #'lines->sum-symbol-adjacent-digits))
          ((string= value '"part-2") (->> "resources/day-03/input.txt"
                                          #'uiop:read-file-lines
                                          #'lines->sum-cogs-adjacent-digits)))))

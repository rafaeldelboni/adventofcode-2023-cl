(defpackage :adventofcode-2023
  (:use :cl)
  ;; (:import-from :adventofcode-2023.challenges.day-01 :main)
  (:export :main))
(in-package :adventofcode-2023)

(defun solve (challenge part)
  (let ((value challenge)) 
    (cond ((string= value '"day-01") (print (adventofcode-2023.challenges.day-01:main part)))
          ((string= value '"day-02") (print (adventofcode-2023.challenges.day-02:main part))))))

(defun help ()
  (format t "~&Usage:

  adventofcode-2023 [day]
  adventofcode-2023 [day] [part]

  Eg.:
  adventofcode-2023 day-01
  adventofcode-2023 day-01 part-1 ~&"))

(defun %main (argv)
  "Parse CLI args."
  (when (member "-h" argv :test #'equal)
    ;; To properly parse command line arguments, use a third-party library such as
    ;; clingon, unix-opts, defmain, adopt… when needed.
    (help)
    (uiop:quit))
  (if (>= (length argv) 1)
    (solve (nth 0 argv)
           (or (nth 1 argv) "part-1"))
    (help)))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))

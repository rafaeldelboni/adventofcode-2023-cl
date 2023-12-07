(load "adventofcode-2023.asd")

(ql:quickload "adventofcode-2023")

(in-package :adventofcode-2023)

(defun exec-and-quit ()
  (main)
  (uiop:quit 0))

(handler-case
  (exec-and-quit)
  (error (c)
    (format *error-output* "~&An error occured: ~a~&" c)
    (uiop:quit 1)))

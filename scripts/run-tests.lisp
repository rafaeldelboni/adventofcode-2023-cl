(load "adventofcode-2023.asd")
(load "adventofcode-2023-tests.asd")

(ql:quickload "adventofcode-2023-tests")

(in-package :adventofcode-2023-tests)

(uiop:quit (if (run-all-tests) 0 1))

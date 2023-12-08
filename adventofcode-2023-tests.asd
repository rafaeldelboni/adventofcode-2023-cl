(in-package :cl-user)
(defpackage adventofcode-2023-test-asd
  (:use :cl :asdf))
(in-package :adventofcode-2023-test-asd)

(defsystem "adventofcode-2023-tests"
  :description "Test suite for the adventofcode-2023 system"
  :author "Rafael Delboni <rafael@delboni.cc>"
  :version "0.0.1"
  :depends-on (:adventofcode-2023
               :fiveam)
  :serial t
  :components ((:module "tests"
                        :serial t
                        :components ((:module "challenges"
                                              :components ((:file "test-day-01")
                                                           (:file "test-day-02")
                                                           (:file "test-day-03")))
                                     (:file "test-adventofcode-2023"))))

  ;; The following would not return the right exit code on error, but still 0.
  ;; :perform (test-op (op _) (symbol-call :fiveam :run-all-tests))
  )

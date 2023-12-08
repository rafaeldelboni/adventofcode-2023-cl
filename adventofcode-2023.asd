(in-package :cl-user)
(defpackage adventofcode-2023-asd
  (:use :cl :asdf))
(in-package :adventofcode-2023-asd)

(defsystem "adventofcode-2023"
  :description "Codes for Advent of Code 2023"
  :author "Rafael Delboni <rafael@delboni.cc>"
  :version "0.0.1"

  ;; Dependencies.
  :depends-on (:uiop :arrow-macros :cl-ppcre)

  ;; Project stucture.
  :serial t
  :components ((:module "src"
                        :serial t
                        :components ((:module "challenges"
                                              :components ((:file "day-01")
                                                           (:file "day-02")))
                                     (:file "adventofcode-2023"
                                            :depends-on ("challenges")))))

  ;; Build a binary:
  ;; don't change this line.
  :build-operation "program-op"
  ;; binary name: adapt.
  :build-pathname "target/adventofcode-2023"
  ;; entry point: here "main" is an exported symbol. Otherwise, use a double ::
  :entry-point "adventofcode-2023:main")

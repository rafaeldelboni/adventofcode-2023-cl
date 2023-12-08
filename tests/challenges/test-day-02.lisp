(defpackage :adventofcode-2023.challenges.day-02-tests
  (:use :common-lisp
        :fiveam
        :adventofcode-2023.challenges.day-02)
  (:import-from #:adventofcode-2023.challenges.day-02
                #:game->colors
                #:is-good-game
                #:sum-good-games))
(in-package :adventofcode-2023.challenges.day-02-tests)

(def-suite test-day-02
           :description "test suite day 02")

(in-suite test-day-02)

(test test-game->colors
      (is (equal (game->colors "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
                 '(("blue" . 3) ("red" . 4) ("red" . 1) ("green" . 2) ("blue" . 6) ("green" . 2)))))

(test test-is-good-game
      (is-true (is-good-game "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"))
      (is-false (is-good-game "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red")))

(test test-sum-good-games
      (is (= (sum-good-games (list "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
                                   "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
                                   "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"))
             3)))

(test test-get-minimal-game
      (is (= (get-minimal-game "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
             48)))

(test test-sum-good-games
      (is (= (sum-minimal-games (list "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
                                      "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
                                      "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"))
             1620)))

;; (run! 'test-day-02)

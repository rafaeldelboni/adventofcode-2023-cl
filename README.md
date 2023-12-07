# adventofcode-2023

# Resources
- https://hyperpolyglot.org/lisp

# Prerequisites
Things you need installed in your OS to use this setup
- [make](https://www.gnu.org/software/make/)
- [roswell](https://github.com/roswell/roswell)
    - After installed you can install an common lisp implementation: `ros use sbcl-bin`

# Usage

## Run
Run from sources:
```bash
make run
# ros run --load scripts/run.lisp
```

## Build
Build and run the binary:
```bash
make build
./target/adventofcode-2023 [name]
# Hello [name] from adventofcode-2023
```

# Dev

## Select Lisp
Choose your lisp (inside [Makefile](Makefile)) currently using [Roswell](https://github.com/roswell/roswell):
```bash
LISP=ccl make run
# LISP ?= ros run
```

## Tests
Tests are defined with [Fiveam](https://common-lisp.net/project/fiveam/docs/).

Run them from the terminal with `make test`
```bash
make test
# ros run --load scripts/run-tests.lisp
```

## Repl
Run swank server repl
```bash
make repl
# ros run --load scripts/repl.lisp
```

# License
This is free and unencumbered software released into the public domain.
For more information, please refer to <http://unlicense.org>

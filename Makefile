LISP ?= ros run

all: test

run:
	$(LISP) --non-interactive \
		--load scripts/run.lisp

build:
	$(LISP) --non-interactive \
		--load scripts/build.lisp

test:
	$(LISP) --non-interactive \
		--load scripts/run-tests.lisp

repl:
	$(LISP) --load scripts/repl.lisp

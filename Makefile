SHELL := /bin/bash
BIN := node_modules/.bin/

build: dist/creditcardutils.js dist/creditcardutils.min.js

dist/creditcardutils.js: src/creditcardutils.coffee
	$(BIN)coffee -c --no-header -o dist/ src/creditcardutils.coffee

dist/creditcardutils.min.js: dist/creditcardutils.js
	$(BIN)uglify -s dist/creditcardutils.js -o dist/creditcardutils.min.js

watch: build
	$(BIN)watch 'make build' src

test:
	$(BIN)mocha test/**_spec.coffee

clean:
	rm -rf dist/*.js

.PHONY: build test watch

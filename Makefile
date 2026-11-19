.PHONY: build native wasm check test cli-test fmt

build: native wasm

native:
	moon build --target native --release
	mkdir -p bin
	cp _build/native/release/build/actionlint.exe bin/actionlint

wasm:
	moon build --target wasm --release
	mkdir -p bin
	cp _build/wasm/release/build/actionlint.wasm bin/actionlint.wasm

check:
	moon check --target native
	moon check --target wasm

test:
	moon test --target native
	moon test --target wasm

cli-test: build
	node scripts/test_cli.mjs --release
	node scripts/test_cli.mjs --release --target wasm
	node scripts/test_behavior.mjs --target all

fmt:
	moon info
	moon fmt

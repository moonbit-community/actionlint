.PHONY: build native wasm check test testcli cli-test fmt

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
	moon check --target native --deny-warn
	moon check --target wasm --deny-warn

test:
	moon test --target native
	moon test --target wasm

testcli:
	ACTIONLINT_TEST_TARGET=native moon testcli test tests/cli --target native
	ACTIONLINT_TEST_TARGET=wasm moon testcli test tests/cli --target wasm

cli-test: build
	$(MAKE) testcli

fmt:
	moon info
	moon fmt

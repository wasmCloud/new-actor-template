COLOR ?= always # Valid COLOR options: {always, auto, never}
CARGO = cargo --color $(COLOR)
TARGET = target/wasm32-unknown-unknown
DEBUG = $(TARGET)/debug
RELEASE = $(TARGET)/release
KEYDIR ?= .keys

.PHONY: all build check clean doc test update

all: build

build:
	@$(CARGO) build
	VERSION=$(cargo metadata --no-deps --format-version 1 | jq -r '.packages[].version')
    wash claims sign $(DEBUG)/{{crate_name}}.wasm -q --name "New Actor" --ver $VERSION --rev 0	

check:
	@$(CARGO) check

clean:
	@$(CARGO) clean

doc:
	@$(CARGO) doc

test: build
	@$(CARGO) test

update:
	@$(CARGO) update

release:
	@$(CARGO) build --release
	VERSION=$(cargo metadata --no-deps --format-version 1 | jq -r '.packages[].version')
    wash claims sign $(RELEASE)/{{crate_name}}.wasm -q --name "New Actor" --ver $VERSION --rev 0
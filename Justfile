#!/usr/bin/env just --justfile

default:
    @just --list

init:
    kcl mod update

fmt:
    kcl fmt ./...

lint:
    set -e; for d in . input management metadata output support team; do (cd "$d" && kcl lint .); done

export:
    kcl product.k --format yaml > product.yaml

# The gate that matters for a tutorial: it still builds against the library
# version it pins, and the exported document committed here is what that
# build actually produces. A stale product.yaml means the tutorial teaches
# something the library no longer does.
check:
    kcl fmt ./...
    git diff --exit-code -- '*.k' || (echo "Code is not formatted — run 'just fmt' and commit the result." && exit 1)
    just lint
    just export
    git diff --exit-code -- product.yaml || (echo "product.yaml is stale — run 'just export' and commit the result." && exit 1)

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

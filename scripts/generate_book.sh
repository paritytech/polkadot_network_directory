#!/usr/bin/env bash

tera --template summary.md.tera chains.json > directory/src/SUMMARY.md
pushd directory > /dev/null
mdbook build

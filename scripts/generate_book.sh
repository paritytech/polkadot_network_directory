#!/usr/bin/env bash

tera --template templates/home.md.tera directory/src/chains.json --include --include-path chain_data > directory/src/HOME.md
tera --template templates/summary.md.tera directory/src/chains.json --include > directory/src/SUMMARY.md
mdbook build directory/

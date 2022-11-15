#!/usr/bin/env bash

tera --template templates/home.md.tera directory/src/chains.json > directory/src/HOME.md
tera --template templates/summary.md.tera directory/src/chains.json > directory/src/SUMMARY.md
mdbook build directory/
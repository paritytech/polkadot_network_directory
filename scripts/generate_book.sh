#!/usr/bin/env bash

# Generate date, commit and footer
export DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export COMMIT=$(git rev-parse HEAD)

tera --template templates/home.md.tera directory/src/chains.json --include --env --env-key env > directory/src/HOME.md
tera --template templates/summary.md.tera directory/src/chains.json --include --env --env-key env  > directory/src/SUMMARY.md

mdbook build directory/

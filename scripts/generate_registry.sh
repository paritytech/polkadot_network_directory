#!/usr/bin/env bash

PATH_REG="directory/src/"
TEMPLATE="templates/registry.json.tera"

# Generate date, commit and footer
export DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export COMMIT=$(git rev-parse HEAD > chain_data/commit)

mkdir -p "$PATH_REG"

pwd
tera --template "$TEMPLATE" directory/src/chains.json --include --env --env-key env | jq > "$PATH_REG/registry.json"

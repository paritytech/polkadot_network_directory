#!/usr/bin/env bash

PATH_REG="directory/src/"
TEMPLATE="templates/registry.json.tera"

mkdir -p "$PATH_REG"

pwd
tera --template "$TEMPLATE" directory/src/chains.json | jq > "$PATH_REG/registry.json"

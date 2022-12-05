#!/usr/bin/env bash

PATH_INFO="chain_info"
PATH_DATA="../chain_data"
PATH_MD="../directory/src/chains"
TEMPLATE="templates/registry.json.tera"

mkdir -p "$PATH_DATA"
mkdir -p "$PATH_MD"

pwd
tera --template "$TEMPLATE" directory/src/chains.json | jq > "../directory/src/registry.json"

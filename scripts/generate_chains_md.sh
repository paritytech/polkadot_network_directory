#!/usr/bin/env bash

# Loop thru the files in `chain_info`, extract some information
# then generate the markdown for the chains.

PATH_INFO="chain_info"
PATH_DATA="../chain_data"
PATH_MD="../directory/src/chains"
TEMPLATE="../templates/one.md.tera"

mkdir -p "$PATH_DATA"
mkdir -p "$PATH_MD"

pushd "$PATH_INFO" > /dev/null
for f in *.yaml
do
    # echo "Found $f"
    chain_name=$(cat "$f" | yq -r .name)
    chain_type=$(cat "$f" | yq -r .chain.type)
    chain_parent=$(cat "$f" | yq -r .chain.parent)

    echo "Processing $chain_name..."
    if [[ "$chain_type" ==  "relaychain" ]]; then
        DIR="$chain_name"
    else
        DIR="$chain_parent"
    fi
    mkdir -p "$PATH_MD/$DIR"

    tera --template "$TEMPLATE" "$f" > "$PATH_MD/$DIR/$chain_name.md"
done

#!/usr/bin/env bash

# Loop thru the files in `chain_info`, extract some information
# then generate the markdown for the chains.

PATH_INFO="chain_info"
PATH_DATA="../chain_data"
PATH_MD="../directory/src/chains"
TEMPLATE="../templates/one.md.tera"

mkdir -p "$PATH_DATA"
mkdir -p "$PATH_MD"

# Generate date, commit and footer
export DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export COMMIT=$(git rev-parse HEAD)

pushd "$PATH_INFO" > /dev/null
for f in *.yaml
do
    # echo "Found $f"
    chain_name=$(cat "$f" | yq -r .name | sed 's/ /_/g' )
    chain_type=$(cat "$f" | yq -r .chain.type)
    chain_parent=$(cat "$f" | yq -r .chain.parent)

    echo "Processing $chain_name..."
    if [[ "$chain_type" ==  "relaychain" ]] || [[ "$chain_type" == "solo" ]]; then
        DIR="$chain_name"
    else
        DIR="$chain_parent"
    fi
    mkdir -p "$PATH_MD/$DIR"

    echo " Rendering $f as $PATH_MD/$DIR/$chain_name.md"
    tera --template "$TEMPLATE" "$f" --include --env --env-key env > "$PATH_MD/$DIR/$chain_name.md"
done

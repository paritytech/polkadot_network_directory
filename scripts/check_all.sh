#!/usr/bin/env bash

find chain_info -name "*.yaml" | while read -r f; do
    yamlcheck check -s ./schemas/pnd_chain-schema.json --file "$f" > /dev/null
    res=$?
    if (( res == 0 )) then
        status="OK "
    else
        status="ERR"
    fi
    echo "$status : $f"
done

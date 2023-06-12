#!/usr/bin/env bash

if ! which yamlcheck >/dev/null; then
    cargo install yamlcheck
fi
echo "Using yamlcheck $(yamlcheck --version)"

overall_tmp=$(mktemp)

echo 0 > $overall_tmp
find chain_info -name "*.yaml" | while read -r f; do
    yamlcheck check -s ./schemas/pnd_chain-schema.json --file "$f" > /dev/null
    res=$?
    if (( res == 0 )); then
        status="OK "
    else
        status="ERR"
        echo 1 > $overall_tmp
    fi
    short_name=$(basename "$f" | cut -d "." -f1)

    echo "$status : $short_name"
done

overall=$(cat $overall_tmp)
exit $overall

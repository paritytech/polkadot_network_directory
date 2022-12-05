# Set global variables
export chains_json := "directory/src/chains.json"
export registry_json := "directory/src/registry.json"

# List available commands
_default:
	just --choose --chooser "fzf +s -x --tac --cycle"

help:
	just --list

# Generate a json file with the information from all the chains
concat_json:
	@yq ea '[.]' chain_info/*.yaml | yq ea -o=j '{"chains": .}' > $chains_json

# Render all chains, we probably don't need that
_render_chains: concat_json
	@tera --template templates/many.md.tera $chains_json

_render_summary: concat_json
    @tera --template templates/SUMMARY.md.tera $chains_json

_render_rpc_registry: concat_json
    tera --template templates/registry.json.tera $chains_json | jq > $registry_json

# Fetch data onchain
fetch_data chain:
	echo TODO
	echo Fetching data for {{chain}}

# Render the book
render: concat_json _render_rpc_registry
	./scripts/generate_chains_md.sh
	./scripts/generate_book.sh
	./scripts/generate_registry.sh

# Serve the book locally
serve:
	#!/usr/bin/env bash
	pushd directory
	mdbook serve

# Cleanup generated files
clean:
	rm -rf directory/book
	rm -rf directory/src/chains
	rm -rf directory/src/SUMMARY.md

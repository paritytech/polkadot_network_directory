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
	./scripts/generate_chains_md.sh

_render_book: concat_json
    ./scripts/generate_book.sh

_render_rpc_registry: concat_json
    ./scripts/generate_registry.sh

# Fetch data onchain
fetch_data chain:
	echo TODO
	echo Fetching data for {{chain}}

# Render the book
render: concat_json _render_rpc_registry _render_chains _render_book

# Serve the book locally
serve:
	#!/usr/bin/env bash
	pushd directory || exit
	open http://localhost:3000/
	mdbook serve

# watch the files under the chain_info and render them
watch: 
	watchexec -w chain_info -- just render

# Cleanup generated files
clean:
	rm -rf directory/book
	rm -rf directory/src/chains
	rm -rf directory/src/SUMMARY.md

# Polkadot Network Directory

Documentation about Chains of the Polkadot and Kusama networks

## Install tooling

- [`yq`](https://github.com/mikefarah/yq)
- [`tera`](https://github.com/chevdor/tera-cli)
- [`mdbook`](https://github.com/rust-lang/mdBook)
- [`just`](https://github.com/casey/just)
- [`watchexec`](https://github.com/watchexec/watchexec)

## Folders

- `chain_info`: General information about chains in `yaml` format
- `chain_data`: Data fetched onchain based on the `chain_info` (currently unused)

## General idea

```
     chain_foo.yaml   \
     chain_bar.yaml    }    chains.json            }     mdbook
     chain_baz.yaml   /     markdown per chain    /

```

## Usage

You can refresh the book using:

     just render

You can automatically watch the changes by using:

     just watch

If you want to serve a page showing the result, in another terminal, you may run:

     just serve

## Editing content

The **only** content that needs editing are the `yaml` files under `chain_info`. Do NOT edit any of the markdown files, your changes will be lost.

## Editing templates

You can find template files using:

     find . -name "*.tera"

There are 2 important templates:

- `templates/one.md.tera`: This template is used to convert the input `yaml` data into a markdown file per chain
- `templates/summary.md.tera`: This template is used to dynamically generate the summary of the book, it takes care of organising parachains under their `parent` relaychain

## Reference file

During the generation, all the data is aggregated into a `json` file containing the information about all the chains.

This file can be found at https://paritytech.github.io/polkadot_network_directory/chains.json

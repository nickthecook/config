# config

This repo contains the config for my shell environment and an idempotent script to install it on a Linux or Mac system.

## Installation

Run `./install.sh`. It will:

1. backup existing files in their usual directories, e.g. move `$HOME/.zshrc` to `$HOME/.zshrc.bak`
2. link the repository file into the original file's place

If an error occurs backing up the file, it skips the file.

If an error occurs linking the repo file into its place, it restores the backed-up file.

## Tools

This repo contains config for:

- zsh
- zinit
- p10k
- alacritty
- some handy dev commands via ops

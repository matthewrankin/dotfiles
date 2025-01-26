# -*- Justfile -*-

set dotenv-filename := "config/.env.dev"

app_name := "lenslocked"
app_port := "4100"
db_name := "lenslocked-db"
db_user := "baloo"
coverage_file := "coverage.out"


# List the available justfile recipes.
@default:
  just --list

# List the lines of code in the project.
loc:
  scc --remap-unknown "-*- Justfile -*-":"justfile"

# Deploy all dotfiles.
[group('dotfiles')]
all: bash zsh

# Deploy bash related dotfiles.
[group('dotfiles')]
bash:
	stow -t ~ bash --dotfiles

# Deploy zsh related dotfiles.
[group('dotfiles')]
zsh:
	stow -t ~ zsh --dotfiles

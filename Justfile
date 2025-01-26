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
all: bash hg npm readline tex vim zsh

# Deploy bash dotfiles.
[group('dotfiles')]
bash:
	stow -t ~ bash --dotfiles

# Deploy hg (Mercurial) dotfiles.
[group('dotfiles')]
hg:
	stow -t ~ hg --dotfiles

# Deploy JavaScript dotfiles.
[group('dotfiles')]
js:
	stow -t ~ js --dotfiles

# Deploy npm dotfiles.
[group('dotfiles')]
npm:
	stow -t ~ npm --dotfiles

# Deploy readline dotfiles.
[group('dotfiles')]
readline:
	stow -t ~ readline --dotfiles

# Deploy TeX/LaTeX dotfiles.
[group('dotfiles')]
tex:
	stow -t ~ tex --dotfiles

# Deploy vim dotfiles.
[group('dotfiles')]
vim:
	stow -t ~ vim --dotfiles

# Deploy zsh (inlucding p10k) dotfiles.
[group('dotfiles')]
zsh:
	stow -t ~ zsh --dotfiles

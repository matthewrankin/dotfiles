# -*- Justfile -*-

# List the available justfile recipes.
@default:
  just --list

# List the lines of code in the project.
loc:
  scc --remap-unknown "-*- Justfile -*-":"justfile"

# Deploy all dotfiles.
[group('dotfiles')]
all: bash claude ghostty git gpg js npm nvim nvimnew nvimv2 readline tex tmux vim zsh

# Deploy bash dotfiles.
[group('dotfiles')]
bash:
	stow -R -t ~ bash --dotfiles

# Deploy Claude Code dotfiles.
[group('dotfiles')]
claude:
  mkdir -p ~/.claude
  stow -R -t ~/.claude claude --dotfiles

# Deploy ghostty dotfiles.
[group('dotfiles')]
ghostty:
  mkdir -p ~/.config/ghostty
  stow -R -t ~/.config/ghostty ghostty --dotfiles

# Deploy git dotfiles.
[group('dotfiles')]
git:
  mkdir -p ~/.config/git
  stow -R -t ~/.config/git git --dotfiles

# Deploy gpg dotfiles.
[group('dotfiles')]
gpg:
	stow -R -t ~/.gnupg gpg --dotfiles

# Deploy JavaScript dotfiles.
[group('dotfiles')]
js:
	stow -R -t ~ js --dotfiles

# Deploy npm dotfiles.
[group('dotfiles')]
npm:
	stow -R -t ~ npm --dotfiles

# Deploy Neovim dotfiles.
[group('dotfiles')]
nvim:
  mkdir -p ~/.config/nvim
  stow -R -t ~/.config/nvim nvim --dotfiles

# Deploy new Neovim dotfiles.
[group('dotfiles')]
nvimnew:
  mkdir -p ~/.config/nvim-new
  stow -R -t ~/.config/nvim-new nvim-new --dotfiles

# Deploy Neovim v0.12 dotfiles.
[group('dotfiles')]
nvimv2:
  mkdir -p ~/.config/nvimv2
  stow -R -t ~/.config/nvimv2 nvimv2 --dotfiles

# Deploy readline dotfiles.
[group('dotfiles')]
readline:
	stow -R -t ~ readline --dotfiles

# Deploy TeX/LaTeX dotfiles.
[group('dotfiles')]
tex:
	stow -R -t ~ tex --dotfiles

# Deploy tmux dotfiles.
[group('dotfiles')]
tmux:
  mkdir -p ~/.config/tmux
  stow -R -t ~/.config/tmux tmux --dotfiles

# Deploy vim dotfiles.
[group('dotfiles')]
vim:
	stow -R -t ~ vim --dotfiles

# Deploy zsh (inlucding p10k) dotfiles.
[group('dotfiles')]
zsh:
	stow -R -t ~ zsh --dotfiles

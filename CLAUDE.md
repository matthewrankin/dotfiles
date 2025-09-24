# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview
Personal dotfiles repository for macOS and Ubuntu systems. Uses GNU Stow for symlink management with a "dot-" prefix naming convention (files prefixed with `dot-` become hidden `.` files when deployed).

## Commands

### Deployment Commands
- `just` - Show all available deployment options
- `just all` - Deploy all dotfiles to home directory
- `just nvim` - Deploy Neovim configuration
- `just zsh` - Deploy Zsh configuration
- `just tmux` - Deploy Tmux configuration
- `just git` - Deploy Git configuration
- `just ghostty` - Deploy Ghostty terminal configuration

### Development Commands
- `nvim` - Open Neovim editor (primary editor)
- `tmux` - Start tmux session (prefix: Ctrl-A)
- `git lg` - View pretty git log
- `git st` - Git status
- `z <directory>` - Jump to directory using zoxide

## Architecture

### Directory Organization
Each application has its own directory containing configuration files prefixed with `dot-` that will be symlinked to the home directory:
- `nvim/` - Neovim configuration (Lua-based, uses Lazy.nvim)
- `zsh/` - Zsh with Powerlevel10k prompt and extensive aliases
- `tmux/` - Tmux configuration with vi-mode
- `ghostty/` - Terminal emulator configuration
- `git/` - Git configuration with GPG signing

### Neovim LSP Configuration
Located in `nvim/dot-config/nvim/lua/rankin/lsp-config.lua`. Configured language servers:
- Go: gopls with experimental features
- Python: pyright + ruff
- JavaScript/TypeScript: ts_ls
- Rust: rust_analyzer
- Web: emmet_ls, html, cssls, tailwindcss, svelte
- Other: lua_ls, zls (Zig), texlab, marksman, taplo

### Key Integration Points
- Stow manages symlinks from repository to home directory
- Justfile provides organized deployment commands
- Zsh integrates with: pyenv, nvm, fzf, zoxide, starship, uv
- Consistent Rose Pine theme across Ghostty and Neovim
- GPG signing configured for Git commits
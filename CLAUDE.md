# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview
Personal dotfiles repository for macOS and Ubuntu systems. Uses GNU Stow for symlink management with a `dot-` prefix naming convention (files prefixed with `dot-` become hidden `.` files when deployed via the `--dotfiles` flag).

## Commands

Config-only repo: there is no build, test, or lint pipeline. The only commands are deployment (via `Justfile` at the repo root, capital J) and a LOC counter:
- `just` - List all available recipes
- `just all` - Deploy everything
- `just <name>` - Deploy a specific config (bash, ghostty, git, gpg, hg, js, npm, nvim, nvimnew, nvimv2, readline, tex, tmux, vim, zsh)
- `just loc` - Count lines of code (requires `scc`)

## Architecture

### Stow Deployment Patterns

There are two deployment patterns depending on the target location:

**Home directory (`~`)** — files use `dot-` prefix, stow converts them to dotfiles:
- `bash/`, `zsh/`, `vim/`, `readline/`, `npm/`, `js/`, `tex/`, `hg/` → `stow -R -t ~ <dir> --dotfiles`
- `gpg/` → `stow -R -t ~/.gnupg gpg --dotfiles`

**XDG config (`~/.config/<app>`)** — recipes `mkdir -p` the target first, then stow:
- `nvim/`, `nvim-new/`, `nvimv2/`, `ghostty/`, `git/`, `tmux/` → `stow -R -t ~/.config/<app> <dir> --dotfiles`

**`.stow-local-ignore`** at the repo root excludes top-level files from every stow target: `README*`, `LICENSE*`, `Justfile`, `.git*`, `.luarc.json`, plus RCS/CVS/SVN/darcs/hg artifacts and emacs backup/autosave files. Without it, stow would try to symlink these into `~`. Edit this file when adding new repo-root files that shouldn't deploy.

### Three Neovim Configurations

All three deploy independently and select via `NVIM_APPNAME`. The zsh aliases (`zsh/dot-zsh_aliases`) wire them up:
- `v` → stable `nvim/`
- `v2` → `NVIM_APPNAME=nvimv2 bob run stable`
- `vv` → `NVIM_APPNAME=nvim-new bob run nightly`

| Dir | Plugin manager | Notes |
|---|---|---|
| `nvim/` | **Lazy.nvim** | Established config. Source under `lua/matthewrankin/{core,plugins}/`. |
| `nvim-new/` | Built-in **`vim.pack`** | Uses Snacks.nvim (UI: picker/explorer/terminal), Mini.nvim (editing), Mason (LSP). Targets Neovim nightly. |
| `nvimv2/` | Built-in **`vim.pack`** | Targets Neovim v0.12 stable. Plugins: treesitter, lspconfig, blink.cmp (+ friendly-snippets), conform.nvim, fzf-lua, oil, gitsigns, nvim-surround, vimtex, which-key. |

The split between `nvim-new/` (nightly) and `nvimv2/` (v0.12 stable) exists so upstream `vim.pack` API changes can be tracked on nightly without breaking the stable setup.

The two `vim.pack` configs (`nvim-new/`, `nvimv2/`) share a structure:
- `init.lua` sets leader to Space, then `require("config")` and `require("plugins")`
- `lua/config/` — options, keymaps, autocmds, diagnostics
- `lua/plugins/init.lua` auto-requires every other `*.lua` in that directory (drop a file to add a plugin spec)
- `lsp/<server>.lua` — per-server LSP settings (present in both `nvim-new/` and `nvimv2/`; `nvim/` configures servers inline under `lua/matthewrankin/plugins/`)
- Plugin versions are pinned per config: `nvim/lazy-lock.json` for Lazy, `nvim-pack-lock.json` for `vim.pack`

### Neovim LSP Servers
`nvim/` (Lazy): Go (gopls), Python (pyright + ruff), TypeScript (ts_ls), Rust (rust_analyzer), Web (emmet_ls, html, cssls, tailwindcss, svelte), Lua (lua_ls), Zig (zls), LaTeX (texlab), Markdown (marksman), TOML (taplo), JSON (jsonls).

`nvimv2/`: same set minus taplo, plus `eslint` and `templ`. Servers are listed in `vim.lsp.enable({...})` in `lua/plugins/lsp.lua`; per-server overrides go in `lsp/<server>.lua` (auto-loaded from runtimepath in 0.11+). Mason is intentionally not used — install LSP binaries and conform.nvim formatters (prettierd, stylua, latexindent) via the system package manager.

### nvimv2 formatting pipeline
Format-on-save is owned by **conform.nvim** (`lua/plugins/conform.lua`), gated on `vim.g.autoformat`. Web/JSON/YAML/Markdown/Svelte/tex/Lua run external formatters (prettierd, latexindent, stylua); Go/Rust/Python/Zig fall back to LSP formatting via `lsp_format = "fallback"`. The only LSP-side BufWritePre logic left in `lua/plugins/lsp.lua` is gopls's `source.organizeImports` code action — gofumpt formats but doesn't add missing imports.

### Key Integration Points
- Zsh integrates with: pyenv, nvm, fzf, zoxide, starship, uv, bun, Powerlevel10k
- All Neovim configs use the **Rose Pine** colorscheme (also used by Ghostty)
- GPG signing configured for Git commits; SSH signing key per recent commits
- Tmux uses vi-mode with Ctrl-A prefix
- `bob` is used to manage Neovim versions (stable vs nightly)
- `.stylua.toml` at the repo root governs Lua formatting for all three Neovim configs
- `.luarc.json` at the repo root configures lua-language-server (LuaJIT runtime, `vim` global, `$VIMRUNTIME/lua` + luv on the workspace library) — applies across all three Neovim configs
- Just recipe names drop hyphens (`just nvimnew` deploys the `nvim-new/` directory)

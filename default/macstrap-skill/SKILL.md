---
name: macstrap
description: >
  REQUIRED for customizing a macstrap-based macOS setup. Use when editing
  AeroSpace bindings (~/.config/macstrap/aerospace/bindings.toml),
  shell customizations (~/.zshrc), terminal configs (~/.config/ghostty/,
  ~/.config/alacritty/), or adding/removing Homebrew packages. Triggers:
  AeroSpace keybindings, window management, workspace layout, shell aliases,
  Homebrew formulae/casks, Neovim config, Starship prompt, zsh customization.
---

# macstrap Skill

Customize a [macstrap](https://github.com/jebeene/macstrap)-based macOS setup.

macstrap is a reproducible bootstrap for macOS, inspired by Omarchy. It installs Homebrew packages, macOS preferences, and tool configs, then keeps them version-controlled.

## Critical Safety Rules

**Never edit files in `~/.local/share/macstrap/`. Reading is safe and encouraged.**

This directory contains macstrap's source files managed by git. Any changes will be lost on the next `macstrap update` and will cause conflicts with upstream.

```
~/.local/share/macstrap/     # READ-ONLY — NEVER EDIT (reading is OK)
├── bin/                    # macstrap-* commands (symlinked to PATH)
├── config/                 # Default config templates
├── default/                # System defaults
├── install/                # Installation scripts and package lists
└── migrations/             # Update migrations
```

**Reading `~/.local/share/macstrap/` is SAFE and useful** — do it freely to understand how things work or reference defaults before customizing.

**Always use these safe locations instead:**

| What | Where to edit |
|------|--------------|
| AeroSpace keybindings | `~/.config/macstrap/aerospace/bindings.toml` |
| Shell aliases / functions | `~/.zshrc` (below the macstrap source line) |
| Terminal appearance | `~/.config/ghostty/config`, `~/.config/alacritty/alacritty.toml` |
| Neovim plugins / keymaps | `~/.config/nvim/lua/plugins/`, `~/.config/nvim/lua/config/` |
| Starship prompt | `~/.config/starship.toml` |
| lazygit | `~/.config/lazygit/config.yml` |

### Generated files — NEVER edit directly

| Generated File | Source Files | Rebuild Command |
|---------------|-------------|-----------------|
| `~/.config/aerospace/aerospace.toml` | macstrap base + `~/.config/macstrap/aerospace/bindings.toml` | `macstrap-refresh-aerospace` |

Editing `~/.config/aerospace/aerospace.toml` directly will be overwritten the next time `macstrap-refresh-aerospace` runs.

## System Architecture

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **AeroSpace** | Tiling window manager | `~/.config/macstrap/aerospace/bindings.toml` |
| **Ghostty / Alacritty** | Terminals | `~/.config/ghostty/config`, `~/.config/alacritty/alacritty.toml` |
| **Neovim (LazyVim)** | Editor | `~/.config/nvim/` |
| **Starship** | Shell prompt | `~/.config/starship.toml` |
| **zsh** | Shell | `~/.zshrc` |
| **lazygit** | Git TUI | `~/.config/lazygit/config.yml` |
| **Homebrew** | Package manager | `brew install` / `brew install --cask` |

## AeroSpace (Tiling Window Manager)

AeroSpace config is built by merging a system base with your keybindings:

- **Base config (READ-ONLY):** `~/.local/share/macstrap/default/aerospace/aerospace.toml`
  - Gaps, startup behavior, normalization settings
  - Built-in bindings: `alt-h/j/k/l` (focus), `alt-shift-h/j/k/l` (move), `alt-1..9` (workspaces), `alt-shift-1..9` (move to workspace)
- **Your bindings:** `~/.config/macstrap/aerospace/bindings.toml`
  - App launch shortcuts using `alt-shift-{key}` pattern
  - Seeded from macstrap defaults on first run of `macstrap-refresh-aerospace`

After editing bindings, run:
```bash
macstrap-refresh-aerospace
```

This rebuilds `~/.config/aerospace/aerospace.toml` and runs `aerospace reload-config`.

### Reserved Keys (do not rebind)

`alt-h/j/k/l`, `alt-shift-h/j/k/l`, `alt-1..9`, `alt-shift-1..9`, `alt-tab`, `alt-semicolon`

### App Launch Binding Format

```toml
alt-shift-{key} = 'exec-and-forget open -a "App Name"'
```

Example — add a binding to open Slack:
```toml
alt-shift-s = 'exec-and-forget open -a "Slack"'
```

## Package Management

### Adding a Homebrew Cask (GUI app)

```bash
brew install --cask <cask-name>
```

### Adding a Homebrew Formula (CLI tool)

```bash
brew install <formula-name>
```

### Adding a Python CLI (via pipx)

```bash
pipx install <package-name>
```

## Shell Customization (zsh)

Add aliases, functions, and environment variables to `~/.zshrc` below the macstrap source line:

```bash
# This line is already there — add your customizations below it
source ~/.local/share/macstrap/default/zsh/rc

# Your aliases
alias gs='git status'
alias ll='ls -la'

# Your functions
function mkcd() { mkdir -p "$1" && cd "$1"; }
```

After editing, reload your shell:
```bash
source ~/.zshrc
```

## Terminal Config

### Ghostty

Edit `~/.config/ghostty/config` directly. Ghostty hot-reloads on save.

### Alacritty

Edit `~/.config/alacritty/alacritty.toml` directly. Alacritty reloads automatically.

## Neovim

macstrap ships a LazyVim config. Key customization files:
```
~/.config/nvim/lua/plugins/   # Plugin overrides (add files here)
~/.config/nvim/lua/config/    # keymaps.lua, options.lua, autocmds.lua
```

## Starship Prompt

Edit `~/.config/starship.toml` directly. Changes apply on next shell start.

## Decision Framework

When asked to customize a macstrap setup:

1. **AeroSpace keybinding?** → Edit `~/.config/macstrap/aerospace/bindings.toml`, then run `macstrap-refresh-aerospace`
2. **Add a package?** → Run `brew install` / `brew install --cask` / `pipx install`
3. **Shell alias or function?** → Add to `~/.zshrc` below the macstrap source line
4. **Terminal appearance?** → Edit `~/.config/ghostty/config` or `~/.config/alacritty/alacritty.toml`
5. **Neovim plugin or keymap?** → Edit in `~/.config/nvim/lua/plugins/` or `~/.config/nvim/lua/config/`
6. **Prompt?** → Edit `~/.config/starship.toml`

## Example Requests

- "Add a shortcut to open Obsidian" → Add `alt-shift-o = 'exec-and-forget open -a "Obsidian"'` to `~/.config/macstrap/aerospace/bindings.toml`, run `macstrap-refresh-aerospace`
- "Install the `ripgrep` formula" → Run `brew install ripgrep`
- "Add a git alias `gs` for `git status`" → Add `alias gs='git status'` to `~/.zshrc`, run `source ~/.zshrc`
- "Increase window gaps in AeroSpace" → Read the `[gaps]` section in `~/.local/share/macstrap/default/aerospace/aerospace.toml` for reference, then note that gaps are in the base config (READ-ONLY) — advise the user to open an issue or fork macstrap

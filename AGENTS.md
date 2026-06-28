# Style

- Two spaces for indentation, no tabs
- Use bash 5 conditionals: use `[[ ]]` for string/file tests and `(( ))` for numeric tests
- In `[[ ]]`, don't quote variables, but do quote string literals when comparing values (e.g., `[[ $branch == "main" ]]`)
- Prefer `(( ))` over numeric operators inside `[[ ]]` (e.g., `(( count < 50 ))`, not `[[ $count -lt 50 ]]`)
- For strings/paths with spaces, quote them instead of escaping spaces with `\ ` (e.g., `"$HOME/Library/Application Support"`)
- Executable scripts in `bin/` use `#!/bin/bash`; `bootstrap.sh` uses `#!/usr/bin/env bash`
- Install scripts under `install/` are sourced via `run_logged` — no shebang needed

# Command Naming

All commands start with `macstrap-`. Prefixes indicate purpose:

- `dev-` - development workflow helpers (e.g., `macstrap-dev-add-migration`, `macstrap-dev-sync`)
- `refresh-` - rebuild and reload a config from macstrap defaults (e.g., `macstrap-refresh-aerospace`)

# Config Structure

- `config/` - user-customizable configs copied to `~/.config/` on install
- `default/` - system-level defaults merged into final user configs (e.g., `default/aerospace/aerospace.toml`, `default/zsh/`)
- `install/` - install scripts organized by phase; all sourced via `run_logged`
  - `helpers/` - shared utilities (logging, list reading, error handling, presentation)
  - `preflight/` - pre-install checks and setup
  - `packaging/` - Homebrew formulae, casks, Python packages
  - `config/` - macOS system preferences (`defaults write`, etc.)
  - `setup/` - post-package app setup (AeroSpace, Neovim, etc.)
  - `post-install/` - final steps and finish screen

# Package Lists

- `install/macstrap-formula.packages` - Homebrew formulae (one per line, `#` for comments)
- `install/macstrap-cask.packages` - Homebrew casks (one per line)
- `install/macstrap-python.packages` - Python packages via pipx (one per line)

# Refresh Pattern

The `macstrap-refresh-*` commands rebuild user configs from macstrap defaults and reload the affected tool. For tools with user customization layers (like AeroSpace), the pattern is:

1. Read the base default from `$MACSTRAP_PATH/default/<tool>/`
2. Merge user overrides from `$MACSTRAP_PATH/config/<tool>/`
3. Write the merged result to the final destination (e.g., `~/.aerospace.toml`)
4. Reload the tool

Example:
```bash
macstrap-refresh-aerospace
```

This merges `default/aerospace/aerospace.toml` with `config/aerospace/bindings.toml` and runs `aerospace reload-config`.

# Install Script Pattern

Install scripts are sourced (not executed directly), so:
- No shebang
- Reference sub-scripts via `run_logged $MACSTRAP_INSTALL/path/to/script.sh` in `all.sh` aggregators
- Access shared paths via `$MACSTRAP_PATH` and `$MACSTRAP_INSTALL`
- Do not call `source` directly — use `run_logged` so output is captured to the install log

# Migrations

To create a new migration, run `macstrap-dev-add-migration`. This creates a migration file named after the unix timestamp of the last commit.

Migration format:
- No shebang line
- Start with an `echo` describing what the migration does
- Use `$MACSTRAP_PATH` to reference the macstrap directory

Example:
```bash
echo "Rebuild AeroSpace config if missing"

if [[ ! -f "$HOME/.aerospace.toml" ]]; then
  macstrap-refresh-aerospace
fi
```

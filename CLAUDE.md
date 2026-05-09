# macstrap

A lightweight, reproducible bootstrap for setting up a new macOS machine. Inspired by [Omarchy](https://github.com/basecamp/omarchy).

macstrap lives at `~/.local/share/macstrap/` on installed systems. Running `bootstrap.sh` clones the repo there and sources `install.sh` to drive the full setup.

## Key Paths

```
~/.local/share/macstrap/    # macstrap source (managed by git — READ-ONLY on installed systems)
├── bin/                    # macstrap-* commands, added to PATH
├── config/                 # Default config templates (seeded to user locations on install)
├── default/                # System defaults merged into final user configs
├── install/                # Install scripts, sourced in phases
│   ├── helpers/            # Logging, list reading, presentation utilities
│   ├── preflight/          # Pre-install checks
│   ├── packaging/          # Homebrew formulae, casks, Python packages
│   ├── config/             # macOS system preferences
│   ├── setup/              # App setup (AeroSpace, Neovim, etc.)
│   └── post-install/       # Finish steps
├── migrations/             # Migration scripts run on update
└── install/macstrap-*.packages  # Package lists
```

## Working in This Repo

When developing macstrap itself (adding scripts, changing defaults, writing migrations), you are editing the source at `~/.local/share/macstrap/` (or the repo checkout). This is the correct place to make macstrap development changes.

On installed systems, end users do NOT edit `~/.local/share/macstrap/` — they edit their own config files in `~/.config/` and `~/.config/macstrap/`. See `default/macstrap-skill/SKILL.md` for the user-facing customization guide.

See `AGENTS.md` for shell style, command naming, and structural conventions.

## AeroSpace Config

AeroSpace uses a two-file merge pattern:
- `default/aerospace/aerospace.toml` — system defaults (READ-ONLY; do not put keybindings here)
- `config/aerospace/bindings.toml` — default keybinding template (seeded to `~/.config/macstrap/aerospace/bindings.toml` on first install)

Users edit `~/.config/macstrap/aerospace/bindings.toml` (outside macstrap source).

Run `macstrap-refresh-aerospace` to rebuild `~/.config/aerospace/aerospace.toml` and reload AeroSpace.

## Adding Packages

- Homebrew casks → `install/macstrap-cask.packages`
- Homebrew formulae → `install/macstrap-formula.packages`
- Python (pipx) → `install/macstrap-python.packages`

One package per line. Lines starting with `#` are ignored.

## Setup Scripts

New tool setup scripts go in `install/setup/` and must be registered in `install/setup/all.sh` with:

```bash
run_logged $MACSTRAP_INSTALL/setup/your-tool.sh
```

## Migrations

Use `macstrap-dev-add-migration` to create a new migration file timestamped to the last commit. Migrations run automatically on `macstrap-migrate`. See `AGENTS.md` for format.

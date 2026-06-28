# macstrap Roadmap

Features identified by comparing with [Omarchy](https://github.com/basecamp/omarchy), the Linux bootstrap project macstrap is inspired by.

---

## In Progress

### `macstrap-refresh-config` primitive
Omarchy has `omarchy-refresh-config <path>` which copies `~/.local/share/omarchy/config/<path>` → `~/.config/<path>`, backing up the destination with a timestamp and printing a diff if the file changed.

macstrap should have the same: `macstrap-refresh-config <path>` copying from `$MACSTRAP_PATH/default/<path>` → `~/.config/<path>` with the same backup+diff behavior.

**Done:**
- Design finalized, omarchy source reviewed at `~/projects/omarchy/bin/omarchy-refresh-config`

**To do:**
- Create `bin/macstrap-refresh-config` (model on omarchy's version, sourcing from `$MACSTRAP_PATH/default/`)
- Simplify `bin/macstrap-refresh-tmux` to call `macstrap-refresh-config tmux/tmux.conf` + reload tmux

**Decided against:**
- Simplifying `macstrap-refresh-aerospace` with this primitive — aerospace requires a single assembled `.toml` from multiple source files, so a single-file copy won't work. Omarchy avoids this because hyprland natively loads multiple config files. Leave aerospace as-is.
- A `macstrap-build-aerospace` split — adds a file without omarchy precedent; inline assembly is fine.

---

## High Priority

### Theme System
Omarchy has 19 full themes with a template engine that applies color palettes per-app at runtime.
- Define `themes/` directory with color palettes (accent, bg, fg, color0–15)
- Build a template engine that injects colors into Ghostty, Neovim, Starship, Lazygit, etc.
- Add `macstrap-theme-set`, `macstrap-theme-list` commands
- Add `macstrap-refresh-ghostty`, `macstrap-refresh-starship`, `macstrap-refresh-nvim` (already have `macstrap-refresh-aerospace`)

### Migrations Infrastructure
`macstrap-migrate` exists but `migrations/` is empty. Omarchy has 305+ timestamped migration scripts.
- Track migration state in `~/.local/state/macstrap/migrations`
- Tie into a `macstrap-update` flow so migrations run automatically on upgrade
- Populate with initial migrations for any breaking config changes going forward

### More `bin/` Commands
Omarchy has 290+ commands vs macstrap's 7.
- `macstrap-update` — pull latest, run migrations, update Homebrew packages
- `macstrap-capture-screenshot` — selection, window, full (wraps macOS `screencapture`)
- `macstrap-capture-color` — color picker via Digital Color Meter CLI
- `macstrap-toggle-dark` / `macstrap-toggle-light` — standalone scripts (currently only in menu)
- `macstrap-restart-aerospace` — reload AeroSpace without full refresh
- `macstrap-version` — print current macstrap version

### First-Run Mode
Separate post-install wizard for steps that can't run headlessly or need one-time interactive setup.
- SSH key generation / 1Password SSH agent setup
- Prompt user through macOS permissions (Accessibility, Screen Recording, Full Disk Access)
- iCloud / Apple ID prompts
- Keeps `install.sh` idempotent (safe to re-run) by moving one-time steps here

---

## Medium Priority

### Hardware Detection
Omarchy detects 30+ hardware classes and applies conditional config. macOS has its own variations.
- Detect Apple Silicon vs Intel
- Detect MacBook Pro vs Air, screen size (notch handling, ProMotion)
- Conditional AeroSpace / display config for external monitors
- `macstrap-hw-*` command family (e.g., `macstrap-hw-apple-silicon`, `macstrap-hw-macbook-pro`)

### Test Suite
Omarchy has a TAP-format CLI test suite that validates command presence and help text.
- `test/macstrap-cli-test.sh` — validate commands exist, help flags render, package lists parse
- Hook into CI or a pre-commit check

### launchd Integration
macOS equivalent of the systemd services Omarchy uses for background agents.
- `macstrap-update` auto-check LaunchAgent (runs in background, notifies if updates available)
- Store LaunchAgent plists in `config/launchd/`
- Install/uninstall via `macstrap-setup-launchd`

### Extended macOS System Preferences
Omarchy has 70+ config scripts; macstrap has 9 under `install/config/macos/`.
- Notification Center defaults
- Spotlight configuration (index scope, search categories)
- Screen saver / lock screen settings
- Language and locale setup (currently unhandled)
- Privacy permission prompting (at minimum, instruct user what to grant)

### `macstrap-menu` Expansion
The existing gum-based menu is a good foundation — add more submenus.
- Hardware info (disk usage, battery health, memory pressure)
- Running services / active apps
- Quick app launcher entries

---

## Lower Priority

### Channel / Branch Switching
Omarchy supports stable/rc/dev channels with a `omarchy-update-branch` command.
- `macstrap-update-channel stable|dev` to switch tracking branches
- Mirrors Omarchy's channel management pattern

### `applications/` Folder
Omarchy uses this for desktop integration metadata (`.desktop` files, app associations).
- macOS equivalent: app-specific post-install notes, keybinding docs, default handler config

### `version` File
Needed for migration infrastructure — track the installed macstrap version.
- Simple semver or date-based version string
- Referenced by `macstrap-version` and migration runner

### Developer Tooling
- `macstrap-dev-benchmark` — measure install time phase by phase
- `macstrap-dev-bin-metadata` — auto-generate command documentation from bin script headers

---

## Out of Scope (Linux-only)

These Omarchy features have no meaningful macOS equivalent:

- **Boot management** (Limine, Plymouth, Snapper) — macOS locks down the bootloader
- **Pacman / AUR** — Homebrew already covers package management
- **Hyprland / Wayland** — macOS uses its own compositor; AeroSpace is the right fit
- **Hardware drivers** — macOS manages these via System Preferences / SIP
- **Gaming infrastructure** (Steam, Lutris, Retroarch) — available as casks, not worth custom scripts
- **Display manager** (SDDM) — macOS login window is not configurable this way
- **CJK input methods** (Fcitx5) — macOS has built-in input method support

# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## What's included

| Component | Description |
|-----------|-------------|
| **Zsh + Prezto** | Shell config with [Prezto](https://github.com/sorin-ionescu/prezto) framework |
| **tmux** | Terminal multiplexer config with custom status bar |
| **Brewfile** | Declarative Homebrew package management |
| **zprofile** | PATH setup, Homebrew init, secrets sourcing |

## Quick start

```bash
# Install chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mooncos
```

On first run, chezmoi will prompt you to choose which components to install:

- **Prezto** — Zsh framework (clones the repo if missing)
- **tmux** — Terminal multiplexer config
- **Brewfile** — Manage Homebrew packages via `brew bundle`
- **Go PATH** — Go toolchain paths
- **Kiro** — Kiro CLI hooks

## How it works

chezmoi uses templates (`.tmpl` files) to conditionally include config based on your answers and OS (macOS vs WSL). Secrets live in `~/.config/secrets/` and are never tracked.

### Scripts

| Script | When | Purpose |
|--------|------|---------|
| `run_once_before_install-prezto.sh` | Before apply | Clones Prezto if not present |
| `run_once_after_brew-bundle.sh` | After apply | Runs `brew bundle --global` (macOS only) |

## Day-to-day usage

```bash
# Edit a managed file
chezmoi edit ~/.zshrc

# Pull latest changes and apply
chezmoi update

# See what would change
chezmoi diff

# Add a new file to management
chezmoi add ~/.some-config
```

## Structure

```
.
├── .chezmoi.toml.tmpl          # Template data (OS detection, feature flags)
├── .chezmoiignore              # Files to skip based on config
├── dot_Brewfile                # Homebrew packages
├── dot_tmux.conf               # tmux config
├── dot_zprezto/                # Prezto framework overrides
├── dot_zprofile.tmpl           # Login shell setup
├── executable_dot_tmux-status.sh
├── run_once_after_brew-bundle.sh.tmpl
├── run_once_before_install-prezto.sh.tmpl
├── symlink_dot_zpreztorc.tmpl
├── symlink_dot_zshenv.tmpl
└── symlink_dot_zshrc.tmpl
```

## License

Personal use. Feel free to take inspiration.

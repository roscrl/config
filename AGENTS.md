# Config

Nix-darwin + home-manager dotfiles for macOS. One repo, one command (`./sync.sh`).

## Structure

- `flake.nix` — single-file system config: nix packages, homebrew casks, home-manager dotfiles, macOS defaults
- `sync.sh` — bootstrap and apply (`-update` flag to upgrade nix + flake inputs)
- `settings/` — app configs symlinked into `~` by home-manager
- `scripts/` — utility scripts symlinked to `~/dev/scripts`

## Rules

- Everything declarative in `flake.nix`. No imperative install steps outside sync.sh.
- App configs live in `settings/<app>/` and are symlinked by home-manager — edit the source, not the symlink.
- macOS defaults go in `system.defaults` in flake.nix. Use `scripts/find_defaults.sh` to discover the right keys.
- Secrets are in `~/Drive/settings/dotfiles/.secrets` (not in this repo).
- Keep it flat. No unnecessary nesting or abstraction.

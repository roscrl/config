#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

update=false
case "${1:-}" in
    "") ;;
    -update|--update) update=true ;;
    *) echo "Usage: $0 [-update]" >&2; exit 2 ;;
esac

# Install Nix if not already installed
if ! command -v nix >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

nix --version

# Install Homebrew if not already installed
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew --version

if $update; then
    sudo determinate-nixd upgrade
    nix flake update
    brew update
    brew upgrade --greedy
fi

if command -v darwin-rebuild >/dev/null 2>&1; then
  sudo darwin-rebuild switch --flake .#macbook
else
  sudo nix run nix-darwin -- switch --flake .#macbook
fi

# Invalidate zsh completion cache — fpath changes after rebuild
rm -f "$HOME/.zcompdump" "$HOME/.zcompdump.zwc"

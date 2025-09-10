#!/bin/bash

set -euo pipefail

UPDATE=false
if [[ "${1:-}" == "-update" ]]; then
  UPDATE=true
fi

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

if $UPDATE; then
  nix flake update
fi

# Run darwin-rebuild or nix-darwin
if command -v darwin-rebuild >/dev/null 2>&1; then
  sudo darwin-rebuild switch --flake .#macbook
else
  sudo nix run nix-darwin -- switch --flake .#macbook
fi

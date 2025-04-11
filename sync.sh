#!/bin/bash

# Install Nix if not already installed
if ! command -v nix >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

nix --version

# Install Homebrew if not already installed
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew --version

nix run \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  nix-darwin#darwin-rebuild \
  -- \
  switch --flake .#macbook

#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# When running as root (e.g. launchd), Nix's libgit2 rejects user-owned repos.
# Nix falls back to /var/root as HOME regardless of $HOME, so write config there.
if [ "$(id -u)" = "0" ]; then
  HOME=/var/root git config --global --get-all safe.directory 2>/dev/null | grep -qxF "$SCRIPT_DIR" \
    || HOME=/var/root git config --global --add safe.directory "$SCRIPT_DIR"
fi

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
  sudo determinate-nixd upgrade
  nix flake update
fi

if command -v darwin-rebuild >/dev/null 2>&1; then
  sudo darwin-rebuild switch --flake .#macbook
else
  sudo nix run nix-darwin -- switch --flake .#macbook
fi

# Invalidate zsh completion cache — fpath changes after rebuild,
# next shell will run compinit -C against the fresh dump
# Resolve real user home: interactive (SUDO_USER), launchd (fallback to directory owner), or direct
if [ -n "${SUDO_USER:-}" ]; then
  USER_HOME="/Users/$SUDO_USER"
elif [ "$(id -u)" = "0" ]; then
  USER_HOME="/Users/$(stat -f '%Su' "$(dirname "$0")")"
else
  USER_HOME="$HOME"
fi
rm -f "$USER_HOME/.zcompdump" "$USER_HOME/.zcompdump.zwc"
rm -rf "$USER_HOME/.cache/zsh"

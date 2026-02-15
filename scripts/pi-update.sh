#!/usr/bin/env bash
# Pull latest pi-mono and reinstall globally
set -euo pipefail

PI_DIR="$HOME/dev/projects/pi-mono"

cd "$PI_DIR"

# Stash any local changes before pulling
if ! git diff --quiet 2>/dev/null; then
    echo "Stashing local changes..."
    git stash
    STASHED=1
fi

echo "Pulling latest..."
git pull --rebase https://github.com/badlogic/pi-mono.git main

if [ "${STASHED:-0}" = "1" ]; then
    echo "Restoring local changes..."
    git stash pop
fi

echo "Installing globally..."
npm install -g ./packages/coding-agent

echo "Done. pi version: $(pi --version 2>/dev/null || echo 'unknown')"

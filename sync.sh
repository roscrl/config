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

    # bump pi pin to latest GitHub release
    latest=$(curl -sSf https://api.github.com/repos/earendil-works/pi/releases/latest | jq -r .tag_name)
    current=$(sed -nE 's/[[:space:]]*piVersion = "([^"]+)";/\1/p' flake.nix)
    if [[ ${latest#v} != "$current" ]]; then
        echo "pi: $current -> ${latest#v}"
        hash=$(nix store prefetch-file --json "https://github.com/earendil-works/pi/releases/download/$latest/pi-darwin-arm64.tar.gz" | jq -r .hash)
        sed -i '' -E \
            -e 's/(piVersion = )"[^"]+";/\1"'"${latest#v}"'";/' \
            -e 's/(piHash = )"[^"]+";/\1"'"$hash"'";/' \
            flake.nix
    fi
    brew update || echo "Warning: Homebrew update failed; upgrading from cached metadata." >&2
    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade --greedy || echo "Warning: Some Homebrew packages failed to upgrade; continuing with system rebuild." >&2
fi

if command -v darwin-rebuild >/dev/null 2>&1; then
  sudo darwin-rebuild switch --flake .#macbook
else
  sudo nix run nix-darwin -- switch --flake .#macbook
fi

# VS Code has no global extensions settings file, so install the declared extension IDs via its CLI.
while IFS= read -r extension || [[ -n "$extension" ]]; do
  [[ -z "$extension" || "$extension" == \#* ]] && continue
  code --install-extension "$extension" >/dev/null
done < settings/vscode/extensions.txt

# Invalidate zsh completion cache — fpath changes after rebuild
rm -f "$HOME/.zcompdump" "$HOME/.zcompdump.zwc"

# aliases

alias ".."      = "cd ..";
alias ll        = "ls -roAhtG";
alias copy      = "tr -d '\\n' | pbcopy";
alias g         = "git";
alias ga        = "git add . && git commit -am";
alias gaa       = "git add -A";
alias gcm       = "git commit -m";
alias gcp       = "git add . && git commit --allow-empty-message -m '' && git push";
alias gs        = "git status";
alias gsw       = "git switch";
alias gp        = "git push";
alias gpe       = "git commit --amend --no-edit && git push —force-with-lease";
alias gpu       = "git pull";
alias gl        = "git log --pretty=oneline";
alias gd        = "git diff";
alias gdc       = "git diff --cached";
alias gcdr      = "cd $(git rev-parse --show-toplevel)"; # cd to git root
alias gopen     = "open_github";
alias gce       = "clone_cd_vim";
alias gc        = "clone_cd";
alias r         = "rails";
alias be        = "bundle exec";
alias lg        = "lazygit";
alias ld        = "lazydocker";
alias tf        = "terraform";
alias m         = "make";
alias deploy    = "make deploy";
alias v         = "nvim";
alias vi        = "nvim";
alias vim       = "nvim";
alias sync      = "~/dev/config/sync.sh";
alias econfig   = "nvim ~/dev/config/flake.nix";
alias ezsh      = "nvim ~/.zshrc && source ~/.zshrc";
alias exzsh     = "nvim ~/dev/config/settings/zshrc/extra && source ~/dev/config/settings/zshrc/extra";
alias evim      = "nvim ~/.config/nvim/init.vim";
alias ecvim     = "nvim ~/dev/config/settings/nvim/init.vim";
alias eghostty  = "nvim ~/.config/ghostty/config";
alias ecghostty = "nvim ~/dev/config/settings/ghostty/config";
alias ekari     = "nvim ~/.config/karabiner/karabiner.json";
alias eckari    = "nvim ~/dev/config/settings/karabiner/karabiner.json";
alias drive     = "cd ~/Drive";
alias dl        = "cd ~/Downloads";
alias docs      = "cd ~/Documents";
alias dev       = "cd ~/dev";
alias config    = "cd ~/dev/config";
alias settings  = "cd ~/dev/config/settings";
alias scripts   = "cd ~/dev/scripts";
alias scratch   = "cd ~/dev/scratch";
alias refs      = "cd ~/dev/refrences";
alias repos     = "cd ~/dev/repos";
alias walters   = "cd ~/dev/repos/walters";
alias me        = "cd ~/dev/repos/roscrl.com";
alias posts     = "cd ~/dev/repos/roscrl.com/posts && nvim";
alias secrets   = "nvim ~/Drive/settings/dotfiles/.secrets && source ~/.zshrc";

# options

HISTSIZE="100000"
SAVEHIST="100000"
setopt EXTENDED_HISTORY         # write the history file in the ':start:elapsed;command' format
setopt SHARE_HISTORY            # share history between all sessions
setopt HIST_IGNORE_DUPS         # do not record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # delete old recorded entry if new entry is a duplicate
setopt HIST_SAVE_NO_DUPS        # do not display a line previously found.
setopt HIST_FIND_NO_DUPS        # do not write duplicate entries in the history file.
setopt HIST_IGNORE_SPACE        # do not record an entry starting with a space

setopt   AUTO_CD          # cd by typing directory name if it's not a command
setopt   AUTO_MENU        # show completion menu automatically
setopt   COMPLETE_IN_WORD # allow completion from within words
setopt   ALWAYS_TO_END    # move cursor to end of word on completion
setopt   AUTO_PUSHD       # automatically push directories onto the stack
unsetopt CORRECT_ALL      # disable command correction
unsetopt FLOWCONTROL      # disable ^S/^Q flow control

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # built in zsh autocomplete will match lowercase to uppercase

# git branch on the right of terminal prompt when in git folder https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
PROMPT='%B%F{blue}%2~%f%b %# '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}%b%f'
zstyle ':vcs_info:*' enable git

# exports 

source ~/Drive/settings/dotfiles/.secrets

# functions

function mkcd() { mkdir $1 && cd $1; }
function cnw() { open -na "Google Chrome" --args --new-window "$@" }
function killport() { lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9 }
function myip() { curl -s https://api.ipify.org; printf "\n" }
function grab() { find . -type f -print0 | while IFS= read -r -d \'\' file; do echo "$file\`\`\`"; cat "$file"; echo "\`\`\`"; done | pbcopy }
function rs() { bundle exec foreman start -f Procfile.dev "$@" }
function speedcheck() { for i in $(seq 0 50); do /usr/bin/time -p /bin/zsh -i -c exit 2>&1 | grep real | awk '{print $2}'; done | awk '{ sum += $1 } END { print "Average time:", sum/NR, "seconds" }' }; # 0.01462 seconds avg

function initialize_gh_copilot_alias() {
    if ! alias | grep -q "alias ghcs="; then
        eval "$(gh copilot alias -- zsh)"
    fi
}

function clone_cd_vim() {
  local url="$1"; 
  local dir_name=$(basename "$url" .git); 

  if [[ $url =~ ^(https|git|ssh)://.+\.git$ || $url =~ ^git@.+:.+\.git$ ]]; then 
      git clone "$url" && cd "$dir_name" && vim .; 
  else 
      echo "Invalid Git URL"; 
  fi 
}

function clone_cd() {
  local url="$1"; 
  local dir_name=$(basename "$url" .git); 

  if [[ $url =~ ^(https|git|ssh)://.+\.git$ || $url =~ ^git@.+:.+\.git$ ]]; then 
      git clone "$url" && cd "$dir_name";
  else 
      echo "Invalid Git URL"; 
  fi 
}

function fcd() {
  local dir;
  while true; do
    # exit with ^D
    dir="$(ls -a1F | grep '[/@]$' | grep -v '^./$' | sed 's/@$//' | fzf --height 40% --reverse --no-multi --preview 'pwd' --preview-window=up,1,border-none --no-info)"
    if [[ -z "''${dir}" ]]; then
      break
    elif [[ -d "''${dir}" ]]; then
      cd "''${dir}"
    fi
  done
}

function pbfilter() {
    if [ $# -gt 0 ]; then
        pbpaste | "$@" | pbcopy
    else
        pbpaste | pbcopy
    fi
}  

function open_github() {
  local remote_url=$(git config --get remote.origin.url)
  if [[ -z "$remote_url" ]]; then
    echo "Not a git repository or no remote.origin.url set"
    return 1
  fi

  # Convert SSH URL to HTTPS if necessary
  if [[ $remote_url == git@github.com:* ]]; then
    remote_url=''${remote_url/git@github.com:/https://github.com/}
  fi

  # Remove .git suffix if present
  remote_url=''${remote_url%.git}

  # Open the URL in the default browser
  if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$remote_url"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$remote_url"
  else
    echo "Unsupported operating system"
    return 1
  fi
}

# Function to initialize a Nix flake development environment with direnv
# Usage: denv <pkg1> <pkg2> ...
function denv() {
  # Check if any arguments (package names) were provided
  if [[ $# -eq 0 ]]; then
    print -u2 "Error: No packages specified."
    print -u2 "Usage: denv <pkg1> <pkg2> ..."
    return 1
  fi

  local envrc_file=".envrc"
  local flake_file="flake.nix"
  local gitignore_file=".gitignore"
  local gitignore_entries=(".DS_Store" ".direnv/") # Array of entries to ensure

  # --- Check and create .envrc ---
  if [[ -e "$envrc_file" ]]; then
    print -u2 "Error: '$envrc_file' already exists. Aborting."
    return 1
  else
    echo "use flake" > "$envrc_file"
    # Optionally allow direnv if installed
    if command -v direnv &> /dev/null; then
        print "Running 'direnv allow .'..."
        direnv allow .
    else
        print "Warning: direnv command not found. You may need to run 'direnv allow .' manually."
    fi
  fi

  # --- Check and create flake.nix ---
  if [[ -e "$flake_file" ]]; then
    print -u2 "Error: '$flake_file' already exists. Aborting."
    return 1
  fi

  # --- Prepare package list for flake.nix ---
  # This part remains the same, formatting the packages correctly.
  local pkgs_string=""
  local num_pkgs=$#
  local current_pkg_num=0

  for pkg in "$@"; do
    ((current_pkg_num++))
    # Indentation needs to match the 'packages' list in the new template (14 spaces)
    pkgs_string+="          ${pkg}"
    # Add a newline unless it's the very last package
    if [[ $current_pkg_num -lt $num_pkgs ]]; then
      pkgs_string+="\n"
    fi
  done

  # --- Create flake.nix using the forAllSystems template ---
  cat <<EOF > "$flake_file"
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system: f nixpkgs.legacyPackages.\${system});
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
${pkgs_string}
        ];
      };
    });
  };
}
EOF

  if [[ -f "$gitignore_file" ]]; then
    # File exists, check and append missing entries
    local entry_added=false
    for entry in "${gitignore_entries[@]}"; do
      # Use grep -qxF to check for exact, full line match, suppressing output
      if ! grep -qxF "$entry" "$gitignore_file"; then
        print "  Adding '$entry' to $gitignore_file"
        # Append the entry on a new line
        echo "$entry" >> "$gitignore_file"
        entry_added=true
      fi
    done
  else
    # Use printf for reliable newline handling
    printf '%s\n' "${gitignore_entries[@]}" > "$gitignore_file"
  fi

  return 0
}

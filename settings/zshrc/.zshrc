# zmodload zsh/zprof

# aliases

alias ".."="cd ..";
alias ll="ls -roAhtG";
alias copy="tr -d '\\n' | pbcopy";
c() { (( $# )) && cursor "$@" || cursor .; }
cr() { killall "Cursor"; cursor .; }
o() { (( $# )) && open  "$@"  || open  .; }
s() { (( $# )) && subl  "$@"  || subl  .; }
alias g="git";
gac()  { git add .; (( $# )) && git commit -am "$*"; }
alias gaa="git add -A";
gcm() { (( $# )) && git commit -m "$*" || git commit; }
gcp() { git add .; (( $# )) && git commit -m "$*" || git commit --allow-empty-message -m ''; git push; }
alias gt="go tool";
alias gs="git status";
alias gsw="git switch";
alias gp="git push";
alias gpe="git commit --amend --no-edit && git push —force-with-lease";
alias gpl="git pull";
alias gl="git log --pretty=oneline";
alias gd="git diff";
alias gdc="git diff --cached";
alias gopen="open_github";
alias gce="clone_cd_vim";
alias gc="clone_cd";
alias j="jj";
jc()  { (( $# )) && jj commit -m "$*" || jj commit; }
alias jn="jj new";
alias jl="jj log";
jd()  { (( $# )) && jj describe -m "$*" || jj describe; }
alias jh="jj log -r 'heads(all())'"
alias jdi="jj diff";
alias jcp="jj commit -m '' && jj git push --allow-empty-description -c ";
alias js="jj st";
alias ju="jj undo";
alias jp="jj git push";
alias jpu="jj git fetch && jj rebase -d";
alias jgc="jj git clone --colocate";
alias jgi="jj git init --colocate";
alias jf="jj git fetch";
alias r="make run";
alias jr="jai run.jai -";
rs() { bundle exec foreman start -f Procfile.dev "$@" }
alias be="bundle exec";
alias kd="bundle exec kamal deploy";
alias gkd="gcp && kd"
alias rails="bundle exec rails"
alias bi="bundle install";
alias lg="lazygit";
alias ld="lazydocker";
alias tf="terraform";
alias m="make";
alias b="make build"
alias t="make test"
alias l="make lint"
alias deploy="make deploy";
alias v="nvim";
alias vi="nvim";
alias vim="nvim";
alias a="amp";
alias cc="claude";
alias sync="cd ~/dev/config && ./sync.sh";
alias econfig="nvim ~/dev/config/flake.nix";
alias ezsh="nvim ~/.zshrc && source ~/.zshrc";
alias eczsh="nvim ~/dev/config/settings/zshrc/.zshrc && source ~/dev/config/settings/zshrc/.zshrc";
alias evim="nvim ~/.config/nvim/init.vim";
alias ecvim="nvim ~/dev/config/settings/nvim/init.vim";
alias eghostty="nvim ~/.config/ghostty/config";
alias ecghostty="nvim ~/dev/config/settings/ghostty/config";
alias ekari="nvim ~/.config/karabiner/karabiner.json";
alias eckari="nvim ~/dev/config/settings/karabiner/karabiner.json";
alias drive="cd ~/Drive";
alias dl="cd ~/Downloads";
alias docs="cd ~/Documents";
alias dev="cd ~/dev";
alias config="cd ~/dev/config";
alias settings="cd ~/dev/config/settings";
alias scripts="cd ~/dev/scripts";
alias find_defaults="~/dev/scripts/find_defaults.sh";
alias scratch="cd ~/dev/scratch";
alias refs="cd ~/dev/refrences";
alias projects="cd ~/dev/projects";
alias walters="cd ~/dev/projects/walters";
alias me="cd ~/dev/projects/roscrl.com";
alias posts="cd ~/dev/projects/roscrl.com/posts && nvim";
alias secrets="nvim ~/Drive/settings/dotfiles/.secrets && source ~/.zshrc";

# options

HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY   # append to history file
setopt EXTENDED_HISTORY     # include timestamp in history
setopt HIST_IGNORE_DUPS     # do not record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS # delete old recorded entry if new entry is a duplicate
setopt HIST_SAVE_NO_DUPS    # do not write duplicate entries in the history file
setopt HIST_FIND_NO_DUPS    # prevent history or fc commands from showing duplicates
setopt HIST_IGNORE_SPACE    # do not record an entry starting with a space
setopt SHARE_HISTORY        # share history between all sessions

setopt AUTO_CD          # cd by typing directory name if it's not a command
setopt AUTO_MENU        # show completion menu automatically
setopt COMPLETE_IN_WORD # allow completion from within words
setopt ALWAYS_TO_END    # move cursor to end of word on completion
setopt AUTO_PUSHD       # automatically push directories onto the stack
unsetopt CORRECT_ALL    # disable command correction
unsetopt FLOWCONTROL    # disable ^S/^Q flow control

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # built in zsh autocomplete will match lowercase to uppercase

# git branch on the right of terminal prompt when in git folder https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
PROMPT='%B%F{blue}%2~%f%b %# '
autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{240}%b%f'
_update_vcs_info() {
  psvar=() # Reset array used by vcs_info internally
  vcs_info
}
git() {
  command git "$@"
  local git_exit_status=$?

  case "$1" in
    switch|checkout|commit|merge|rebase|pull|reset|stash|branch|clean)
      _update_vcs_info
      ;;
  esac

  return $git_exit_status
}
_update_vcs_info

bindkey -r '^S' # unbind ctrl+s history-incremental-search-forward

# exports 

source ~/Drive/settings/dotfiles/.secrets
export EDITOR="nvim"
export NIXPKGS_ALLOW_UNFREE=1

# functions

mkcd()       { mkdir $1 && cd $1; }
cnw()        { open -na "Google Chrome" --args --new-window "$@" }
killport()   { lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9 }
myip()       { curl -s https://api.ipify.org; printf "\n" }
grab()       { find . -type f -print0 | while IFS= read -r -d \'\' file; do echo "$file\`\`\`"; cat "$file"; echo "\`\`\`"; done | pbcopy }
speedcheck() { for i in $(seq 0 50); do /usr/bin/time -p /bin/zsh -i -c exit 2>&1 | grep real | awk '{print $2}'; done | awk '{ sum += $1 } END { print "Average time:", sum/NR, "seconds" }' }; # 0.0633333 seconds avg (70ms is possible)
speedbench() { time ZSH_DEBUGRC=1 zsh -i -c exit };

# "Explodes" a directory's contents into the current directory,
# then removes the (now empty) source directory.
# Usage: explode <directory_name>
explode() {
  # --- Safety Checks ---
  if (( ! $# )); then
    echo "Error: No directory specified." >&2
    echo "Usage: explode <directory_name>" >&2
    return 1
  fi

  if [[ ! -d "$1" ]]; then
    echo "Error: '$1' is not a directory." >&2
    return 1
  fi
  
  # realpath resolves '..' and '.' to an absolute path for a clean comparison.
  if [[ "$(realpath "$1")" == "$(pwd)" ]]; then
      echo "Error: Cannot explode the current directory into itself." >&2
      return 1
  fi

  # --- The Action ---
  # 1. Move all contents (including dotfiles) into the current directory (.).
  # 2. If AND ONLY IF the move succeeds, remove the now-empty source directory.
  mv "$1"/*(D) . && rmdir "$1"
}

initialize_gh_copilot_alias() {
    if ! alias | grep -q "alias ghcs="; then
        eval "$(gh copilot alias -- zsh)"
    fi
}

clone_cd_vim() {
  local url="$1"; 
  local dir_name=$(basename "$url" .git); 

  if [[ $url =~ ^(https|git|ssh)://.+\.git$ || $url =~ ^git@.+:.+\.git$ ]]; then 
      git clone "$url" && cd "$dir_name" && vim .; 
  else 
      echo "Invalid Git URL"; 
  fi 
}

clone_cd() {
  local url="$1"; 
  local dir_name=$(basename "$url" .git); 

  if [[ $url =~ ^(https|git|ssh)://.+\.git$ || $url =~ ^git@.+:.+\.git$ ]]; then 
      git clone "$url" && cd "$dir_name";
  else 
      echo "Invalid Git URL"; 
  fi 
}

fcd() {
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

pbfilter() {
    if [ $# -gt 0 ]; then
        pbpaste | "$@" | pbcopy
    else
        pbpaste | pbcopy
    fi
}  

open_github() {
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

denv() {
  if [[ $# -eq 0 ]]; then
    print -u2 "Error: No packages specified."
    print -u2 "Usage: denv <pkg1> <pkg2> ..."
    return 1
  fi

  local envrc_file=".envrc"
  local flake_file="flake.nix"

  if [[ -e "$envrc_file" ]]; then
    print -u2 "Error: '$envrc_file' already exists. Aborting."
    return 1
  else
    {
      echo "if has nix;"
      echo "  then use flake;"
      echo "fi"
      echo ""
    } > "$envrc_file"

    if command -v direnv &> /dev/null; then
        direnv allow . # Allow direnv to manage the environment
    fi
  fi

  if [[ -e "$flake_file" ]]; then
    print -u2 "Error: '$flake_file' already exists. Aborting."
    return 1
  fi

  cat <<EOF > "$flake_file"
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
        f pkgs system inputs
    );
  in {
    devShells = forAllSystems (pkgs: system: inputs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
EOF

  # --- Append packages to flake.nix ---
  for pkg in "$@"; do
    printf "          %s\n" "${pkg}" >> "$flake_file"
  done

  cat <<EOF >> "$flake_file"
        ];
      };
    });
  };
}
EOF

  return 0
}

# zprof

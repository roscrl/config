{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }@inputs:
  {
    darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ({ pkgs, ... }: let username = "ross"; in {
          environment.systemPackages = with pkgs; [
            neovim
            docker
            git
            terraform
            jq
            yq
            tree
            wget
            ripgrep
            ripgrep-all
            silver-searcher
            zsh-autosuggestions
            fzf
            direnv
            sqlite          
            btop                # better htop
            lazygit             # git tui
            lazydocker          # docker tui
            oha                 # load testing
            hey                 # load testing
            fd                  # find files
            hyperfine           # benchmark
            dive                # docker layer viewer
            shellcheck          # shell script linter
          ];

          homebrew = {
              enable = true;
              onActivation = {
                autoUpdate = true;
                upgrade = true;
                cleanup = "uninstall";
              };
              casks = [
                "alfred"
                "vlc"
                "bruno"
                "charles"
                "calibre"
                "ghostty"
                "jetbrains-toolbox"
                "sublime-text"
                "github"
                "linearmouse" 
                "istat-menus" 
                "claude"
                "fork"
                "mullvadvpn"
                "shifty" 
                "numi" 
                "keycastr" 
                "karabiner-elements" 
                "discord" 
                "spotify" 
                "keepassxc" 
                "transmission" 
                "signal" 
                "chatgpt"
                "visual-studio-code"
                "cursor"
                "google-chrome"
                "betterdisplay"
                "sloth"
                "rectangle"
              ];
              brews = [ "mas" ];
              masApps = {
                "AdGuard for Safari" = 1440147259;
              };
          };

          system.defaults = {
            dock = {
              autohide = true;                 # enable dock auto hiding
              autohide-delay = 0.0;            # make dock hide instantly
              autohide-time-modifier = 0.25;   # make dock show/hide faster
              launchanim = false;              # dont animate opening of applications
              expose-group-apps = true;        # group windows by application in Mission Control
              largesize = 128;                 # magnified icon size on hover
              show-process-indicators = false; # disable indicator lights for open applications
              mru-spaces = false;              # disable automatically rearrange spaces based on most recent use
              mineffect = "scale";             # use scale effect for window minimising/maximising
              show-recents = false;            # turn off show suggested and recent apps in dock
              tilesize = 58;                   # icon size
              wvous-tl-corner = 1;             # top    left  hot corner -> noop
              wvous-tr-corner = 12;            # top    right hot corner -> Notifications Center
              wvous-br-corner = 1;             # top    left  hot corner -> noop
              wvous-bl-corner = 1;             # bottom left  hot corner -> noop
              persistent-apps = [
                "/System/Applications/iPhone Mirroring.app"
                "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
                "/Applications/Google Chrome.app"
                "/Applications/Spotify.app"
                "/System/Applications/Messages.app"
                "/System/Applications/Mail.app"
                "/System/Applications/Notes.app"
                "/Users/${username}/Applications/RubyMine.app"
                "/Users/${username}/Applications/GoLand.app"
                "/Users/${username}/Applications/IntelliJ IDEA Ultimate.app"
                "/Applications/Cursor.app"
                "/Applications/Visual Studio Code.app"
                "/Applications/Sublime Text.app"
                "/Applications/Ghostty.app"
                "/Applications/ChatGPT.app"
                "/Users/${username}/Applications/ChatGPT.app"
                "/Users/${username}/Applications/Grok.app"
                "/Applications/Claude.app"
                "/Users/${username}/Applications/Gemini.app"
                "/Users/${username}/Applications/Gemini Web.app"
                "/Applications/Perplexity.app"
                "/Users/${username}/Applications/Perplexity Web.app"
                "/Users/${username}/Applications/Phind.app"
                "/Users/${username}/Applications/Kagi.app"
                "/Users/${username}/Applications/DeepSeek.app"
                "/Users/${username}/Applications/Sourcegraph.app"
                "/Users/${username}/Applications/GitHub.app"
                "/Users/${username}/Applications/Grep.app"
                "/Users/${username}/Applications/PostHog.app"
                "/Users/${username}/Applications/v0.app"
                "/Users/${username}/Applications/Lovable.app"
                "/Users/${username}/Applications/tldraw.app"
                "/Users/${username}/Applications/Excalidraw.app"
                "/Users/${username}/Applications/QuickBooks.app"
                "/Users/${username}/Applications/Chrome Apps.localized/Sheets.app"
                "/Applications/Discord.app"
                "/System/Applications/Preview.app"
              ];
            };

            finder = {
              AppleShowAllExtensions = true;                         # show all filename extensions
              FXEnableExtensionChangeWarning = false;                # show warning before changing an extension off
              QuitMenuItem = true;                                   # allow quitting via ⌘ + Q
              ShowPathbar = true;                                    # show path bar at bottom
              FXPreferredViewStyle = "Nlsv";                         # use list view
              FXRemoveOldTrashItems = true;                          # remove items from Trash after 30 days

              NewWindowTarget = "Other";                                    # allow new window target
              NewWindowTargetPath = "file:///Users/${username}/Downloads/"; # set new window target path
            };

            ".GlobalPreferences" = {
              "com.apple.mouse.scaling" = -1.0; # disable mouse acceleration
            };

            NSGlobalDomain = {
              _HIHideMenuBar = false;
              "com.apple.sound.beep.volume" = 0.0;          # disable alert sound effect 
              NSNavPanelExpandedStateForSaveMode = true;    # expand save panel by default
              "com.apple.mouse.tapBehavior" = 1;            # enable tap to click for trackpad
              "com.apple.trackpad.scaling" = 0.875;         # faster trackpad speed
              "com.apple.trackpad.forceClick" = true;
              "com.apple.swipescrolldirection" = true;
              "com.apple.springing.delay" = 0.5;
              "com.apple.springing.enabled" = true;
              NSWindowShouldDragOnGesture = true;           # drag window by clicking
              AppleKeyboardUIMode = 3;                      # tab keyboard navigation for mac menus
              KeyRepeat = 1;                                # fast keyboard repeat rate
              InitialKeyRepeat = 10;                        # fast initial keyboard repeat rate
              ApplePressAndHoldEnabled = false;             # disable accent bar when holding key
              NSAutomaticSpellingCorrectionEnabled = false; # disable automatic text correction
              NSAutomaticDashSubstitutionEnabled = false;   # disable automatic text correction
              NSAutomaticQuoteSubstitutionEnabled = false;  # disable automatic text correction
            };

            screencapture = {
              disable-shadow = true; # disable screenshot shadow
              target = "clipboard";
            };

            LaunchServices = {
              LSQuarantine = false; # disable "Are you sure you want to open this application?" dialog
            };

            # Settings needing manual confirmation or complex setup:
            # - Keyboard auto-correction (best done via GUI System Settings -> Keyboard)
            # - Press Globe key action (best done via GUI System Settings -> Keyboard)
            # - Backlight timing (best done via GUI System Settings -> Keyboard or Display)
            # - Microsoft Receiver shortcuts (requires specific peripheral software, not Nix manageable)
            # - Keyboard Shortcuts (Mission Control, Hyper keys -> Requires Karabiner-Elements config)
            # - Paste and Match Style shortcut (GUI System Settings -> Keyboard -> Shortcuts -> App Shortcuts)
            # - Accessibility -> Pointer Control -> Trackpad Options -> Force Silent Clicking off / Enable Light click (GUI only)
            # - Accessibility -> Zoom settings (GUI only)
            # - Mission Control Hot Corners setup confirmed via GUI after `killall Dock`
            # - Display -> Slightly dim on battery (GUI System Settings -> Battery or Display)
            # - Terminal -> Preferences (Requires manual profile editing or managing plist)
            # - Finder Sidebar customization (GUI drag and drop)
            # - Finder Search Scope (GUI Finder -> Preferences -> Advanced)
            # - Safari Start Page / Status Bar / History / Advanced Settings (Mostly GUI / Safari Preferences)
            # - Mail / iMessage Settings (App Preferences GUI)
            # - Night Shift schedule (GUI System Settings -> Displays)
            # - Notification settings per app (GUI System Settings -> Notifications)
            # - Siri disable (GUI System Settings -> Siri & Spotlight)
            # - iCloud Drive Desktop/Documents sync disable (GUI Apple ID -> iCloud -> iCloud Drive Options)
            # - Remove Siri from menu bar (GUI System Settings -> Control Centre -> Drag Siri out)
            # - Accessibility -> Reduced Motion (GUI System Settings -> Accessibility -> Display)
            # - Spotlight Menu Bar Icon (Maybe `defaults write com.apple.Spotlight MenuItemHidden -bool true`? or use `services.spotlight.enable = false;` to disable spotlight indexing)
          };

          system.startup.chime = false;
          security.pam.services.sudo_local.touchIdAuth = true;

          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
            shell = pkgs.zsh;
          };

          system.stateVersion = 6;
          nixpkgs.hostPlatform = "aarch64-darwin";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          nixpkgs.config.allowUnfree = true;

          home-manager = {
            users.${username} = { pkgs', ... }: { 
              programs.git = {
                enable = true;
                userEmail = "13072760+roscrl@users.noreply.github.com"; # TODO fix parameterise
                userName = "roscrl";
                extraConfig = {
                  push.autoSetupRemote = true;
                  core.hooksPath = "/Users/${username}/Drive/Settings/dotfiles/scripts/hooks";
                  init.defaultBranch = "main";
                  pull.rebase = false;
                };
              };

              programs.zsh = {
                enable = true;
                autosuggestion.enable = true;
                syntaxHighlighting.enable = true;

                shellAliases = {
                  ".."  = "cd ..";   
                  "..." = "cd ../..";   
                  ll    = "ls -roAhtG";   
                  copy  = "tr -d '\\n' | pbcopy";   
                  g      = "git";
                  ga     = "git add . && git commit -am";
                  gcp    = "git add . && git commit --allow-empty-message -m '' && git push";
                  gs     = "git status";
                  gsw    = "git switch";
                  gp     = "git push";
                  gpe    = "git commit --amend --no-edit && git push —force-with-lease";
                  gpu    = "git pull";
                  gm     = "git merge";
                  gpur   = "git pull --rebase";
                  gl     = "git log --pretty=oneline";
                  gfe    = "git fetch";
                  gre    = "git rebase";
                  glr    = "git l -30";
                  ghs    = "git rev-parse --short HEAD";
                  ghm    = "git log --format=%B -n 1 HEAD";
                  gaa    = "git add -A";
                  gcm    = "git commit -m";
                  gd     = "git diff";
                  gdc    = "git diff --cached";
                  gco    = "git checkout";
                  gcdr   = "cd $(git rev-parse --show-toplevel)"; # cd to git root;
                  gopen  = "open_github";
                  gce    = "clone_cd_vim";
                  gc     = "clone_cd";
                  m      = "make";
                  deploy = "make deploy";
                  r      = "rails";
                  be     = "bundle exec";
                  v      = "nvim";
                  vi     = "nvim";
                  vim    = "nvim";
                  lg     = "lazygit";
                  ld     = "lazydocker";
                  tf     = "terraform";
                  # TODO change to config repo
                  ezsh     = "nvim ~/.zshrc && source ~/.zshrc";
                  evim     = "nvim ~/.config/nvim/init.vim";
                  eghostty = "nvim ~/.config/ghostty/config";
                  ekari    = "nvim ~/.config/karabiner/karabiner.json";
                  dotfiles   = "cd ~/Drive/Settings/dotfiles";
                  dev        = "cd ~/dev";
                  scratch    = "cd ~/dev/scratch";
                  expers     = "cd ~/dev/scratch/experiments";
                  repos      = "cd ~/dev/repos";
                  courses    = "cd ~/dev/courses";
                  references = "cd ~/dev/refrences";
                  drive      = "cd ~/Drive";
                  notes      = "cd ~/Notes";
                  down       = "cd ~/Downloads";
                  docs       = "cd ~/Documents";
                  walters    = "cd ~/dev/repos/walters";
                  scripts    = "cd ~/dev/scripts";
                  me         = "cd ~/dev/repos/roscrl.com";
                  posts      = "cd ~/dev/repos/roscrl.com/posts && nvim";
                  secrets    = "nvim ~/Drive/settings/dotfiles/.secrets && source ~/.zshrc";
                  todo       = "nvim ~/Notes/todo.txt";
                };

                initExtra = ''
                  source ~/Drive/settings/dotfiles/.secrets # secrets
                  source <(fzf --zsh)                       # fzf reverse search

                  setopt AUTO_CD          # cd by typing directory name if it's not a command
                  setopt auto_menu        # show completion menu automatically
                  setopt complete_in_word # allow completion from within words
                  setopt always_to_end    # move cursor to end of word on completion
                  setopt auto_pushd       # automatically push directories onto the stack
                  unsetopt CORRECT_ALL    # disable command correction  
                  unsetopt flowcontrol    # disable ^S/^Q flow control

                  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

                  function mkcd() { mkdir $1 && cd $1; }
                  function cnw() { open -na "Google Chrome" --args --new-window "$@" }
                  function killport() { lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9 }
                  function myip() { curl -s https://api.ipify.org; printf "\n" }
                  function grab() { find . -type f -print0 | while IFS= read -r -d \'\' file; do echo "$file\`\`\`"; cat "$file"; echo "\`\`\`"; done | pbcopy }
                  function denv() { eval "$(direnv hook zsh)" }
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

                  # prompt with git branch on right when in git folder https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
                  PROMPT='%B%F{blue}%2~%f%b %# '
                  autoload -Uz vcs_info
                  precmd_vcs_info() { vcs_info }
                  precmd_functions+=( precmd_vcs_info )
                  setopt prompt_subst
                  RPROMPT=\$vcs_info_msg_0_
                  zstyle ':vcs_info:git:*' formats '%F{240}%b%f'
                  zstyle ':vcs_info:*' enable git
                '';

                history = {
                  size = 100000;         
                  extended = true;       
                  share = true;          # share history between all sessions
                  ignoreDups = true;     # do not record an entry that was just recorded again
                  ignoreAllDups = true;  # delete old recorded entry if new entry is a duplicate
                  ignoreSpace = true;    # do not record an entry starting with a space
                  saveNoDups = true;     # do not display a line previously found.
                  findNoDups = true;     # do not write duplicate entries in the history file.
                };
              };

              home.file = {
                ".config/nvim".source                               = "${self}/settings/nvim";
                ".config/karabiner".source                          = "${self}/settings/karabiner";
              };

              home.stateVersion = "25.05";
            };
          };
        })
      ];
    };
  };
}

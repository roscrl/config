{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-direnv.url = "github:nix-community/nix-direnv";
    nix-direnv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nix-direnv, ... }@inputs: {
    darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager ({ pkgs, ... }: let username = "ross"; in {
          environment.systemPackages = with pkgs; [
            git
            neovim
            docker
            jq
            yq
            tree
            wget
            jujutsu
            sqlite          
            watchexec
            psrecord
            zsh-autosuggestions
            zsh-syntax-highlighting
            zsh-completions
            fzf
            direnv
            gh
            lefthook
            ripgrep
            claude-code
            tmux
            gemini-cli
            amp-cli
            opencode
            cursor-cli
            codex
            aider-chat
            ripgrep-all         # ripgrep but for pdf, zip, tar, sqlite
            httpie              # easy curl
            broot               # file tree navigation
            btop                # better htop
            zoxide              # better cd
            fd                  # find files
            hyperfine           # benchmark
            lazygit             # git tui
            lazydocker          # docker tui
            dive                # docker layer viewer
          ];

          homebrew = {
              enable = true;
              onActivation = {
                autoUpdate = true;
                upgrade = true;
                cleanup = "none";
              };
              casks = [
                "alfred"
                "linearmouse" 
                "karabiner-elements" 
                "betterdisplay"
                "ghostty"
                "rectangle"
                "bruno"
                "charles"
                "docker-desktop"
                "visual-studio-code"
                "cursor"
                "sublime-text"
                "zed" 
                "termius"
                "rubymine"
                "goland"
                "webstorm"
                "intellij-idea"
                "pycharm"
                "beekeeper-studio"
                "github"
                "istat-menus" 
                "cleanshot" 
                "superwhisper"
                "tailscale-app"
                "shifty" 
                "numi" 
                "google-chrome"
                "discord" 
                "spotify" 
                "signal" 
                "mullvad-vpn"
                "google-drive"
                "vlc"
                "transmission" 
                "calibre"
                "sloth"
                "fork"
                "font-ibm-plex-mono"
                "font-inter"
              ];
              brews = [ "mas" ];
              masApps = { "AdGuard for Safari" = 1440147259; };
          };

          home-manager = { # https://home-manager-options.extranix.com
            users.${username} = { ... }: { 
              home.file = {
                ".config/git".source                     = "${self}/settings/git";
                ".config/nvim".source                    = "${self}/settings/nvim";
                ".config/ghostty".source                 = "${self}/settings/ghostty";
                ".config/karabiner".source               = "${self}/settings/karabiner";
                ".config/appsscript".source              = "${self}/settings/appsscript";
                ".config/linearmouse".source             = "${self}/settings/linearmouse";
                ".config/manual/rectangle".source        = "${self}/settings/rectangle";  # manual: Rectangle.app requires config import via its UI
                ".config/manual/istatmenus".source       = "${self}/settings/istatmenus"; # manual: iStat Menus.app requires config import via its UI
                ".config/direnv/direnvrc".text           = "source ${nix-direnv}/direnvrc";
                ".config/direnv/direnv.toml".text        = builtins.readFile "${self}/settings/direnv/direnv.toml" + "\n" + ''
                  [whitelist]
                  prefix = [ "/Users/${username}/dev/projects" ]'';
                ".zshrc".text                            = with pkgs; builtins.readFile ./settings/zshrc/.zshrc + "\n" + ''
                  export PATH=$PATH:/opt/homebrew/bin:/Users/${username}/dev/tools/jai/bin:/Users/${username}/.local/bin
                  source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
                  source ${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
                  fpath=(${zsh-completions}/share/zsh-completions/src $fpath)
                  source <(fzf --zsh)
                  eval "$(zoxide init --cmd cd zsh)"
                  eval "$(${direnv}/bin/direnv hook zsh)"'';
                ".ideavimrc".source                      = "${self}/settings/ideavimrc/.ideavimrc";
                ".hushlogin".text                        = "";
                "dev/scripts".source                     = "${self}/scripts";
                "Library/Application\ Support/jj".source                               = "${self}/settings/jj";
                "Library/Application\ Support/Sublime Text/Packages/rsms-theme".source = "${self}/settings/sublime/rsms-theme";
                "Library/Application\ Support/Sublime Text/Packages/User".source       = "${self}/settings/sublime/User";
                # TODO alfred 
                # TODO cursor
                # TODO vscode 
                # TODO jetbrains
                # TODO .zsh_history 
                # TODO .zoxide history
                # TODO secrets + ssh_key
              };

              home.stateVersion = "25.05";
            };
          };

          # Use scripts/find_defaults.sh to find out which MacOS menu settings relate to which defaults settings
          system.defaults = { # https://nix-darwin.github.io/nix-darwin/manual/index.html
            dock = {
              autohide = true;                 # enable dock auto hiding
              autohide-delay = 0.0;            # make dock hide instantly
              autohide-time-modifier = 0.175;  # make dock show/hide faster
              launchanim = false;              # dont animate opening of applications
              expose-group-apps = true;        # group windows by application in Mission Control
              largesize = 128;                 # magnified icon size on hover
              show-process-indicators = false; # disable indicator lights for open applications
              mru-spaces = false;              # disable automatically rearrange spaces based on most recent use
              mineffect = "scale";             # use scale effect for window minimising/maximising
              show-recents = false;            # turn off show suggested and recent apps in dock
              tilesize = 58;                   # icon size
              wvous-tl-corner = 1;             # top-left    hot corner -> noop
              wvous-tr-corner = 1;             # top-right   hot corner -> noop
              wvous-br-corner = 1;             # top-left    hot corner -> noop
              wvous-bl-corner = 1;             # bottom-left hot corner -> noop
              expose-animation-duration = 0.1; # speed up mission control animations
              persistent-apps = [ # defaults read com.apple.dock persistent-apps | grep -i "_CFURLString"
                "/System/Applications/iPhone Mirroring.app"
                "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
                "/Applications/Google Chrome.app"
                "/Applications/Spotify.app"
                "/System/Applications/Messages.app"
                "/System/Applications/Mail.app"
                "/System/Applications/Notes.app"
                "/Applications/RubyMine.app"
                "/Applications/GoLand.app"
                "/Applications/IntelliJ IDEA.app"
                "/Applications/Cursor.app"
                "/Applications/Visual Studio Code.app"
                "/Applications/Sublime Text.app"
                "/Applications/Ghostty.app"
                "/Users/${username}/Applications/ChatGPT.app"
                "/Users/${username}/Applications/Grok.app"
                "/Users/${username}/Applications/Claude.app"
                "/Users/${username}/Applications/Gemini.app"
                "/Users/${username}/Applications/Gemini Web.app"
                "/Applications/Perplexity.app"
                "/Users/${username}/Applications/Perplexity Web.app"
                "/Users/${username}/Applications/NotebookLM.app"
                "/Users/${username}/Applications/Phind.app"
                "/Users/${username}/Applications/Kagi.app"
                "/Users/${username}/Applications/DeepSeek.app"
                "/Users/${username}/Applications/Sourcegraph.app"
                "/Users/${username}/Applications/Grep.app"
                "/Users/${username}/Applications/PostHog.app"
                "/Users/${username}/Applications/v0.app"
                "/Users/${username}/Applications/Lovable.app"
                "/Users/${username}/Applications/tldraw.app"
                "/Users/${username}/Applications/Uptime.app"
                "/Users/${username}/Applications/Cloudflare.app"
                "/Users/${username}/Applications/Hetzner.app"
                "/Users/${username}/Applications/AWS.app"
                "/Users/${username}/Applications/Excalidraw.app"
                "/Users/${username}/Applications/QuickBooks.app"
                "/Users/${username}/Applications/Chrome Apps.localized/Sheets.app"
                "/Applications/Discord.app"
                "/Users/${username}/Applications/Wise.app"
                "/Users/${username}/Applications/Stripe.app"
                "/System/Applications/Preview.app"
              ];
            };

            finder = {
              AppleShowAllExtensions = true;          # show all filename extensions
              AppleShowAllFiles = true;               # show all hidden files
              FXEnableExtensionChangeWarning = false; # disable warning before changing an extension
              QuitMenuItem = true;                    # allow quitting via ⌘ + Q
              ShowPathbar = true;                     # show path bar at bottom
              FXPreferredViewStyle = "Nlsv";          # use list view
              FXRemoveOldTrashItems = true;           # remove items from Trash after 30 days
              _FXShowPosixPathInTitle = true;         # display full POSIX path as finder window title
              FXDefaultSearchScope = "SCcf";          # search the current folder by default

              NewWindowTarget = "Other";                                   # allow new window target
              NewWindowTargetPath = "file:///Users/${username}/Downloads"; # set new window target path
            };

            trackpad = {
              FirstClickThreshold = 1;        # enable light click
              SecondClickThreshold = 1;       # enable light click
              ActuationStrength = 0;          # enable silent clicking
              Clicking = true;                # enable tap to click
              TrackpadRightClick = true;      # enable two tap right click
              TrackpadThreeFingerDrag = true; # enable three finger window drag
            };

            ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0; # disable mouse acceleration

            NSGlobalDomain = {
              _HIHideMenuBar = false;
              "com.apple.sound.beep.volume" = 0.0;          # disable alert sound effect 
              NSNavPanelExpandedStateForSaveMode = true;    # expand save panel by default
              NSNavPanelExpandedStateForSaveMode2 = true;   # expand save panel by default
              NSDocumentSaveNewDocumentsToCloud = false;    # save to disk (not iCloud) by default
              NSAutomaticWindowAnimationsEnabled = false;   # disable opening and closing animations of windows
              "com.apple.mouse.tapBehavior" = 1;            # enable tap to click for trackpad
              "com.apple.trackpad.scaling" = 0.875;         # faster trackpad speed
              "com.apple.trackpad.forceClick" = true;       # force click down on trackpad
              "com.apple.springing.delay" = 0.0;            # remove the delay for popping folders open with a dragged file
              "com.apple.springing.enabled" = true;
              NSWindowShouldDragOnGesture = true;           # drag window with cmd+click 
              AppleKeyboardUIMode = 3;                      # tab keyboard navigation for mac menus
              KeyRepeat = 1;                                # fast keyboard repeat rate
              InitialKeyRepeat = 10;                        # fast initial keyboard repeat rate
              ApplePressAndHoldEnabled = false;             # disable accent bar when holding key
              AppleFontSmoothing = 1;                       # light font smoothing
              NSAutomaticSpellingCorrectionEnabled = false; # disable automatic text correction
              NSAutomaticDashSubstitutionEnabled = false;   # disable automatic text correction
              NSAutomaticPeriodSubstitutionEnabled = false; # disable automatic text correction
              NSAutomaticCapitalizationEnabled = false;     # disable automatic text correction
              NSAutomaticQuoteSubstitutionEnabled = false;  # disable automatic text correction
            };

            CustomUserPreferences = {
              NSGlobalDomain.NSUserKeyEquivalents = { "Paste and Match Style" = "@$v"; }; # paste without formatting -> shift-command-v

              "com.apple.symbolichotkeys" = {
                AppleSymbolicHotKeys = {
                  "64"  = { enabled = false; }; # disable spotlight search
                  "65"  = { enabled = false; }; # disable spotlight finder search
                  "118" = { enabled = false; value = { parameters = [49 18 1966080]; type = "standard"; }; }; # 'Switch to Desktop 1' -> hyper+1
                  "119" = { enabled = false; value = { parameters = [50 19 1966080]; type = "standard"; }; }; # 'Switch to Desktop 2' -> hyper+2
                  "120" = { enabled = false; value = { parameters = [51 20 1966080]; type = "standard"; }; }; # 'Switch to Desktop 3' -> hyper+3
                  "32"  = { enabled = true; value = { parameters = [54 22 1966080]; type = "standard"; }; };  # 'Mission Control'     -> hyper+6
                };
              };

              "com.apple.AppleMultitouchTrackpad" = {
                TrackpadTwoFingerFromRightEdgeSwipeGesture = false;
              };

              "com.apple.Safari" = {
                ShowFullURLInSmartSearchField = true;
                AlwaysRestoreSessionAtLaunch = true;
                HomePage = "";
              };

              "com.apple.desktopservices" = {
                DSDontWriteNetworkStores = true; # avoid creating .DS_Store files on network
                DSDontWriteUSBStores = true;     # avoid creating .DS_Store files on usb
              };

              "com.apple.Accessibility".ReduceMotionEnabled = true;        # reduce motion
              "com.apple.universalaccess".showWindowTitlebarIcons = true;  # show file icon in finder on title bar
              "com.apple.finder".QLEnableTextSelection = true;             # allow text selection in Quick Look
              "com.apple.AppStore".InAppReviewEnabled = false;             # disable in app reviews
              "com.apple.AdLib".allowApplePersonalizedAdvertising = false; # disable in app reviews
            };

            screencapture = {
              disable-shadow = true; # disable screenshot shadow
              target = "clipboard";
            };

            menuExtraClock.Show24Hour = true;             # show 24 hour clock
            universalaccess.reduceMotion = true;          # require terminal to have 'System Settings > Privacy & Security > Full Disk Access'
            WindowManager.EnableTilingByEdgeDrag = false; # disable built in mac window tiling as Rectangle allows you to use shortcuts
            LaunchServices.LSQuarantine = false;          # disable "Are you sure you want to open this application?" dialog
          };

          system.startup.chime = false;                        # disable startup sound
          security.pam.services.sudo_local.touchIdAuth = true; # allow touch id for sudo

          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
            shell = pkgs.zsh;
          };

          nix.enable = false;

          system.stateVersion = 6;
          nixpkgs.hostPlatform = "aarch64-darwin";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          nixpkgs.config.allowUnfree = true;
          system.primaryUser = "${username}";
        })
      ];
    };
  };
}

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
            fzf
            silver-searcher
            ripgrep
            ripgrep-all         # ripgrep but for pdf, zip, tar, sqlite
            httpie              # easy curl
            broot               # file tree navigation
            btop                # better htop
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
                cleanup = "uninstall";
              };
              casks = [
                "alfred"
                "vlc"
                "bruno"
                "charles"
                "calibre"
                "ghostty"
                "visual-studio-code"
                "cursor"
                "zed" 
                "rubymine"
                "goland"
                "webstorm"
                "intellij-idea"
                "pycharm"
                "sublime-text"
                "github"
                "linearmouse" 
                "istat-menus" 
                "claude"
                "fork"
                "shifty" 
                "numi" 
                "karabiner-elements" 
                "discord" 
                "spotify" 
                "keepassxc" 
                "chatgpt"
                "google-chrome"
                "betterdisplay"
                "sloth"
                "rectangle"
                "signal" 
                "mullvadvpn"
                "transmission" 
                "font-ibm-plex-mono"
              ];
              brews = [ "mas" ];
              masApps = { "AdGuard for Safari" = 1440147259; };
          };

          home-manager = { # https://home-manager-options.extranix.com
            users.${username} = { pkgs', ... }: { 
              home.file = {
                ".config/git".source              = "${self}/settings/git";
                ".config/nvim".source             = "${self}/settings/nvim";
                ".config/ghostty".source          = "${self}/settings/ghostty";
                ".config/karabiner".source        = "${self}/settings/karabiner";
                ".config/appsscript".source       = "${self}/settings/appsscript";
                ".config/linearmouse".source      = "${self}/settings/linearmouse";
                ".config/manual/rectangle".source = "${self}/settings/rectangle"; # manual: Rectangle.app needs config import via its UI
                ".zshrc".source                   = "${self}/settings/zshrc/.zshrc";
                ".ideavimrc".source               = "${self}/settings/ideavimrc/.ideavimrc";
                ".hushlogin".text                 = "";
                "dev/scripts".source              = "${self}/settings/scripts";
                # TODO alfred 
                # TODO cursor
                # TODO vscode 
                # TODO jetbrains
                # TODO .zsh_history 
                # TODO secrets 
              };

              # programs.git = {
              #   enable = true;
              #   userEmail = "13072760+roscrl@users.noreply.github.com";
              #   userName = "roscrl";
              #   extraConfig = {
              #     push.autoSetupRemote = true;
              #     core.hooksPath = "${self}/settings/git/hooks";
              #     init.defaultBranch = "main";
              #     pull.rebase = false;
              #   };
              # };

              programs.direnv = {
                enable = true;
                nix-direnv.enable = true;
                config = {
                  global = {
                    warn_timeout = "0s";
                    hide_env_diff = true;
                  };
                };
              };

              programs.fzf.enable = true;

              home.stateVersion = "25.05";
            };
          };

          # Use settings/scripts/find_defaults.sh to find out which MacOS menu settings relate to which defaults settings
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
              wvous-tr-corner = 12;            # top-right   hot corner -> Notifications Center
              wvous-br-corner = 1;             # top-left    hot corner -> noop
              wvous-bl-corner = 1;             # bottom-left hot corner -> noop
              expose-animation-duration = 0.1; # speed up mission control animations
              persistent-apps = [
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
              ]; # TODO automate safari add to Dock web apps
            };

            finder = {
              AppleShowAllExtensions = true;          # show all filename extensions
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
              AppleFontSmoothing = 0;                       # disable font smoothing
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
                  "118" = { enabled = true; value = { parameters = [49 18 1966080]; type = "standard"; }; }; # 'Switch to Desktop 1' -> hyper+1
                  "119" = { enabled = true; value = { parameters = [50 19 1966080]; type = "standard"; }; }; # 'Switch to Desktop 2' -> hyper+2
                  "120" = { enabled = true; value = { parameters = [51 20 1966080]; type = "standard"; }; }; # 'Switch to Desktop 3' -> hyper+3
                  "32"  = { enabled = true; value = { parameters = [53 23 1966080]; type = "standard"; }; }; # 'Mission Control'     -> hyper+5
                };
              };

              "com.apple.universalaccess".showWindowTitlebarIcons = true; # show file icon in finder on title bar
              "com.apple.finder".QLEnableTextSelection = true;            # allow text selection in Quick Look
              "com.apple.AppStore".InAppReviewEnabled = false;            # disable in app reviews

              "com.apple.desktopservices" = {
                DSDontWriteNetworkStores = true; # avoid creating .DS_Store files on network
                DSDontWriteUSBStores = true;     # avoid creating .DS_Store files on usb
              };
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

          system.stateVersion = 6;
          nixpkgs.hostPlatform = "aarch64-darwin";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          nixpkgs.config.allowUnfree = true;
        })
      ];
    };
  };
}

{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Basic user info
  home.username = "schere";
  home.homeDirectory = "/home/schere";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # GNOME Extensions (based on your enabled extensions)
    gnomeExtensions.dash-to-dock
    gnomeExtensions.paperwm
    gnomeExtensions.color-picker
    gnomeExtensions.pano

    # Applications (based on your favorite-apps)
    brave
    dbeaver-bin
    postman
    slack
    steam
    discord
    onlyoffice-desktopeditors
    filezilla
    keepassxc
    syncthingtray
    obsidian

    # Development tools
    gh
    glab
    nodejs_24
    python314
    go

    # Terminal utilities
    lf
    fastfetch

    # Fonts
    jetbrains-mono

    # Security
    yubico-pam
    yubikey-manager

    # GNOME Tools
    gnome-tweaks
    dconf-editor
    yaru-theme
  ];

  # GNOME Desktop Environment Configuration
  dconf.settings = {
    # Desktop Interface Settings (your actual config)
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Yaru-prussiangreen-dark";
      icon-theme = "Yaru-prussiangreen-dark";
      monospace-font-name = "JetBrains Mono NL 10";
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    # Background Settings (your custom wallpaper)
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/schere/Pictures/Wallpapers/van_gogh.jpg";
      picture-uri-dark = "file:///home/schere/Pictures/Wallpapers/van_gogh.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    # Screensaver Settings
    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/schere/Pictures/Wallpapers/van_gogh.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    # Input Sources
    "org/gnome/desktop/input-sources" = {
      sources = [ (lib.gvariant.mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "compose:ralt" ];
    };

    # Touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      send-events = "enabled";
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    # Session
    "org/gnome/desktop/session" = {
      idle-delay = lib.gvariant.mkUint32 600;
    };

    # Sound
    "org/gnome/desktop/sound" = {
      theme-name = "Yaru";
    };

    # Window Manager Preferences
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "sloppy";
      workspace-names = [ "" "" "Workspace 3" "Workspace 4" ];
    };

    # Keybindings (disabled by PaperWM)
    "org/gnome/desktop/wm/keybindings" = {
      maximize = [];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-workspace-down = [];
      move-to-workspace-left = [];
      move-to-workspace-right = [];
      move-to-workspace-up = [];
      switch-applications = [];
      switch-applications-backward = [];
      switch-group = [];
      switch-group-backward = [];
      switch-panels = [];
      switch-panels-backward = [];
      switch-to-workspace-1 = [];
      switch-to-workspace-last = [];
      unmaximize = [];
      # Active workspace switching
      switch-to-workspace-left = [ "<Control><Alt><Super>Left" ];
      switch-to-workspace-right = [ "<Control><Alt><Super>Right" ];
    };

    # Custom Keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
      rotate-video-lock-static = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "ghostty";
      name = "Terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control><Alt>b";
      command = "brave";
      name = "Brave";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Control><Alt>e";
      command = "zed";
      name = "Zed";
    };

    # Power Settings
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };

    # Mutter Settings
    "org/gnome/mutter" = {
      attach-modal-dialogs = false;
      edge-tiling = false;
      workspaces-only-on-primary = false;
    };

    # Mutter Keybindings (disabled by PaperWM)
    "org/gnome/mutter/keybindings" = {
      cancel-input-capture = [];
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    # Shell Settings
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "paperwm@paperwm.github.com"
        "color-picker@tuberry"
        "pano@elhan.io"
      ];
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "dev.zed.Zed.desktop"
        "brave-browser.desktop"
        "slack.desktop"
        "postman.desktop"
        "dbeaver.desktop"
        "obsidian.desktop"
        "onlyoffice-desktopeditors.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Settings.desktop"
      ];
    };

    # Shell Keybindings (disabled by PaperWM)
    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      shift-overview-down = [];
      shift-overview-up = [];
      toggle-application-view = [];
      toggle-quick-settings = [];
      toggle-message-tray = [ "<Shift><Super>n" ];
    };

    # Notifications
    "org/gnome/desktop/notifications" = {
      show-banners = false;
    };

    # Nautilus Preferences
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "medium";
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "small-plus";
    };

    # Dash to Dock Configuration
    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      hot-keys = false;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "HDMI-1";
    };

    # Pano (Clipboard Manager) Configuration
    "org/gnome/shell/extensions/pano" = {
      global-shortcut = [ "<Shift><Super>v" ];
      is-in-incognito = true;
      send-notification-on-copy = false;
    };

    # PaperWM Configuration
    "org/gnome/shell/extensions/paperwm" = {
      cycle-height-steps = [ 0.33333 0.5 0.66666 ];
      cycle-width-steps = [ 0.33333 0.5 0.66666 ];
      gesture-workspace-fingers = 4;
      horizontal-margin = 16;
      open-window-position = 1;
      restore-attach-modal-dialogs = true;
      restore-edge-tiling = true;
      restore-workspaces-only-on-primary = true;
      selection-border-radius-bottom = 4;
      selection-border-radius-top = 4;
      selection-border-size = 8;
      vertical-margin = 16;
      window-gap = 16;
    };

    # PaperWM Keybindings
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [ "<Super>BackSpace" "<Super>q" ];
      move-down = [ "<Super>Down" ];
      move-left = [ "<Super>Left" ];
      move-monitor-above = [ "<Control><Super>Up" ];
      move-monitor-below = [ "<Control><Super>Down" ];
      move-monitor-left = [ "<Control><Super>Left" ];
      move-monitor-right = [ "<Control><Super>Right" ];
      move-right = [ "<Super>Right" ];
      move-up = [ "<Super>Up" ];
      switch-down = [ "<Super>s" ];
      switch-left = [ "<Super>a" ];
      switch-right = [ "<Super>d" ];
      switch-up = [ "<Super>w" ];
      toggle-top-and-position-bar = [ "<Control><Super>f" ];
    };
  };

  # Ghostty terminal configuration
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrains Mono Medium";
      font-size = 10;
      cursor-style = "block";
      theme = "catppuccin-macchiato";
    };
  };

  # Vim configuration
  programs.vim = {
    enable = true;
    settings = {
      number = true;
      relativenumber = true;
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Manu R. Schere";
    userEmail = "manu_schere@proton.me";

    signing = {
      key = "2764CD5DD674A4A3";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgsign = true;
      core.editor = "vim";

      credential = {
        helper = "store";
        "https://github.com".helper = "!/usr/bin/gh auth git-credential";
        "https://gist.github.com".helper = "!/usr/bin/gh auth git-credential";
      };

      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };

      cola = {
        spellcheck = false;
        theme = "flat-dark-grey";
        icontheme = "dark";
        tabwidth = 4;
        textwidth = 120;
        fontdiff = "JetBrains Mono,9,-1,5,50,0,0,0,0,0";
      };

      gui = {
        editor = "vim";
        historybrowser = "gitk";
      };
    };

    aliases = {
      a = "add";
      d = "diff";
      s = "status -sb";
      l = "log --oneline --graph";
      dv = "difftool -t vimdiff -y";
      br = "branch";
      sw = "switch";
      ch = "checkout";
      pl = "pull";
      ps = "push";
      ci = "commit";
      st = "stash";
      sp = "stash pop";
      sl = "stash list";
      aa = "add .";
      cm = "commit -m";
      rc = "reset HEAD~1 --soft";
      rr = "reset HEAD --hard";
      last = "log -1 HEAD --stat";
      gl = "config --global -l";
      se = "rev-list --all | xargs git grep -F";
      sf = "submodule foreach 'git fetch origin && git checkout origin/$(git branch --show-current)'";
    };
  };

  # Zsh configuration with Oh My Zsh
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "docker"
        "sudo"
        "history"
        "python"
        "npm"
        "tmux"
        "golang"
      ];
    };

    history = {
      size = 10000;
      save = 10000;
      share = true;
      expireDuplicatesFirst = true;
      extended = true;
    };

    historySubstringSearch.enable = true;

    shellAliases = {
      air = "$(go env GOPATH)/bin/air";
      templ = "$(go env GOPATH)/bin/templ";
      cl = "clear";
    };

    sessionVariables = {
      HIST_STAMPS = "dd/mm/yyyy";
      COMPLETION_WAITING_DOTS = "true";

      # Go environment
      GOPATH = "$HOME/go";
      GOBIN = "$HOME/go/bin";

      # PNPM
      PNPM_HOME = "$HOME/.local/share/pnpm";
    };

    profileExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$GOBIN:$PATH"

      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
    '';

    initContent = ''
      lfcd () {
          tmp="$(mktemp)"
          lf -last-dir-path="$tmp" "$@"
          if [ -f "$tmp" ]; then
              dir="$(cat "$tmp")"
              rm -f "$tmp"
              [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
          fi
      }

      bindkey -s '^o' 'lfcd\n'

      fastfetch

      if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
        export FPATH="$HOME/.zsh/completions:$FPATH"
      fi
    '';
  };

  # Tmux configuration
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    mouse = true;
    baseIndex = 1;
    historyLimit = 5000;
    terminal = "screen-256color";
    keyMode = "vi";

    extraConfig = ''
      set-option -g renumber-windows on
      set -g set-clipboard on
    '';

    plugins = with pkgs.tmuxPlugins; [
      yank
      resurrect
      continuum
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "catppuccin"
      "dockerfile"
      "git-firefly"
      "sql"
      "svelte"
      "terraform"
      "log"
      "solidity"
      "nix"
    ];
    userSettings = {
      show_edit_predictions = true;
      features = {
        edit_prediction_provider = "copilot";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      buffer_font_family = "JetBrains Mono";
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Macchiato";
      };
      agent = {
        always_allow_tool_actions = true;
        default_profile = "write";
        default_model = {
          provider = "copilot_chat";
          model = "claude-sonnet-4";
        };
        version = "2";
      };
      vim_mode = true;
      vim = {
        use_system_clipboard = "on_yank";
      };
      hard_tabs = true;
      tab_size = 2;
      preferred_line_length = 120;
      ui_font_size = 16;
      buffer_font_size = 15.0;
      relative_line_numbers = true;
      format_on_save = "on";
      project_panel = {
        auto_fold_dirs = false;
      };
      collaboration_panel = {
        button = false;
      };
      chat_panel = {
        button = "never";
      };
      notification_panel = {
        button = false;
      };
      languages = {
        TypeScript = {
          formatter = {
            external = {
              command = "prettier";
              arguments = ["--stdin-filepath" "{buffer_path}"];
            };
          };
          code_actions_on_format = {
            "source.fixAll.eslint" = true;
            "source.fixAll.prettier" = true;
            "source.removeUnusedImports" = true;
            "source.organizeImports" = true;
          };
        };
        TSX = {
          code_actions_on_format = {
            "source.removeUnusedImports" = true;
            "source.organizeImports" = true;
          };
        };
      };
    };
    userKeymaps = [
      {
        context = "Pane";
        bindings = {
          ctrl-f = "search::SelectNextMatch";
          ctrl-shift-f = "search::SelectPreviousMatch";
        };
      }
      {
        context = "AgentDiff || (Editor && editor_agent_diff)";
        bindings = {
          ctrl-shift-y = "agent::Keep";
          ctrl-shift-n = "agent::Reject";
          ctrl-alt-shift-y = "agent::KeepAll";
          ctrl-alt-shift-n = "agent::RejectAll";
          shift-ctrl-r = "agent::OpenAgentDiff";
        };
      }
      {
        context = "Editor";
        bindings = {
          ctrl-c = "editor::Copy";
          ctrl-x = "editor::Cut";
          ctrl-v = "editor::Paste";
          ctrl-y = "editor::Undo";
          ctrl-f = "buffer_search::Deploy";
          ctrl-o = "workspace::Open";
          ctrl-w = "pane::CloseActiveItem";
          ctrl-s = "workspace::Save";
          ctrl-d = "editor::SelectNext";
          ctrl-shift-d = "editor::SelectAllMatches";
          ctrl-tab = "pane::ActivateNextItem";
          ctrl-shift-tab = "pane::ActivatePreviousItem";
          "ctrl-." = "editor::ToggleCodeActions";
          ctrl-b = "workspace::ToggleLeftDock";
          ctrl-shift-b = "workspace::ToggleRightDock";
        };
      }
    ];
  };
}

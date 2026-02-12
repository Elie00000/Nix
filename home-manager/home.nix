{ config, pkgs, inputs, ... }:

let
  unstable = import <nixpkgs-unstable> { };
in
{
  # ============================================================================
  # HOME CONFIGURATION
  # ============================================================================
  home = {
    username = "elie";
    homeDirectory = "/home/elie";
    stateVersion = "25.11";
  };

  # ============================================================================
  # PACKAGES
  # ============================================================================
  home.packages = with pkgs; [
    # Utils
    lshw
    picom
    neofetch
    feh
    pywal
    polybar
    betterlockscreen
    i3lock-color
    mpv
    xwinwrap
    arandr
    udiskie

    # Apps
    vscode
    alsa-utils

    # Fonts
    material-design-icons
    noto-fonts
    noto-fonts-color-emoji
    font-awesome
    lato
    liberation_ttf
    open-sans
    roboto
    ubuntu-classic
    jetbrains-mono
    monaspace
    anonymousPro
    fira-code
    fira-code-symbols
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    comic-neue
    nerd-fonts.space-mono
    quicksand

    # i3 dependencies
    alacritty
    dmenu
    rofi
    flameshot
    skippy-xd
    networkmanagerapplet
    dex
    brightnessctl
  ];

  # ============================================================================
  # FONTS
  # ============================================================================
  fonts.fontconfig.enable = true;

  # ============================================================================
  # ALACRITTY
  # ============================================================================
  programs.alacritty = {
    enable = true;
    font.size = 11;

    colors = {
      primary = {
        background = "#fdfcfd";
        foreground = "#3E3B65";
      };
      normal = {
        black = "#fdfcfd";
        red = "#9AB2D7";
        green = "#DBB5D9";
        yellow = "#92CDE9";
        blue = "#ADD6EC";
        magenta = "#A7DAE9";
        cyan = "#6FE5ED";
        white = "#3E3B65";
      };
      bright = {
        black = "#938e93";
        red = "#9AB2D7";
        green = "#DBB5D9";
        yellow = "#92CDE9";
        blue = "#ADD6EC";
        magenta = "#A7DAE9";
        cyan = "#6FE5ED";
        white = "#3E3B65";
      };
      cursor = {
        text = "#fdfcfd";
        cursor = "#3E3B65";
      };
    };
  };

  # ============================================================================
  # CURSOR
  # ============================================================================
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # ============================================================================
  # ZSH
  # ============================================================================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      expireDuplicatesFirst = false;
    };

    initExtra = ''
      setopt HIST_FCNTL_LOCK
      source ${config.home.homeDirectory}/.p10k.zsh
    '';
  };

  home.file.".p10k.zsh".source = ./dotfiles/zsh/.p10k.zsh;

  # ============================================================================
  # I3 WINDOW MANAGER
  # ============================================================================
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod4";
      terminal = "alacritty";

      floating.modifier = "Mod4";

      gaps = {
        inner = 5;
        outer = 5;
        top = -5;
      };

      window.border = 0;

      keybindings =
        let
          mod = "Mod4";
        in
        {
          # Volume and audio controls
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          # Brightness controls
          "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10%";
          "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";

          # Core bindings
          "${mod}+Return" = "exec alacritty";
          "${mod}+Shift+c" = "kill";

          # Launchers
          "${mod}+d" = "exec dmenu_run";
          "${mod}+Shift+x" = "exec ~/.config/rofi/powermenu/type-4/powermenu.sh";
          "${mod}+r" = "exec ~/.config/rofi/launchers/type-4/launcher.sh";

          # Focus navigation
          "${mod}+j" = "focus left";
          "${mod}+k" = "focus down";
          "${mod}+l" = "focus up";
          "${mod}+semicolon" = "focus right";

          # Move window
          "${mod}+Shift+j" = "move left";
          "${mod}+Shift+k" = "move down";
          "${mod}+Shift+l" = "move up";
          "${mod}+Shift+semicolon" = "move right";

          # Split and fullscreen
          "${mod}+h" = "split h";
          "${mod}+v" = "split v";
          "${mod}+f" = "fullscreen toggle";

          # Layouts
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          # Floating and focus
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";

          # Reload and restart
          "${mod}+Shift+q" = "reload";
          "${mod}+Shift+r" = "restart";

          # Resize mode
          "${mod}+Shift+o" = ''mode "resize"'';

          # Screenshots
          "${mod}+Shift+s" = "exec QT_SCALE_FACTOR=0.8 flameshot gui";

          # Mouse wheel workspaces
          "${mod}+button4" = "workspace next";
          "${mod}+button5" = "workspace prev";

          # Workspaces
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          # Move to workspaces
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
        };

      modes = {
        resize = {
          "j" = "resize shrink width 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink height 10 px or 10 ppt";
          "semicolon" = "resize grow width 10 px or 10 ppt";

          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";

          "Return" = "mode default";
          "Escape" = "mode default";
          "Mod4+r" = "mode default";
        };
      };

      startup = [
        {
          command = "dex --autostart --environment i3";
          notification = false;
        }
        {
          command = "nm-applet";
          notification = false;
        }
        {
          command = "skippy-xd --start-daemon";
          notification = false;
        }
        {
          command = "feh --bg-scale ${~/wallpapers/MikuTeto.png}";
          always = true;
        }
        {
          command = "picom -b";
          always = true;
        }
        {
          command = "polybar";
          always = true;
        }
      ];

      window.commands = [
        {
          command = "floating enable";
          criteria = {
            class = "Flameshot";
          };
        }
      ];
    };
  };

  # ============================================================================
  # PICOM (Compositing Manager)
  # ============================================================================
  home.file.".config/picom/picom.conf".source = ./dotfiles/picom/picom.conf;

  home.sessionVariables = {
    PICOM_CONFIG = "${config.home.homeDirectory}/.config/picom/picom.conf";
    POLYBAR_CONFIG = "${config.home.homeDirectory}/.config/polybar/config";
  };

  home.activation.picom-setup = ''
    if ! pgrep -x picom >/dev/null; then
      picom --config $PICOM_CONFIG -b
    fi
  '';

  # ============================================================================
  # POLYBAR
  # ============================================================================
  home.file.".config/polybar/config".source = ./dotfiles/polybar/config.ini;

  home.activation.polybar-setup = ''
    pkill -x polybar || true
    polybar main --config=$POLYBAR_CONFIG &
  '';

  # ============================================================================
  # PICOM SERVICE (from i3.nix)
  # ============================================================================
  services.picom.enable = true;

  # ============================================================================
  # POLKIT GNOME AUTHENTICATION AGENT
  # ============================================================================
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}

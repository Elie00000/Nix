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

  xsession.windowManager.i3.enable = true;

  home.file.".config/i3/config".source = ./dotfiles/i3/config;

  home.sessionVariables = {
    I3_CONFIG = "${config.home.homeDirectory}/.config/i3/config";
  }

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
  home.file.".config/polybar/config".source = ./dotfiles/polybar/config;

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

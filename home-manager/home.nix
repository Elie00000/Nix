{ pkgs, inputs, ... }:

{
  # === Paquets ===
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
    shortwave
    nekoray

    # Terminals & Launchers
    alacritty
    rofi

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
  ];

  # === Fonts ===
  fonts.fontconfig.enable = true;

  # === Curseur ===
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # === Utilisateur ===
  home = {
    username = "elie";
    homeDirectory = "/home/elie";
    stateVersion = "26.05";
  };

  # === Zsh ===
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # === i3 ===
  programs.i3 = {
    enable = true;
    package = pkgs.i3;
    extraConfig = builtins.readFile ./dotfiles/i3/config;
  };

  # === Fichiers de config ===
  home.file = {
    # i3
    ".config/i3/config".source = ./dotfiles/i3/config;

    # Polybar
    ".config/polybar/config.ini".source = ./dotfiles/polybar/config;

    # Alacritty
    ".config/alacritty/alacritty.yml".source = ./dotfiles/alacritty/alacritty.toml;

    # Rofi
    ".config/rofi/config.rasi".source = ./dotfiles/rofi/config.rasi;

    # Betterlockscreen
    ".config/betterlockscreen/betterlockscreenrc".source = ./dotfiles/betterlockscreen/betterlockscreenrc;
  };

  # === Polybar via systemd user ===
  systemd.user.services.polybar = {
    Unit = {
      Description = "Polybar";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polybar}/bin/polybar -c ~/.config/polybar/config example";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # === Picom via systemd user ===
  systemd.user.services.picom = {
    Unit = {
      Description = "Picom compositor";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.picom}/bin/picom";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # === Agent d'authentification polkit ===
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

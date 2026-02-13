{ pkgs, ... }:

{
  # ==============================
  # USER INFO
  # ==============================
  home.username = "elie";
  home.homeDirectory = "/home/elie";
  home.stateVersion = "26.05";

  # ==============================
  # PACKAGES
  # ==============================
  home.packages = with pkgs; [
    lshw picom neofetch feh pywal polybar betterlockscreen
    i3lock-color mpv xwinwrap arandr udiskie
    alsa-utils shortwave nekoray
    alacritty rofi

    # Fonts
    material-design-icons noto-fonts noto-fonts-color-emoji
    font-awesome lato liberation_ttf open-sans roboto
    ubuntu-classic jetbrains-mono monaspace anonymousPro
    fira-code fira-code-symbols
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.space-mono
    comic-neue quicksand
  ];

  fonts.fontconfig.enable = true;

  # ==============================
  # CURSOR
  # ==============================
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # ==============================
  # ZSH (user)
  # ==============================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # ==============================
  # FILES
  # ==============================
  home.file = {
    ".config/i3/config".source = ./dotfiles/i3/config;
    ".config/polybar/config.ini".source = ./dotfiles/polybar/config;
    ".config/alacritty/alacritty.toml".source =
      ./dotfiles/alacritty/alacritty.toml;
    ".config/rofi/config.rasi".source =
      ./dotfiles/rofi/config.rasi;
    ".config/betterlockscreen/betterlockscreenrc".source =
      ./dotfiles/betterlockscreen/betterlockscreenrc;
  };

  # ==============================
  # USER SERVICES
  # ==============================
  systemd.user.services.polybar = {
    Unit = {
      Description = "Polybar";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart =
        "${pkgs.polybar}/bin/polybar -c ~/.config/polybar/config.ini example";
      Restart = "always";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.picom}/bin/picom";
      Restart = "always";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "Polkit Agent";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

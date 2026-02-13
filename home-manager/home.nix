{ pkgs, inputs, ... }: 
    let
        unstable = import <nixpkgs-unstable> { };
        pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
    in {
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

        # Fonts
        material-design-icons
        noto-fonts
        noto-fonts-emoji
        font-awesome
        lato
        liberation_ttf
        open-sans
        roboto
        ubuntu_font_family
        jetbrains-mono
        monaspace
        anonymousPro
        fira-code
        fira-code-symbols
        material-design-icons
        nerd-fonts._0xproto
        nerd-fonts.droid-sans-mono
        comic-neue
        nerd-fonts.space-mono
        quicksand
    ];
  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  home = {
    username = "elie";
    homeDirectory = "/home/elie";
    stateVersion = "26.05";
  };
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
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
}

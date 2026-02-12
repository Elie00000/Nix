# configuration.nix - Configuration système complète consolidée
{ config, pkgs, lib, ... }:

{
  # ==============================
  # BOOTLOADER (bootloader.nix)
  # ==============================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ==============================
  # HOSTNAME ET SYSTÈME
  # ==============================
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ==============================
  # LOCALE ET KEYBOARD (locale.nix)
  # ==============================
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # ==============================
  # TIMEZONE
  # ==============================
  time.timeZone = "Europe/Paris";

  # ==============================
  # NIX CONFIGURATION (pkgs.nix)
  # ==============================
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];

  # ==============================
  # SYSTÈME PACKAGES (pkgs.nix)
  # ==============================
  environment.systemPackages = with pkgs; [
    # Utils
    wget
    curl
    git
    cmake

    # Tools
    home-manager
    htop
    pciutils
    rofi
    flameshot

    # Desktop apps
    alacritty
    pavucontrol
    discord
    nautilus
    firefox

    # Additional
    xorg.xrdb
  ];

  # ==============================
  # STEAM (pkgs.nix)
  # ==============================
  programs.steam.enable = true;

  # ==============================
  # UTILISATEUR PRINCIPAL (user.nix)
  # ==============================
  users.users.elie = {
    isNormalUser = true;
    description = "Elie";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # ==============================
  # SHELL ZSH PAR DÉFAUT (zsh.nix)
  # ==============================
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      upd = "sudo nixos-rebuild switch --flake /etc/nixos";
      cdn = "cd /etc/nixos";
    };

    ohMyZsh.enable = true;

    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10k.zsh
      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [ "HIST_IGNORE_ALL_DUPS" ];
  };

  # ==============================
  # FIREWALL (firewall.nix)
  # ==============================
  #networking.firewall = {
  #  enable = true;
  #  allowedTCPPorts = [
  #    80      # HTTP
  #    443     # HTTPS
  #    57537   # Custom
  #    8080    # Development
  #  ];
    # allowedUDPPorts = [ 123 ];
    # allowedTCPPortRanges = [ { from = 4000; to = 4007; } ];
  #};

  # ==============================
  # PAM SERVICES (pam.nix)
  # ==============================
  security.pam.services = {
    i3lock.enable = true;
    xlock.enable = true;
    xscreensaver.enable = false;
  };

  # ==============================
  # AUDIO - PIPEWIRE (pipewire.nix)
  # ==============================
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ==============================
  # AUTRES SERVICES (services.nix)
  # ==============================
  services.printing.enable = true;
  security.rtkit.enable = true;
  # services.v2raya.enable = true;
  services.gvfs.enable = true;

  # ==============================
  # XSERVER - DISPLAY MANAGER (xserver.nix)
  # ==============================

  # LightDM Display Manager
  services.xserver.displayManager.lightdm = {
    enable = true;
    extraConfig = ''
      user-background = false
    '';
    background = "/home/elie/wallpapers/login.jpg";
  };

  # LightDM GTK Greeter
  services.xserver.displayManager.lightdm.greeters.gtk = {
    theme.name = "Adwaita-dark";
    iconTheme.name = "Papirus-Dark";
    cursorTheme.name = "Bibata-Modern-Ice";
    extraConfig = ''
      [greeter]
      show-indicators=
      position = 50%,center 85%,center
      # default-user-image = '/home/elie/wallpapers/avatar.png'
      font-name = Quicksand 12
      text-color = #e0e0e0
      panel-background-color = rgba(0,0,0,0.0)
      background-color = #000000
      xft-dpi = 120
    '';
  };

  # Xserver configuration
  services.xserver = {
    enable = true;
    windowManager.openbox.enable = true;
    windowManager.i3.enable = true;
    layout = "fr";
  };

  # Default session
  services.displayManager.defaultSession = "none+i3";

  # Autorandr for display management
  services.autorandr.enable = true;

  # Xresources configuration
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
      Xft.dpi: 120
    ''}
  '';

  # ==============================
  # VERSION NIXOS
  # ==============================
  system.stateVersion = "25.11";
}

{ config, pkgs, lib, ... }:

let
  # ==============================
  # VARIABLES GLOBALES
  # ==============================
  wallpaperDir = "/home/elie/.config/home-manager/dotfiles/wallpaper";
  username = "elie";
in {
  # ==============================
  # BOOTLOADER
  # ==============================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ==============================
  # HOSTNAME & RÉSEAU
  # ==============================
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ==============================
  # LOCALE & CLAVIER
  # ==============================
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = builtins.listToAttrs [
    { name = "LC_ADDRESS";      value = "fr_FR.UTF-8"; }
    { name = "LC_IDENTIFICATION"; value = "fr_FR.UTF-8"; }
    { name = "LC_MEASUREMENT";   value = "fr_FR.UTF-8"; }
    { name = "LC_MONETARY";      value = "fr_FR.UTF-8"; }
    { name = "LC_NAME";          value = "fr_FR.UTF-8"; }
    { name = "LC_NUMERIC";       value = "fr_FR.UTF-8"; }
    { name = "LC_PAPER";         value = "fr_FR.UTF-8"; }
    { name = "LC_TELEPHONE";     value = "fr_FR.UTF-8"; }
    { name = "LC_TIME";          value = "fr_FR.UTF-8"; }
  ];

  # ==============================
  # FUSEAU HORAIRE
  # ==============================
  time.timeZone = "Europe/Paris";

  # ==============================
  # NIX & PACKAGES GLOBAUX
  # ==============================
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

  environment.systemPackages = with pkgs; [
    # Utils
    wget curl git cmake
    # Tools
    home-manager htop pciutils rofi flameshot
    # Desktop apps
    alacritty pavucontrol discord nautilus firefox
    # Additional
    xorg.xrdb
  ];

  # ==============================
  # UTILISATEUR
  # ==============================
  users.users.${username} = {
    isNormalUser = true;
    description = "Elie";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # ==============================
  # SHELL (ZSH)
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
      zap = "./zapret-discord-youtube-linux/main_script.sh";
      edit = "sudo -e";
      upd = "sudo nixos-rebuild switch --flake /etc/nixos";
      cdn = "cd /etc/nixos";
    };

    ohMyZsh = {
      enable = true;
    };

    promptInit = ''
      # this act as your ~/.zshrc but for all users (/etc/zshrc)
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10k.zsh
      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };


  # ==============================
  # SERVICES
  # ==============================
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    gvfs.enable = true;
    autorandr.enable = true;
    steam.enable = true;
  };

  # ==============================
  # DISPLAY MANAGER (LightDM)
  # ==============================
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      extraConfig = ''
        user-background = false
      '';
      background = "${wallpaperDir}/login.jpg";
      greeters.gtk = {
        theme.name = "Adwaita-dark";
        iconTheme.name = "Papirus-Dark";
        cursorTheme.name = "Bibata-Modern-Ice";
        extraConfig = ''
          [greeter]
          show-indicators=
          position = 50%,center 85%,center
          font-name = Quicksand 12
          text-color = #e0e0e0
          panel-background-color = rgba(0,0,0,0.0)
          background-color = #000000
          xft-dpi = 120
        '';
      };
    };
    defaultSession = "none+i3";
  };

  # ==============================
  # XSERVER & WINDOW MANAGER
  # ==============================
  services.xserver = {
    enable = true;
    windowManager.openbox.enable = true;
    windowManager.i3.enable = true;
    layout = "fr";
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        Xft.dpi: 120
      ''}
    '';
  };

  # ==============================
  # FIREWALL (commenté par défaut)
  # ==============================
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 80 443 57537 8080 ];
  # };

  # ==============================
  # PAM & SÉCURITÉ
  # ==============================
  security = {
    pam.services = {
      i3lock.enable = true;
      xlock.enable = true;
      xscreensaver.enable = false;
    };
  };

  # ==============================
  # VERSION NIXOS
  # ==============================
  system.stateVersion = "26.05";
}

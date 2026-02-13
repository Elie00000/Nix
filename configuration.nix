{ config, pkgs, lib, ... }:

let
  wallpaperDir = "/home/elie/.config/home-manager/dotfiles/wallpaper";
  username = "elie";
in {
  imports = [
    ./hardware-configuration.nix
  ];

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
  # LOCALE & TIMEZONE
  # ==============================
  i18n.defaultLocale = "fr_FR.UTF-8";
  time.timeZone = "Europe/Paris";

  # ==============================
  # NIX
  # ==============================
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

  # ==============================
  # SYSTEM PACKAGES
  # ==============================
  environment.systemPackages = with pkgs; [
    wget curl git cmake
    home-manager htop pciutils rofi flameshot
    alacritty pavucontrol discord nautilus firefox
    xorg.xrdb
  ];

  # ==============================
  # USER
  # ==============================
  users.users.${username} = {
    isNormalUser = true;
    description = "Elie";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.defaultUserShell = pkgs.zsh;

  # ==============================
  # ZSH (global)
  # ==============================
  programs.zsh.enable = true;

  # ==============================
  # SERVICES
  # ==============================
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.printing.enable = true;
  services.gvfs.enable = true;
  services.autorandr.enable = true;

  # ==============================
  # X11 + I3
  # ==============================
  services.xserver = {
    enable = true;
    xkb.layout = "fr";

    displayManager.lightdm = {
      enable = true;
      background = "${wallpaperDir}/login.jpg";

      greeters.gtk = {
        theme.name = "Adwaita-dark";
        iconTheme.name = "Papirus-Dark";
        cursorTheme.name = "Bibata-Modern-Ice";
      };
    };

    windowManager.i3.enable = true;

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        Xft.dpi: 120
      ''}
    '';
  };

  services.displayManager.defaultSession = "none+i3";

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

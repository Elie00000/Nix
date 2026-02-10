{ config, pkgs, lib, ... }: {

  imports =
    [
      ./hardware-configuration.nix
      ./modules/bootloader.nix
      ./modules/locale.nix
      ./modules/user.nix
      ./modules/pkgs.nix
      ./modules/xserver.nix
      ./modules/pipewire.nix
      ./modules/services.nix
      ./modules/pam.nix
      ./modules/zsh.nix
#      ./modules/firewall.nix
    ];

  networking.hostName = "elienixos";

  hardware.graphics = {
    enable = true;
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  system.stateVersion = "25.11"; # Don't Change It

}


{ config, pkgs, lib, ... }: {

  imports =
    [
      ./hardware-configuration.nix
      ./modules/bootloader.nix
      ./modules/locale.nix
      ./modules/user.nix
      ./modules/pkgs.nix
      ./modules/xserver.nix
      ./modules/nvidia.nix
      ./modules/pipewire.nix
      ./modules/services.nix
      ./modules/pam.nix
      ./modules/firewall.nix
    ];

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  system.stateVersion = "25.05"; # Don't Change It

}


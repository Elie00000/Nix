{
  imports = [
    ./pkgs.nix
    ./zsh.nix
    ./polkit.nix
    ./cursor.nix
    ./i3.nix
    ./alacritty.nix
    ./picom.nix
    ./polybar.nix
  ];

  home = {
    username = "elie";
    homeDirectory = "/home/elie";
    stateVersion = "25.11";
  };
}

{
  imports = [
    ./pkgs.nix
    ./zsh.nix
    ./polkit.nix
    ./cursor.nix
  ];

  home = {
    username = "elie";
    homeDirectory = "/home/elie";
    stateVersion = "25.11";
  };
}

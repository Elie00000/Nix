{
  imports = [
    ./pkgs.nix
    ./zsh.nix
    ./polkit.nix
    ./cursor.nix
  ];

  home = {
    username = "aiko";
    homeDirectory = "/home/aiko";
    stateVersion = "25.05";
  };
}

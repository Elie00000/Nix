{
  description = "Home manager"

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... } @ inputs:
  let
    system = "x86_64-linux";
  in {
    homeConfigurations.aiko = home-manager.lib.homeManagerConfiguration {
      inherit system;
      pkgs = import nixpkgs { inherit system; };

      extraSpecialArgs = { inherit inputs; };

      modules = [
        ./home.nix
        ./zen.nix
      ];
    };
  };
}

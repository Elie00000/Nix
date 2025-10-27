{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    envycontrol = {
      url = "github:bayasdev/envycontrol";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

 outputs = { self, nixpkgs, home-manager, envycontrol, zen-browser, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          {
            environment.systemPackages = with pkgs; [
              (python3Packages.buildPythonApplication rec {
                pname = "envycontrol";
                version = "3.5.2";

                src = pkgs.fetchFromGitHub {
                  owner = "bayasdev";
                  repo = "envycontrol";
                  rev = "v${version}";
                  sha256 = "sha256-FZMkYHUAA3keV7OSqzEIu0k1rdgDS0VP3nPBLBzbaeM=";
                };

                pyproject = true;
                build-system = [ python3Packages.setuptools ];

                propagatedBuildInputs = with python3Packages; [
                  click
                  psutil
                  pygobject3
                ];

                doCheck = false;
              })
            ];

            services.switcherooControl.enable = true;
          }
        ];
      };
    homeConfigurations.aiko = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home-modules/home.nix ];
   
};
};
}



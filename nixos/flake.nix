{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    envycontrol = {
      url = "github:bayasdev/envycontrol";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

 outputs = { self, nixpkgs, envycontrol, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/pkgs.nix
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
   };
}



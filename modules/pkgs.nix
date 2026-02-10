{ pkgs, lib, zen-browser, ... }: {
    
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ 
        "nix-command" "flakes"
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "vscode"
    ];

    programs.steam.enable = true;

    programs.nekoray.tunMode.enable = true;
    
    environment.systemPackages = with pkgs; [
        wget
        home-manager
        git
        rofi
        flameshot
        cmake
#       tint2

        #Apps    
        alacritty
        pavucontrol
        discord
        nautilus
        firefox
    
        #Other
        htop	
        pciutils
    ];
}

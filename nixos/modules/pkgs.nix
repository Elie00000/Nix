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
        neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        home-manager
        git
        rofi
        flameshot
        cmake
#       tint2

        #Apps    
        alacritty
        obs-studio
        obsidian
        pavucontrol
        telegram-desktop
        vesktop
        google-chrome
        nautilus
    
        #Other
        htop	
        pciutils
    ];
}

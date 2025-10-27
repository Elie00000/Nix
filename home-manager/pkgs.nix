{ pkgs, inputs, ... }: 
    let
        unstable = import <nixpkgs-unstable> { };
        pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
    in {
        home.packages = with pkgs; [

        # Utils
        lshw
        picom    
        neofetch
        feh
        pywal
        polybar
        betterlockscreen
        i3lock-color
        mpv
        xwinwrap
        arandr
        udiskie

        # Apps
        vscode
        alsa-utils
        shortwave 
	nekoray

        # Fonts
        material-design-icons
        noto-fonts
        noto-fonts-emoji
        font-awesome
        lato
        liberation_ttf
        open-sans
        roboto
        ubuntu_font_family
        jetbrains-mono
        monaspace
        anonymousPro
        fira-code
        fira-code-symbols
        material-design-icons
        nerd-fonts._0xproto
        nerd-fonts.droid-sans-mono
        comic-neue
        nerd-fonts.space-mono
        quicksand
    ];
  fonts.fontconfig.enable = true;
}

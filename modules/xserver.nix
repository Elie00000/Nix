{ pkgs, ... }: {
    services.xserver.displayManager.lightdm = {
        enable = true;
        extraConfig = ''
        user-background = false
        '';
        background = "/etc/nixos/backgrounds/login.jpg";
    };
  
    services.xserver.displayManager.lightdm.greeters.gtk = {
        theme.name = "Adwaita-dark";
        iconTheme.name = "Papirus-Dark";
        cursorTheme.name = "Bibata-Modern-Ice";
        extraConfig = ''
        [greeter]
        show-indicators=
        position = 50%,center 85%,center
#       default-user-image = '/etc/nixos/backgrounds/avatar.png'
        font-name = Quicksand 12
        text-color = #e0e0e0
        panel-background-color = rgba(0,0,0,0.0)
        background-color = #000000
        xft-dpi = 120
        '';
    };

    services.xserver = {
        enable = true;
        windowManager. openbox.enable = true;
        windowManager.i3.enable = true;
        layout = "fr";
    };

    services.displayManager = {
        defaultSession = "none+i3";
    };

    services.autorandr.enable = true;
    services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        Xft.dpi: 120
        ''}
    '';
}

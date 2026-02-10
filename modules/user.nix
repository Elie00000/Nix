{ pkgs, ... }: {
    users.users.elie = {
        isNormalUser = true;
        description = "Elie";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };
}

{ pkgs, ... }: {
    users.users.aiko = {
        isNormalUser = true;
        description = "Aiko";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };
}
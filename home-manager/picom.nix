{ config, pkgs, ... }:

{
  home.packages = [ pkgs.picom ]; # installe le binaire

  home.file.".config/picom/picom.conf".source = ./dotfiles/picom/picom.conf;

  # optionnel : lancer picom au démarrage via Home Manager
  home.sessionVariables = {
    PICOM_CONFIG = "${config.home.homeDirectory}/.config/picom/picom.conf";
  };

  home.activation.start = ''
    # lance picom au démarrage si pas déjà lancé
    if ! pgrep -x picom >/dev/null; then
      picom --config $PICOM_CONFIG -b
    fi
  '';
}

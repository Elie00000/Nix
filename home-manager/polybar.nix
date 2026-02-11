{ config, pkgs, ... }:

{
  # Installer le binaire
  home.packages = [ pkgs.polybar ];

  # Copier le fichier config
  home.file.".config/polybar/config".source = ./dotfiles/polybar/config.ini;

  # Optionnel : lancer Polybar au démarrage
  home.sessionVariables = {
    POLYBAR_CONFIG = "${config.home.homeDirectory}/.config/polybar/config";
  };

  home.activation.start = ''
    # tuer d'abord Polybar si déjà lancé
    pkill -x polybar || true

    # lancer Polybar main
    polybar main --config=$POLYBAR_CONFIG &
  '';
}

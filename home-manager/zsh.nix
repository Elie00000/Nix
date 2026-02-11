{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      expireDuplicatesFirst = false;
    };

    initExtra = ''
      setopt HIST_FCNTL_LOCK
      source ${config.home.homeDirectory}/.p10k.zsh
    '';
  };

  home.file.".p10k.zsh".source = ./dotfiles/p10k/.p10k.zsh;
}

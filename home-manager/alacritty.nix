{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    font.size = 11;

    colors = {
      primary = { background = "#fdfcfd"; foreground = "#3E3B65"; };
      normal = {
        black = "#fdfcfd"; red = "#9AB2D7"; green = "#DBB5D9"; yellow = "#92CDE9";
        blue = "#ADD6EC"; magenta = "#A7DAE9"; cyan = "#6FE5ED"; white = "#3E3B65";
      };
      bright = {
        black = "#938e93"; red = "#9AB2D7"; green = "#DBB5D9"; yellow = "#92CDE9";
        blue = "#ADD6EC"; magenta = "#A7DAE9"; cyan = "#6FE5ED"; white = "#3E3B65";
      };
      cursor = { text = "#fdfcfd"; cursor = "#3E3B65"; };
    };
  };
}

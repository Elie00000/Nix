{ config, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod4";
      terminal = "alacritty";

      floating.modifier = "Mod4";

      gaps = {
        inner = 5;
        outer = 5;
        top = -5;
      };

      window.border = 0;

      keybindings = let
        mod = "Mod4";
      in {
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";

        "${mod}+Return" = "exec alacritty";
        "${mod}+Shift+c" = "kill";

        "${mod}+d" = "exec dmenu_run";
        "${mod}+Shift+x" = "exec ~/.config/rofi/powermenu/type-4/powermenu.sh";
        "${mod}+r" = "exec ~/.config/rofi/launchers/type-4/launcher.sh";

        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        "${mod}+h" = "split h";
        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";

        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";

        "${mod}+Shift+q" = "reload";
        "${mod}+Shift+r" = "restart";

        "${mod}+Shift+o" = ''mode "resize"'';

        "${mod}+Shift+s" = "exec QT_SCALE_FACTOR=0.8 flameshot gui";

        "${mod}+button4" = "workspace next";
        "${mod}+button5" = "workspace prev";

        # Workspaces
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";
      };

      modes = {
        resize = {
          "j" = "resize shrink width 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink height 10 px or 10 ppt";
          "semicolon" = "resize grow width 10 px or 10 ppt";

          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";

          "Return" = "mode default";
          "Escape" = "mode default";
          "Mod4+r" = "mode default";
        };
      };

      startup = [
        { command = "dex --autostart --environment i3"; notification = false; }
        { command = "nm-applet"; notification = false; }
        { command = "skippy-xd --start-daemon"; notification = false; }
        { 
          command = "feh --bg-scale ${./wallpapers/MikuTeto.png}";
          always = true;
        }
        { command = "picom -b"; always = true; }
        { command = "polybar"; always = true; }
      ];

      window.commands = [
        {
          command = "floating enable";
          criteria = { class = "Flameshot"; };
        }
      ];
    };
  };

  services.picom.enable = true;

  home.packages = with pkgs; [
    alacritty
    dmenu
    rofi
    flameshot
    feh
    polybar
    skippy-xd
    networkmanagerapplet
    dex
    brightnessctl
  ];
}

{pkgs, ...}: {
  programs.home-manager.enable = true;
  
  home = {
    username = "jack";
    homeDirectory = "/home/jack";
    stateVersion = "26.11";
    packages = with pkgs; [
      wmenu
      brightnessctl
      grim
      slurp
      git-credential-manager
      opencode
      chromium
    ];
  };

  # --- FOOT ---
  programs.foot = {
    enable = true;
  };

  # --- SWAY ---
  wayland.windowManager.sway = {
    enable = true;
    xwayland = false;
    config = {
      modifier = "Mod4";
      menu = "wmenu-run";
      terminal = "foot";
      bars = [{command = "${pkgs.waybar}/bin/waybar";}];
      window.titlebar = false;
      keybindings = pkgs.lib.mkOptionDefault {
        # Volume
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        # Brightness
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        # Screenshot
        "Print" = "exec grim $HOME/Pictures/$(date +'%Y-%m-%d_%H%M%S').png";
        "XF86SelectiveScreenshot" = "exec grim -g \"$(slurp)\" $HOME/Pictures/$(date +'%Y-%m-%d_%H%M%S').png";
      };
    };
  };

  # --- GIT ---
  programs.git = {
    enable = true;
    settings = {
      credential = {
        helper = "manager";
        credentialStore = "cache";
        guiPrompt = false;
      };
      user = {
        name = "Jack";
        email = "jackkempler@gmail.com";
      };
    };
  };
  
  # --- FIREFOX ---
  programs.firefox = {
    enable = true;
  };

  # --- WAYBAR ---
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 10;
        modules-left = ["sway/workspaces" "sway/mode"];
        modules-center = ["clock#time" "clock#date"];
        modules-right = ["bluetooth" "network" "wireplumber" "backlight" "memory" "battery"];

        "clock#time" = {
          format = "{:%I:%M:%S %p}";
          interval = 1;
          tooltip = false;
        };
        "clock#date" = {
          format = "{:%A, %b %d %Y}";
          tooltip = false;
        };
        "battery" = {
          battery = "BAT0";
          format = "{capacity}% {icon}";
          format-icons = {
            default = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          };
          interval = 10;
          tooltip = false;
        };

        "custom/pomodoro" = {
          format = "IMPLEMENT ME!";
          tooltip = false;
        };

        "bluetooth" = {
          format-off = "󰂲";
          format-on = "󰂯";
          format-discovering = "󰂰";
          format-connected = "{device_alias} {device_battery_percentage}%";
          tooltip = false;
        };

        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = ["󰌶" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
          tooltip = false;
        };

        "memory" = {
          format = "{used} GB ({percentage}%)";
          tooltip = false;
        };

        "wireplumber" = {
          format = "{volume}% {icon}";
          format-icons = ["" "" ""];
          tooltip = false;
        };

        "network" = {
          format = "{essid} {icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          tooltip = false;
        };
      };
    };
    style = ''
      * {
        background: transparent;
        padding: 0px 5px;
        color: white;
        border: none;
        min-width: 0px;
        min-height: 0px;
        font-size: 12px;
      }


      #workspaces button {
        margin-left: 0px;
        font-size: 9px;
        border-bottom: 3px solid transparent;
        border-radius: 0px;
      }

      #workspaces button.focused {
        border-bottom: 3px solid white;
      }
    '';
  };

  # --- GAMMASTEP ---
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 43.07;
    longitude = -89.40;
    temperature = {
      day = 6500;
      night = 2500;
    };
    settings = {
      general = {
        brightness-day = 1.0;
        brightness-night = 0.9;
        gamma = "0.8:0.8:0.8";
        adjustment-method = "wayland";
      };
    };
  };
}

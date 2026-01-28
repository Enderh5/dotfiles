{ config, lib, pkgs, user, ... }:

{
    home.packages = [
      pkgs.mpc-cli
    ];
    
    programs.waybar = {
      enable = false;
      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
      style = ''
               * {
                 font-family: "JetBrainsMono Nerd Font";
                 font-size: 12pt;
                 font-weight: bold;
                 border-radius: 0px;
                 transition-property: background-color;
                 transition-duration: 0.5s;
               }
               @keyframes blink_red {
                 to {
                   background-color: #${config.lib.stylix.colors.base08};
                   color: #${config.lib.stylix.colors.base00};
                 }
               }
               .warning, .critical, .urgent {
                 animation-name: blink_red;
                 animation-duration: 1s;
                 animation-timing-function: linear;
                 animation-iteration-count: infinite;
                 animation-direction: alternate;
               }
               window#waybar {
                 background-color: transparent;
               }
               window > box {
                 margin-left: 0px;
                 margin-right: 0px;
                 margin-top: 0px;
                 background-color: #${config.lib.stylix.colors.base00};
               }
         #workspaces {
                 padding-left: 0px;
                 padding-right: 4px;
               }
         #workspaces button {
                 padding-top: 5px;
                 padding-bottom: 5px;
                 padding-left: 6px;
                 padding-right: 6px;
                 color: #${config.lib.stylix.colors.base05};
               }
         #workspaces button.active {
                 background-color: #${config.lib.stylix.colors.base0D};
                 color: #${config.lib.stylix.colors.base01};
               }
         #workspaces button.urgent {
                 color: #${config.lib.stylix.colors.base09};
               }
         #workspaces button:hover {
                 background-color: #${config.lib.stylix.colors.base08};
                 color: #${config.lib.stylix.colors.base07};
 	}
        tooltip {
         background: #${config.lib.stylix.colors.base00};
        }
       tooltip label {
	 color: #${config.lib.stylix.colors.base07};
       }
	
         #custom-launcher {
                 font-size: 20px;
                 padding-left: 8px;
                 padding-right: 6px;
                 color: #7ebae4;
               }
         #mode, #clock, #memory, #temperature,#cpu,  #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu  {
                 padding-left: 10px;
                 padding-right: 10px;
               }
               
         #memory {
                 color: #${config.lib.stylix.colors.base0A};
               }
         #cpu {
                 color: #${config.lib.stylix.colors.base0B};
               }
         #clock {
                 color: #${config.lib.stylix.colors.base07};
               }
        /* #idle_inhibitor {
                 color: rgb(221, 182, 242);
               }*/
         #temperature {
                 color: #${config.lib.stylix.colors.base09};
               }
         #backlight {
                 color: #${config.lib.stylix.colors.base0E};
               }
         #pulseaudio {
                 color: #${config.lib.stylix.colors.base0F};
               }
         #network {
                 color: #${config.lib.stylix.colors.base0D};
               }

         #network.disconnected {
                 color: rgb(255, 255, 255);
               }
         #battery.charging, #battery.full, #battery.discharging {
                 color: rgb(250, 227, 176);
               }
         #battery.critical:not(.charging) {
                 color: rgb(242, 143, 173);
               }
         #custom-powermenu {
                 color: rgb(242, 143, 173);
               }
         #tray {
                 padding-right: 8px;
                 padding-left: 10px;
               }
         
      '';
      settings = [{
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          # "temperature"
          #"idle_inhibitor"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          # "memory"
          # "cpu"
          "network"
          "battery"
          "tray"
          "custom/powermenu"
        ];
        "custom/launcher" = {
          "format" = " ";
           "on-click" = "${pkgs.rofi}/bin/rofi -show drun -config /home/rodrigo/.config/rofi/config.rasi";
          "tooltip" = false;
        };
        
        
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          # "on-scroll-up" = "hyprctl dispatch workspace e+1";
          # "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-down" = "${pkgs.light}/bin/light -A 7";
          "on-scroll-up" = "${pkgs.light}/bin/light -U 7";
          "format" = "{icon} {percent}%";
          "format-icons" = [ "󰃝" "󰃞" "󰃟" "󰃠" ];
        };
        "pulseaudio" = {
          "scroll-step" = 1;
	  "reverse-scrolling" = true;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [ "" "" "" ];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%H:%M  %A %b %d}";
          "tooltip" = true;
          "tooltip-format"= "<tt>{calendar}</tt>";
          # "tooltip-format" = "<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰍛 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰻠 {usage}%";
        };
        
        "network" = {
          "format-disconnected" = "󰯡 Disconnected";
          "format-ethernet" = "󰀂 {ifname} ({ipaddr})";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-wifi" = "󰖩 {essid}";
          "interval" = 1;
          "tooltip" = false;
        };
        "temperature" = {
          # "hwmon-path"= "${env:HWMON_PATH}";
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "${pkgs.wlogout}/bin/wlogout --protocol layer-shell;";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }];
    };
    
}

{
  config,
  lib,
  pkgs,
  user,
  hostName,
  ...
}:
let
  controlCenterHiddenTabs =
    if hostName == "roderico" then
      [
        "power"
        "network"
        "screen-time"
      ]
    else
      [ ];

  controlCentershortcuts =
    if hostName == "roderico" then
      [
        { type = "wifi"; }
        { type = "bluetooth"; }
        { type = "notification"; }
        { type = "wallpaper"; }
        { type = "icefish/phone-connect:tile"; } # Sin el sufijo :tile
      ]
    else if hostName == "pcdrdg" then
      [
        { type = "wifi"; }
        { type = "bluetooth"; }
        { type = "notification"; }
        { type = "wallpaper"; }
        { type = "caffeine"; }
        { type = "power_profile"; }
      ]
    else
      [ ];

  enabledPlugins =
    if hostName == "roderico" then
      [
        "rylos/syncthing"
        "avivbintangaringga/nix-monitor"
        "icefish/phone-connect"
        "radimous/prismlauncher-instances"
      ]
    else if hostName == "pcdrdg" then
      [
        "lux/ideapad-conservation-mode"
        "avivbintangaringga/nix-monitor"
        "icefish/phone-connect"
        "rylos/syncthing"
      ]
    else
      [ ];
in
{

  home.packages = with pkgs; [
    sshfs
    glib
    zenity
  ];
  programs.noctalia = {
    enable = true;
    settings = {
      dock = {
        position = "bottom";
        auto_hide = true;
        reserve_space = false;
        layer = "top";
        enabled = true;
        background_opacity = 1.0;
      };

      shell = {
        launcher = {
          app_grid = true;
          show_app_actions = true;
        };
        polkit_agent = true;
        niri_overview_type_to_launch_enabled = true;
      };

      bar = {
        default = {
          position = "top";
          auto_hide = false;
          reserve_space = true;

          capsule_group = {
            enabled = true;
            accordion = true;
            accordion_direction = "end";
            fill = "surface_variant";
            id = "g1";
            members = [
              "bar_2"
              "bar"
              "tray"
            ];
            opacity = 1.0;
            padding = 6.0;
          };
          start = [
            "launcher"
            "workspaces"
            "clipboard"
          ];
          center = [
            "control-center"
            "clock"
            "nix-monitor"
          ];
          end = [
            "media"
            "group:g1"
            "notifications"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "privacy"
            "session"
          ];
        };
      };

      widget = {
        bar = {
          type = "rylos/syncthing:bar";
        };
        bar_2 = {
          type = "icefish/phone-connect:bar";
        };
        nix-monitor = {
          type = "avivbintangaringga/nix-monitor:nix-monitor";
        };
      };

      control_center = {
        hidden_tabs = controlCenterHiddenTabs;
        show_shortcut_labels = false;
        shortcuts = controlCentershortcuts;
      };

      location = {
        auto_locate = true;
      };

      wallpaper = {
        directory = "/home/rodrigo/Imágenes/Wallpapers/";
      };

      backdrop = {
        enabled = true;
        blur_intensity = 0.3;
        tint_intensity = 0.2;
      };

      plugins = {
        enabled = enabledPlugins;
        auto_update = "all"; # Necesario "all" para plugins comunitarios
        source = [
          {
            kind = "git";
            location = "https://github.com/noctalia-dev/official-plugins";
            name = "official";
          }
          {
            kind = "git";
            location = "https://github.com/noctalia-dev/community-plugins";
            name = "community";
          }
        ];
      };

      plugin_settings = {
        "avivbintangaringga/nix-monitor" = {
          update_command = "nix flake update --flake /home/rodrigo/home-flake/; home-manager switch --flake /home/rodrigo/home-flake; sudo nix flake update --flake /etc/nixos; sudo nixos-rebuild switch";
        };
      };
    };
  };
}

{
  pkgs,
  lib,
  config,
  hostName,
  inputs,
  ...
}:

let
  mkLuaInline = lib.generators.mkLuaInline;

  monitors =
    if hostName == "pcdrdg" then
      [
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "0x1080";
          scale = 1;
        }
        {
          output = "HDMI-A-1";
          mode = "1920x1080@144";
          position = "0x0";
          scale = 1;
        }
      ]
    else if hostName == "roderico" then
      [
        {
          output = "HDMI-A-1";
          mode = "1920x1080@144";
          position = "0x0";
          scale = 1;
        }
        {
          output = "HDMI-A-2";
          mode = "1366x768@59.79";
          position = "1920x600";
          scale = 1;
        }
      ]
    else
      [
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];
in
{
  home.packages = with pkgs; [
    playerctl
    hyprsysteminfo
    hyprpwcenter
    hyprshutdown
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    xwayland.enable = true;
    systemd.enable = false;
    extraLuaFiles = {
      "split-monitor-workspaces" = {
        autoLoad = true;
        content = ''
          package.path = package.path .. ";./?.lua;./?/init.lua"
          smw = require("plugins.split-monitor-workspaces")
          smw.setup({
            workspace_count = 10,
          })
          for i = 1, 10 do
              hl.dispatch(
                hl.dsp.workspace.rename({
                    workspace = i + 10,
                    name = tostring(i),
                })
              )
          end

          hl.config({
              debug = {
                  disable_logs = false,
              },
          })

          function toggleFullscreen()
              local win = hl.get_active_window()
              
              -- Si no hay ventana enfocada, no hace nada
              if not win or not win.size then return end
              
              -- Obtener el ancho del monitor activo
              local mon = hl.get_active_monitor()
              local mon_width = mon.size.width
              
              -- Si la ventana ya ocupa casi todo el ancho del monitor (>= 95%), la reduce al 50%.
              -- Si no, la expande al 100%.
              if win.size.x >= (mon_width * 0.95) then
                hl.dispatch(hl.dsp.layout("colresize 0.5"))
              else
                hl.dispatch(hl.dsp.layout("colresize 1"))
              end
            end

          hl.bind ("SUPER + F", toggleFullscreen)
        '';
      };
    };

    settings = {
      #
      # MONITORS
      #
      monitor = monitors;
      #
      # ENVIRONMENT
      #
      env = [
        {
          _args = [
            "XDG_CURRENT_DESKTOP"
            "Hyprland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_TYPE"
            "wayland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_DESKTOP"
            "Hyprland"
          ];
        }
      ];

      #
      # STARTUP
      #
      on = {
        _args = [
          "hyprland.start"

          (mkLuaInline ''
            function()
              hl.exec_cmd("libinput-gestures")
              hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
              hl.exec_cmd("sh -c 'until gdbus call --system --dest org.bluez --object-path / --method org.freedesktop.DBus.Introspectable.Introspect >/dev/null 2>&1; do sleep 0.2; done; exec noctalia --daemon'")
              hl.exec_cmd("localsend_app --hidden")
            end
          '')
        ];
      };

      #
      # CONFIG
      #
      config = {
        binds = {
          scroll_event_delay = 0;
        };
        device = [
          {
            name = "syna2ba6:00-06cb:ce2d-touchpad";
            sensitivity = -0.5; # Ajusta la sensibilidad solo al touchpad (-1.0 a 1.0)
          }
        ];
        input = {
          kb_layout = "es";
          numlock_by_default = true;
          follow_mouse = 1;

          touchpad = {
            tap_to_click = true;
            natural_scroll = true;
            scroll_factor = 1.0;
          };

          sensitivity = 0.6;
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;

          "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";

          "col.active_border" = "rgb(${config.lib.stylix.colors.base0D})";

          layout = "scrolling";
          allow_tearing = true;
        };
        scrolling = {
          column_width = 0.5;
          direction = "right";
          fullscreen_on_one_column = true;
        };
        gestures = {
          workspace_swipe_forever = true;
          workspace_swipe_create_new = true;
        };

        decoration = {
          rounding = 20;
          rounding_power = 2;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "0xee1a1a1a";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 2;
            vibrancy = 0.1696;
          };
        };

        misc = {
          disable_hyprland_logo = true;
          background_color = "rgb(${config.lib.stylix.colors.base00})";
          focus_on_activate = true;
        };
      };

      #
      # WINDOW RULES
      #
      window_rule = [
        {
          match.class = "dev.noctalia.Noctalia";
          float = true;
          size = [
            1080
            920
          ];
        }

        {
          match.class = "org.kde.dolphin";
          float = true;
        }

        {
          match.class = "kitty";
          opacity = "0.9 0.9";
        }

        {
          match.title = "nixos | Syncthing";
          float = true;
        }

        {
          match.title = "nmtui";
          float = true;
        }

        {
          match.title = "btop";
          float = true;
        }

        {
          match.title = "KDE Connect";
          float = true;
        }

        {
          match.title = "update-sys";
          float = true;
        }

        {
          match.title = "Select Document";
          float = true;
        }

        {
          match.title = "Picture-in-Picture";
          float = true;
        }

        {
          match.class = "thunderbird";
          no_screen_share = true;
        }

        {
          match.class = "steam_app_";
          immediate = true;
        }
      ];

      #
      # LAYER RULES
      #
      layer_rule = [
        {
          name = "noctalia";
          match.namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$";

          no_anim = true;
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];

      #
      # BINDS
      #
      gesture = [
        {
          fingers = 3;
          direction = "vertical";
          action = "workspace";
          scale = 0.6;
        }
        {
          fingers = 3;
          direction = "horizontal";
          action = "scroll_move";
          scale = 0.6;
        }
      ];
      animation = [
        {
          leaf = "workspaces";
          enabled = true;
          speed = 8;
          bezier = "default";
          style = "slidevert";
        }
      ];
      bind = [
        # Media
        {
          _args = [
            "XF86AudioPlay"
            (mkLuaInline ''hl.dsp.exec_cmd("playerctl play-pause")'')
            { locked = true; }
          ];
        }

        {
          _args = [
            "XF86AudioStop"
            (mkLuaInline ''hl.dsp.exec_cmd("playerctl stop")'')
            { locked = true; }
          ];
        }

        {
          _args = [
            "XF86AudioPrev"
            (mkLuaInline ''hl.dsp.exec_cmd("playerctl previous")'')
            { locked = true; }
          ];
        }

        {
          _args = [
            "XF86AudioNext"
            (mkLuaInline ''hl.dsp.exec_cmd("playerctl next")'')
            { locked = true; }
          ];
        }

        {
          _args = [
            "XF86AudioMute"
            (mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
          ];
        }

        {
          _args = [
            "XF86AudioLowerVolume"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg volume-down")'')
          ];
        }

        {
          _args = [
            "XF86AudioRaiseVolume"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg volume-up")'')
          ];
        }

        {
          _args = [
            "XF86AudioMicMute"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg volume-mute")'')
          ];
        }

        {
          _args = [
            "XF86Favorites"
            (mkLuaInline ''hl.dsp.exec_cmd("xdg-open https://www.google.com")'')
          ];
        }

        {
          _args = [
            "XF86MonBrightnessDown"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg brightness-down")'')
          ];
        }

        {
          _args = [
            "XF86MonBrightnessUp"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg brightness-up")'')
          ];
        }

        {
          _args = [
            "Print"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen")'')
          ];
        }

        {
          _args = [
            "SHIFT + Print"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg screenshot-region")'')
          ];
        }

        # Applications
        {
          _args = [
            "SUPER + SHIFT + R"
            (mkLuaInline ''hl.dsp.exec_cmd("pkill noctalia; sleep 2; noctalia")'')
          ];
        }

        {
          _args = [
            "SUPER + F10"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg session lock")'')
          ];
        }

        {
          _args = [
            "SUPER + Q"
            (mkLuaInline ''hl.dsp.exec_cmd("kitty")'')
          ];
        }

        {
          _args = [
            "ALT + F4"
            (mkLuaInline "hl.dsp.window.close()")
          ];
        }

        {
          _args = [
            "SUPER + E"
            (mkLuaInline ''hl.dsp.exec_cmd("nautilus")'')
          ];
        }

        {
          _args = [
            "SUPER + C"
            (mkLuaInline ''hl.dsp.exec_cmd("chromium")'')
          ];
        }

        {
          _args = [
            "SUPER + O"
            (mkLuaInline ''hl.dsp.exec_cmd("obsidian")'')
          ];
        }

        {
          _args = [
            "SUPER + SPACE"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle launcher")'')
          ];
        }

        {
          _args = [
            "ALT + V"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard")'')
          ];
        }

        {
          _args = [
            "SUPER + SHIFT + M"
            (mkLuaInline ''hl.dsp.exec_cmd("hyprshutdown --post-cmd 'shutdown'")'')
          ];
        }

        {
          _args = [
            "SUPER + M"
            (mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle session")'')
          ];
        }

        {
          _args = [
            "SUPER + V"
            (mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
          ];
        }

        # Focus
        {
          _args = [
            "SUPER + H"
            (mkLuaInline ''hl.dsp.focus({direction = "left"})'')
          ];
        }

        {
          _args = [
            "SUPER + L"
            (mkLuaInline ''hl.dsp.focus({direction = "right"})'')
          ];
        }

        {
          _args = [
            "SUPER + K"
            (mkLuaInline ''hl.dsp.focus({workspace = "m-1"})'')
          ];
        }

        {
          _args = [
            "SUPER + J"
            (mkLuaInline ''hl.dsp.focus({workspace = "m+1"})'')
          ];
        }

        # Move windows
        {
          _args = [
            "SUPER + SHIFT + H"
            (mkLuaInline ''hl.dsp.window.move({direction = "left"})'')
          ];
        }

        {
          _args = [
            "SUPER + SHIFT + L"
            (mkLuaInline ''hl.dsp.window.move({direction = "right"})'')
          ];
        }

        {
          _args = [
            "SUPER + SHIFT + K"
            (mkLuaInline ''hl.dsp.window.move({workspace = "m-1"})'')
          ];
        }

        {
          _args = [
            "SUPER + SHIFT + J"
            (mkLuaInline ''hl.dsp.window.move({workspace = "m+1"})'')
          ];
        }

      ]
      ++ builtins.concatLists (
        map (i: [
          {
            _args = [
              "SUPER + ${if i == 10 then "0" else toString i}"
              (mkLuaInline "smw.workspace(${toString i})")
            ];
          }

          {
            _args = [
              "SUPER + SHIFT + ${if i == 10 then "0" else toString i}"
              (mkLuaInline "smw.move_to_workspace_silent(${toString i})")
            ];
          }
        ]) (builtins.genList (i: i + 1) 10)
      )
      ++ [
        # Monitor focus
        {
          _args = [
            "SUPER + CTRL + H"
            (mkLuaInline ''hl.dsp.focus({monitor = "left"})'')
          ];
        }

        {
          _args = [
            "SUPER + CTRL + L"
            (mkLuaInline ''hl.dsp.focus({monitor = "right"})'')
          ];
        }

        {
          _args = [
            "SUPER + CTRL + K"
            (mkLuaInline ''hl.dsp.focus({monitor = "up"})'')
          ];
        }

        {
          _args = [
            "SUPER + CTRL + J"
            (mkLuaInline ''hl.dsp.focus({monitor = "down"})'')
          ];
        }

        # Move window to monitor
        {
          _args = [
            "SUPER + CTRL + SHIFT + H"
            (mkLuaInline ''hl.dsp.window.move({monitor = "left"})'')
          ];
        }

        {
          _args = [
            "SUPER + CTRL + SHIFT + L"
            (mkLuaInline ''hl.dsp.window.move({monitor = "right"})'')
          ];
        }

        {
          _args = [
            "SUPER + CTRL + SHIFT + K"
            (mkLuaInline ''hl.dsp.window.move({monitor = "up"})'')
          ];
        }

        {
          _args = [
            "SUPER + CTRL + SHIFT + J"
            (mkLuaInline ''hl.dsp.window.move({monitor = "down"})'')
          ];
        }

        # Move current workspace to monitor
        {
          _args = [
            "SUPER + ALT + H"
            (mkLuaInline ''hl.dsp.workspace.move({monitor = "left"})'')
          ];
        }

        {
          _args = [
            "SUPER + ALT + L"
            (mkLuaInline ''hl.dsp.workspace.move({monitor = "right"})'')
          ];
        }

        {
          _args = [
            "SUPER + ALT + K"
            (mkLuaInline ''hl.dsp.workspace.move({monitor = "up"})'')
          ];
        }

        {
          _args = [
            "SUPER + ALT + J"
            (mkLuaInline ''hl.dsp.workspace.move({monitor = "down"})'')
          ];
        }

        # Mouse
        {
          _args = [
            "SUPER + mouse:272"
            (mkLuaInline "hl.dsp.window.drag()")
            {
              mouse = true;
            }
          ];
        }

        {
          _args = [
            "SUPER + mouse:273"
            (mkLuaInline "hl.dsp.window.resize()")
            {
              mouse = true;
            }
          ];
        }
        {
          _args = [
            "SUPER + mouse_down"
            (mkLuaInline ''hl.dsp.focus({ workspace = "m-1" })'')
          ];
        }
        {
          _args = [
            "SUPER + mouse_up"
            (mkLuaInline ''hl.dsp.focus({ workspace = "m+1" })'')
          ];
        }
      ];
    };
  };
  home.file.".config/hypr/plugins/split-monitor-workspaces".source = inputs.split-monitor-workspaces;
}

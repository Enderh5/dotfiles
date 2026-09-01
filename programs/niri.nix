{
  pkgs,
  config,
  hostName,
  ...
}:
let
  outputConfig =
    if hostName == "pcdrdg" then
      ''
        output "eDP-1" {
            mode "1920x1080@60.000"
            scale 1.0
            position x=0 y=1080
            variable-refresh-rate on-demand=true
            focus-at-startup
            backdrop-color "${config.lib.stylix.colors.base00}"

            hot-corners {
                bottom-left
            }
        }
        output "HDMI-A-1" {
            mode "1920x1080@144"
            scale 1.0
            position x=0 y=0
            variable-refresh-rate on-demand=true
            backdrop-color "${config.lib.stylix.colors.base00}"

            hot-corners {
                bottom-left
            }
        }
      ''
    else if hostName == "roderico" then
      ''
        output "HDMI-A-1" {
            // off
            mode "1920x1080@144"
            scale 1.0
            position x=0 y=0
            variable-refresh-rate on-demand=true
            backdrop-color "${config.lib.stylix.colors.base00}"

            hot-corners {
                bottom-left
            }
        }

        output "HDMI-A-2" {
            // off
            mode "1366x769@59.790"
            scale 1.0
            position x=1920 y=600
            variable-refresh-rate on-demand=true
            backdrop-color "${config.lib.stylix.colors.base00}"

            hot-corners {
                bottom-left
            }
        }
      ''
    else
      "";
in
{
  home.packages = with pkgs; [
    fuzzel
    xwayland-satellite
    udiskie
    slurp
    grim
  ];

  home.file.".config/wallpaper.jpg".source = ../images/wallpaper.jpg;

  home.file.".config/niri/config.kdl".text = ''
    // Programas que se lanzan una sola vez al iniciar Niri
    spawn-at-startup  "syncthing"
    spawn-at-startup  "libinput-gestures"
    spawn-at-startup  "waybar"
    // spawn-at-startup  "zapzap"
    spawn-at-startup  "localsend_app --hidden"
    spawn-at-startup  "noctalia"
    spawn-at-startup "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" "XDG_SESSION_TYPE"

    // Programa que corre en background continuamente (similar a exec)
    spawn-at-startup  "wl-paste --watch cliphist store"
    prefer-no-csd
    input {
      warp-mouse-to-focus mode="center-xy"
      focus-follows-mouse
      keyboard {
          xkb {
              layout "es"
          }
          numlock
      }
      touchpad {
        tap
        natural-scroll
        scroll-method "two-finger" 
        accel-profile "flat"
      }
      mouse{
        accel-speed 0.6
        accel-profile "flat"
      }
    }

    ${outputConfig}

    binds {

      // MEDIA
      XF86AudioPlay { spawn-sh "playerctl play-pause"; }
      XF86AudioStop { spawn-sh "playerctl stop"; }
      XF86AudioPrev { spawn-sh "playerctl previous"; }
      XF86AudioNext { spawn-sh "playerctl next"; }

      Mod+Shift+apostrophe {show-hotkey-overlay;}
      Mod+Shift+R {spawn-sh "killall noctalia; noctalia";}

      Mod+F { maximize-column;}
      Mod+Shift+F { fullscreen-window;}
      Mod+Alt+F { toggle-windowed-fullscreen;}
      Mod+W { toggle-column-tabbed-display; }

      Mod+F10 { spawn-sh "noctalia msg session lock"; }


      // VOLUMEN
      XF86AudioMute { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
      XF86AudioLowerVolume { spawn-sh "noctalia msg volume-down"; }
      XF86AudioRaiseVolume { spawn-sh "noctalia msg volume-up"; }

      // MICRO
      XF86AudioMicMute { spawn-sh "noctalia msg volume-mute"; }
      XF86Favorites { spawn-sh "xdg-open https://www.google.com"; }

      // BRILLO
      XF86MonBrightnessDown { spawn-sh "noctalia msg brightness-down"; }
      XF86MonBrightnessUp { spawn-sh "noctalia msg brightness-up"; }

      Print { spawn "noctalia" "msg" "screenshot-fullscreen"; }

      // Capturar una región seleccionada usando Noctalia
      Shift+Print { spawn "noctalia" "msg" "screenshot-region"; }

      // APLICACIONES
      Mod+Q { spawn "kitty"; }
      Alt+F4 { close-window; }
      Mod+E { spawn "nautilus"; }
      Mod+C { spawn "chromium"; }
      Mod+O { spawn "obsidian"; }

      // LAUNCHERS
      Mod+Space { spawn-sh "noctalia msg panel-toggle launcher"; }
      Alt+V { spawn-sh "noctalia msg panel-toggle clipboard"; }

      // SALIR
      Mod+Shift+M { quit; }
      Mod+M {spawn-sh "noctalia msg panel-toggle session";}

      // NAVEGACIÓN ENTRE COLUMNAS
      Mod+H { focus-column-left; }
      Mod+L { focus-column-right; }
      Mod+J { focus-workspace-down; }
      Mod+K { focus-workspace-up; }


      // MOVER VENTANAS ENTRE COLUMNAS
      Mod+Shift+H { move-column-left; }
      Mod+Shift+L { move-column-right; }
      Mod+Shift+K { move-window-to-workspace-up; }
      Mod+Shift+J { move-window-to-workspace-down; }

      // WORKSPACES
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }
      Mod+0 { focus-workspace 10; }

      Mod+Shift+1 { move-window-to-workspace 1; }
      Mod+Shift+2 { move-window-to-workspace 2; }
      Mod+Shift+3 { move-window-to-workspace 3; }
      Mod+Shift+4 { move-window-to-workspace 4; }
      Mod+Shift+5 { move-window-to-workspace 5; }
      Mod+Shift+6 { move-window-to-workspace 6; }
      Mod+Shift+7 { move-window-to-workspace 7; }
      Mod+Shift+8 { move-window-to-workspace 8; }
      Mod+Shift+9 { move-window-to-workspace 9; }
      Mod+Shift+0 { move-window-to-workspace 10; }

      // Toggle floating
      Mod+V { toggle-window-floating; }

      // CAMBIAR FOCO ENTRE MONITORES
      Mod+Ctrl+H { focus-monitor-left; }
      Mod+Ctrl+L { focus-monitor-right; }
      Mod+Ctrl+K { focus-monitor-up; }
      Mod+Ctrl+J { focus-monitor-down; }
      //Mod+MouseLeft  { mouse-move-window; }   // mover ventana flotante
      //Mod+MouseRight { mouse-resize-window; } // redimensionar ventana flotante

      Mod+Ctrl+Shift+H { move-window-to-monitor-left; }
      Mod+Ctrl+Shift+L { move-window-to-monitor-right; }
      Mod+Ctrl+Shift+K { move-window-to-monitor-up; }
      Mod+Ctrl+Shift+J { move-window-to-monitor-down; }

      // MOVER WORKSPACE A OTRO MONITOR
      Mod+Alt+H { move-workspace-to-monitor-left; }
      Mod+Alt+L { move-workspace-to-monitor-right; }
      Mod+Alt+K { move-workspace-to-monitor-up; }
      Mod+Alt+J { move-workspace-to-monitor-down; }
    }

    layout {
      // Gaps
      gaps 9
      always-center-single-column
      empty-workspace-above-first
      default-column-display "tabbed"  // se parece al master stack de Hyprland
      background-color "#${config.lib.stylix.colors.base00}"

      // Columnas
      preset-column-widths {
          proportion 0.33333
          proportion 0.5
          proportion 0.66667
      }
      default-column-width { proportion 0.5; }

      // Altura de las ventanas (solo para stacked/tabbed)
      preset-window-heights {
          proportion 0.33333
          proportion 0.5
          proportion 0.66667
      }

      // Focus ring (similar a animaciones de foco de Hyprland)
      focus-ring {
          on
          width 2
          inactive-color "#${config.lib.stylix.colors.base02}"
          active-color "#${config.lib.stylix.colors.base0D}"
          urgent-color "#${config.lib.stylix.colors.base08}"
      }

      // Bordes (equivalente a border_size + col.active/inactive_border)
      border {
          on
          width 1
          inactive-color "#${config.lib.stylix.colors.base01}"
          active-color "#${config.lib.stylix.colors.base0D}"
          urgent-color "#${config.lib.stylix.colors.base08}"
      }

      // Sombra (equivalente a Hyprland blur + shadow)
      shadow {
          on
          softness 30
          spread 5
          offset x=0 y=5
          draw-behind-window true
          color "#00000070"
      }

      // Tab indicator (equivalente a dwindle/master stack visual)
      tab-indicator {
          on
          hide-when-single-tab
          place-within-column
          gap 5
          width 4
          length total-proportion=1.0
          position "right"
          gaps-between-tabs 2
          corner-radius 8
          active-color "#${config.lib.stylix.colors.base0D}"
          inactive-color "#${config.lib.stylix.colors.base03}"
          urgent-color "#${config.lib.stylix.colors.base08}"
      }

      // Insert hint (indica dónde se va a abrir la ventana)
      insert-hint {
          on
          color "#${config.lib.stylix.colors.base0E}"
      }

      // Struts (espacios reservados para paneles)
      struts {
          // ejemplo: izquierda/derecha/top/bottom
          // left 64
          // top 64
      }

    }

    window-rule {
      geometry-corner-radius 20
      clip-to-geometry true
      open-maximized false
    }

    window-rule {
      match app-id="dev.noctalia.Noctalia"
      open-floating true
      default-column-width { fixed 1080; }
      default-window-height { fixed 920; }
    }

    //Ventanas flotantes de configuracion/utilidad
    window-rule {
      match app-id="org.kde.dolphin"

      open-floating true
      open-maximized false
    }

    // Opacidad para kitty
    window-rule {
      match app-id="kitty"
      opacity 0.9
      draw-border-with-background false
    }

    window-rule{
      match app-id=".blueman-manager-wrapped"
      match app-id="org.pulseaudio.pavucontrol"

      match title="nixos | Syncthing"
      match title="nmtui"

      default-column-width { proportion 0.5; }
      default-window-height { proportion 0.5; }

      open-floating true
      open-maximized false
      opacity 1.0
    }

    // Flotantes por título
    window-rule {
      match title="btop"
      match title="KDE Connect"
      match title="update-sys"
      match title="Select Document"

      open-floating true
    }

    //PiP
    window-rule {
      match title="Picture-in-Picture"

      open-floating true
    }

    window-rule{
      match app-id="thunderbird"
      //block-out-from "screencast"
      block-out-from "screen-capture"
    }



    // Animaciones para Chromium
    window-rule {
      match app-id="chromium-browser"
    }

    animations {
      // Desactivar todas (opcional)
      // off

      // Reducir velocidad general (opcional)
      // slowdown "2.0"

      // Animación al cambiar de workspace (spring)
      workspace-switch {
          spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
      }

      // Animación de apertura de ventana (easing)
      window-open {
          duration-ms 150
          curve "ease-out-expo"
      }

      // Animación de cierre de ventana (easing)
      window-close {
          duration-ms 150
          curve "ease-out-quad"
      }

      // Movimiento horizontal de la vista (spring)
      horizontal-view-movement {
          spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }

      // Movimiento de ventanas dentro de la vista (spring)
      window-movement {
          spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }

      // Animación de redimensionamiento (spring)
      window-resize {
          spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }

      // Animación de notificaciones de configuración (spring)
      config-notification-open-close {
          spring damping-ratio=0.6 stiffness=1000 epsilon=0.001
      }

      // Animación UI de captura de pantalla (easing)
      screenshot-ui-open {
          duration-ms 200
          curve "ease-out-quad"
      }

      // Animación de overview (spring)
      overview-open-close {
          spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
      }
    }

    layer-rule {
      match namespace="^noctalia-backdrop"
      place-within-backdrop true
    }

    layer-rule {
      match namespace="^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
      background-effect {
        xray false
        // blur false
      }
    }

    layer-rule {
      match namespace="noctalia-window-switcher"
      background-effect {
          blur true
          xray false
      }
    }

    debug {
      //preview-render "screen-capture"
      honor-xdg-activation-with-invalid-serial
    }
  '';

}

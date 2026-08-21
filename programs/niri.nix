{ pkgs, config, ... }:
let
  colors = config.lib.stylix.colors;
  fonts = config.stylix.fonts;

  colorText = "#${colors.base05}";
  colorTextAlt = "#${colors.base04}";
  colorBg = "#${colors.base00}";
  colorBgAlt = "#${colors.base01}";
  colorBgHover = "#${colors.base03}";
  colorSelection = "#${colors.base02}";
  colorWarning = "#${colors.base0A}";
  colorUrgent = "#${colors.base09}";
  colorError = "#${colors.base08}";
  colorTextDarkBg = "#${colors.base00}";
  colorHotter = "#${colors.base08}";
  colorHot = "#${colors.base09}";
  colorMild = "#${colors.base0A}";
  colorCold = "#${colors.base0D}";
  colorColder = "#${colors.base0C}";
  colorDisbledButton = "#${colors.base04}";
  colorConfirm = "#${colors.base0B}";
  colorDeny = "#${colors.base0F}";
in
{
  home.packages = with pkgs; [
    fuzzel
    mako
    hyprpaper
    hyprlock
    xwayland-satellite
    udiskie
    slurp
    grim
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    wallpaper {
        monitor = 
        path = ${config.home.homeDirectory}/.config/hypr/wallpaper.jpg
        fit_mode = cover
    }
  '';

  home.file.".config/hypr/wallpaper.jpg".source = ../images/wallpaper.jpg;

  home.file.".config/niri/config.kdl".text = ''
    // Programas que se lanzan una sola vez al iniciar Niri
    spawn-at-startup  "syncthingtray --wait"
    spawn-at-startup  "hyprpaper"
    spawn-at-startup  "syncthing"
    spawn-at-startup  "libinput-gestures"
    spawn-at-startup  "waybar"
    // spawn-at-startup  "zapzap"
    spawn-at-startup  "localsend_app --hidden"
    // spawn-at-startup  "kdeconnect-indicator"

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
    }

    output "eDP-1" {
        // off
        mode "1920x1080@120.030"
        scale 1.0
        position x=0 y=1080
        variable-refresh-rate on-demand=true
        focus-at-startup
        backdrop-color "${colorBg}"

        hot-corners {
            // off
            top-left
            // top-right
            // bottom-left
            // bottom-right
        }

        layout {
            // ...layout settings for eDP-1...
        }

    }

    output "HDMI-A-1" {
        // off
        mode "1920x1080@144"
        scale 1.0
        position x=0 y=0
        variable-refresh-rate on-demand=true
        backdrop-color "#001100"

        hot-corners {
            bottom-left
        }
    }


    binds {

      // MEDIA
      XF86AudioPlay { spawn-sh "playerctl play-pause"; }
      XF86AudioStop { spawn-sh "playerctl stop"; }
      XF86AudioPrev { spawn-sh "playerctl previous"; }
      XF86AudioNext { spawn-sh "playerctl next"; }

      Mod+Shift+apostrophe {show-hotkey-overlay;}

      Mod+F { maximize-column;}
      Mod+Shift+F { fullscreen-window;}
      Mod+Alt+F { toggle-windowed-fullscreen;}
      Mod+W { toggle-column-tabbed-display; }

      Mod+F10 { spawn-sh "hyprlock"; }


      // VOLUMEN
      XF86AudioMute { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
      XF86AudioLowerVolume { spawn-sh "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"; }
      XF86AudioRaiseVolume { spawn-sh "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"; }

      // MICRO
      XF86AudioMicMute { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
      XF86Favorites { spawn-sh "xdg-open https://www.google.com"; }

      // BRILLO
      XF86MonBrightnessDown { spawn-sh "brightnessctl set 5%-"; }
      XF86MonBrightnessUp { spawn-sh "brightnessctl set 5%+"; }

      // SCREENSHOT
      Print {spawn-sh "slurp | grim -g - - | wl-copy";}

      // APLICACIONES
      Mod+Q { spawn "kitty"; }
      Alt+F4 { close-window; }
      Mod+E { spawn "nautilus"; }
      Mod+C { spawn "chromium"; }
      Mod+O { spawn "obsidian"; }

      // LAUNCHERS
      Mod+Space { spawn "~/.config/rofi/launcher.sh"; }
      Alt+V { spawn-sh "cliphist list | rofi -dmenu | cliphist decode | wl-copy"; }

      // SALIR
      Mod+Shift+M { quit; }
      Mod+M {spawn "wlogout";}

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
      background-color "#003301"

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
          inactive-color "${config.lib.stylix.colors.base07}"
          active-color "${config.lib.stylix.colors.base09}"
          urgent-color "${config.lib.stylix.colors.base08}"
      }

      // Bordes (equivalente a border_size + col.active/inactive_border)
      border {
          on
          width 1
          inactive-color "${config.lib.stylix.colors.base07}"
          active-color "${config.lib.stylix.colors.base09}"
          urgent-color "${config.lib.stylix.colors.base08}"
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
          active-color "red"
          inactive-color "gray"
          urgent-color "blue"
      }

      // Insert hint (indica dónde se va a abrir la ventana)
      insert-hint {
          on
          color "${config.lib.stylix.colors.base0D}"
      }

      // Struts (espacios reservados para paneles)
      struts {
          // ejemplo: izquierda/derecha/top/bottom
          // left 64
          // top 64
      }

    }

    window-rule {
      geometry-corner-radius 12
      clip-to-geometry true
      open-maximized false
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

      match title="Syncthing Tray"
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

    debug {
      //preview-render "screen-capture"
    }
  '';

  services.mako.enable = true;

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "sh -lc 'hyprshutdown || niri msg action quit'";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Sleep";
        keybind = "u";
      }
      {
        label = "shutdown";
        action = "sh -lc 'hyprshutdown --post-cmd \"shutdown -P 0\" || systemctl poweroff'";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "soft-reboot";
        action = "systemctl soft-reboot";
        text = "Soft-Reboot";
        keybind = "q";
      }
      {
        label = "reboot";
        action = "sh -lc 'hyprshutdown -t \"Restarting...\" --post-cmd \"reboot\" || systemctl reboot'";
        text = "Reboot";
        keybind = "r";
      }

    ];
    style = ''
      * {
          background-image: none;
          transition: background-color 250ms cubic-bezier(0.4, 0, 0.2, 1),
                      color 250ms cubic-bezier(0.4, 0, 0.2, 1),
                      border-color 250ms cubic-bezier(0.4, 0, 0.2, 1);
      }

      /* THE WINDOW: Translucent background */
      window {
          background-color: rgba(0, 0, 0, 0.4); /* Dark translucent overlay */
      }

      /* THE BUTTONS: Base State (Translucent) */
      button {
          color: rgba(255, 255, 255, 1); /* Matugen variable */
          background-color: rgba(255, 255, 255, 0.15); /* Slight glass effect */
          border: 1px solid rgba(255, 255, 255, 0.2);
          border-radius: 20px;
          margin: 15px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          outline-style: none;
      }

      /* THE HOVER: "Surprise Me" Matugen Effect */
      /* Uses your Matugen primary or tertiary color for high contrast */

      button:hover {
          background-color: ${colorBg}; /* Vibrant theme color */
          color: rgba(255, 255, 255, 1);
          border: 2px solid ${colorUrgent}; /* Bold border on hover */
          background-size: 30%; /* Icon grows slightly for "surprise" feedback */
          box-shadow: 0 0 20px 2px ${colorUrgent}; /* Neon-like glow effect */
          margin: 14px;
      }

      /* FOCUS/ACTIVE: Same as hover for consistency */
      button:active, button:focus {
          border: 1px solid ${colorUrgent};
      }

      /* 3. ICON MAPPING (Absolute paths) */
      #lock {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/Lock-white.png");
      }

      #logout {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/Logout-white.png");
      }

      #suspend {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/Sleep-white.png");
      }

      #soft-reboot {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/Soft-reboot-white.png");
      }

      #shutdown {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/Shutdown-white.png");
      }

      #reboot {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/Reboot-white.png");
      }
    '';
  };

  home.file.".config/wlogout/icons/Lock-white.png".source = ./wlogout/Lock-white.png;
  home.file.".config/wlogout/icons/Logout-white.png".source = ./wlogout/Logout-white.png;
  home.file.".config/wlogout/icons/Reboot-white.png".source = ./wlogout/Reboot-white.png;
  home.file.".config/wlogout/icons/Shutdown-white.png".source = ./wlogout/Shutdown-white.png;
  home.file.".config/wlogout/icons/Sleep-white.png".source = ./wlogout/Sleep-white.png;
  home.file.".config/wlogout/icons/Soft-reboot-white.png".source = ./wlogout/Soft-reboot-white.png;

}

{
  config,
  pkgs,
  ...
}:
let
  mainMod = "SUPER";
in
{

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    swappy
    grim
    slurp
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    xdg-utils
    libnotify
    cliphist
    sshfs
    playerctl
    brightnessctl
  ];

  home.file.".config/hypr/hyprlock.conf".text = ''
    # BACKGROUND
    background {
        monitor =
        path = ~/.config/hypr/wallpaper.jpg
        #blur_passes = 0
        #contrast = 0.8916
        #brightness = 0.8172
        #vibrancy = 0.1696
        #vibrancy_darkness = 0.0
    }

    # GENERAL
    general {
        no_fade_in = false
        grace = 0
        disable_loading_bar = false
    }

    # GREETINGS
    label {
        monitor =
        text =¡Bienvenido!
        color = rgba(205, 214, 224, .75)
        font_size = 55
        font_family = JetBrainsMono Nerd Font
        position = 165, 320
        halign = left
        valign = center
    }

    # Time
    label {
        monitor =
        text = cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"
        color = rgba(205, 214, 224, .75)
        font_size = 40
        font_family = JetBrainsMono Nerd Font
        position = 255, 240
        halign = left
        valign = center
    }

    # Day-Month-Date
    label {
        monitor =
        text = Sunday, September 29
        color = rgba(205, 214, 224, .75)
        font_size = 20
        text_align = left
        font_family = JetBrainsMono Nerd Font
        position = 180, 175
        halign = left
        valign = center
    }



    # USER-BOX
    shape {
        monitor =
        size = 320, 55
        color = rgba(255, 255, 255, .6)
        rounding = -1
        border_size = 0
        border_color = rgba(255, 255, 255, 1)
        rotate = 0
        xray = false # if true, make a "hole" in the background (rectangle of specified size, no rotation)

        position = 170, -140
        halign = left
        valign = center
    }

    # USER
    label {
        monitor =
        text =  $USER
        color = rgba(${config.lib.stylix.colors.base00}ff)
        outline_thickness = 0
        dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        font_size = 16
        font_family = JetBrainsMono Nerd Font
        position = 281, -140
        halign = left
        valign = center
    }

    # INPUT FIELD
    input-field {
        monitor =
        size = 320, 55
        outline_thickness = 0
        dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        outer_color = rgba(255, 255, 255, 0)
        inner_color = rgba(255, 255, 255, 0.1)
        font_color = rgb(205, 214, 244)
        fade_on_empty = false
        font_family = JetBrainsMono Nerd Font
        placeholder_text = <i><span foreground="##ffffff99">🔒 Contraseña</span></i>
        hide_input = false
        position = 170, -220
        halign = left
        valign = center
    }
  '';

  home.file.".config/hypr/hyprland.conf".text = ''
    # exec-once = hyprpanel 
    exec-once = syncthingtray --wait
    exec-once = hyprpaper
    exec-once = syncthing 
    # exec-once = systemctl --user enable opentabletdriver.service --now
    exec-once = libinput-gestures
    #exec-once = zapzap
    exec-once = localsend_app --hidden
    # exec-once = kdeconnect-indicator
    exec = wl-paste --watch cliphist store


    input {
        kb_layout = es
        follow_mouse = 1
        touchpad  {
            natural_scroll = yes
            disable_while_typing = no 
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flatwayland
        kb_options=caps:swapescape
    }

    general  {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.inactive_border = rgba(${config.lib.stylix.colors.base07}ff)
        col.active_border = rgba(${config.lib.stylix.colors.base09}ff)
        layout = dwindle
    }

    misc  {
        disable_hyprland_logo = no
    }

     decoration  {
         # See https://wiki.hyprland.org/Configuring/Variables/ for more

         rounding = 5

         blur  {
             enabled = true
             size = 7
             passes = 4
             new_optimizations = true
         }

     }

    animations  {
        enabled = true

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = myBezier, 0.10, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier, slide
        animation = windowsOut, 1, 7, myBezier, slide
        animation = border, 1, 10, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
        animation = specialWorkspace, 1, 6, myBezier, slidevert
    }

    dwindle  {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }


    gesture = 3, horizontal, workspace

    # Float Dolphin by class
    windowrule = match:class ^(org.kde.dolphin)$, float 1

    # Float specific titles
    windowrule = match:title ^(btop)$, float 1
    windowrule = match:title ^(KDE Connect)$, float 1
    windowrule = match:title ^(update-sys)$, float 1

    # Partial effects by class
    windowrule = match:class ^(kitty)$, opacity 0.75
    windowrule = match:class ^(org.kde.dolphin)$, animation popin
    windowrule = match:class ^(chromium-browser)$, animation popin

    #Teclas especiales
    bind = SUPER, L, exec, hyprlock
    bind = CTRL ALT, TAB, exec, togglespecialworkspace
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioStop, exec, playerctl stop
    bindl = , XF86AudioPrev, exec, playerctl previous
    bindl = , XF86AudioNext, exec, playerctl next

    # Volumen (usa wpctl si estás en PipeWire/WirePlumber)
    bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    binde = , XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
    binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+

    binde = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    binde = , XF86MonBrightnessUp, exec, brightnessctl set 5%+

    # Mic mute
    bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

    bind = , XF86Cut, exec, slurp | grim -g - - | wl-copy

    bind = ${mainMod}, Q, exec, kitty
    bind = ALT, F4, killactive,
    bind = ${mainMod}, M, exec, wlogout
    bind = ${mainMod} SHIFT, M, exit,
    bind = ${mainMod}, E, exec, dolphin
    bind = ${mainMod}, V, togglefloating,
    bind = ${mainMod}, C, exec, chromium
    bind = ${mainMod}, O, exec, obsidian
    bind = ${mainMod}, F, fullscreen,
    bind = ${mainMod}, S, exec, slurp | grim -g - - | wl-copy
    bind = ${mainMod}, T, exec, ~/.config/hypr/latexocr.sh
    bind = ALT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
    bind = ${mainMod}, Space, exec, ~/.config/rofi/launcher.sh

    bind = ${mainMod}, left, movefocus, l
    bind = ${mainMod}, right, movefocus, r
    bind = ${mainMod}, up, movefocus, u
    bind = ${mainMod}, down, movefocus, d

    bind = ${mainMod} Shift, left, movewindow, l
    bind = ${mainMod} Shift, right, movewindow, r
    bind = ${mainMod} Shift, up, movewindow, u
    bind = ${mainMod} Shift, down, movewindow, d

    bind = ${mainMod}, H, movefocus, l
    bind = ${mainMod}, L, movefocus, r
    bind = ${mainMod}, K, movefocus, u
    bind = ${mainMod}, J, movefocus, d

    bind = ${mainMod} Shift, H, movewindow, l
    bind = ${mainMod} Shift, L, movewindow, r
    bind = ${mainMod} Shift, K, movewindow, u
    bind = ${mainMod} Shift, J, movewindow, d


    bind = ${mainMod}, 1, workspace, 1
    bind = ${mainMod}, 2, workspace, 2
    bind = ${mainMod}, 3, workspace, 3
    bind = ${mainMod}, 4, workspace, 4
    bind = ${mainMod}, 5, workspace, 5
    bind = ${mainMod}, 6, workspace, 6
    bind = ${mainMod}, 7, workspace, 7
    bind = ${mainMod}, 8, workspace, 8
    bind = ${mainMod}, 9, workspace, 9
    bind = ${mainMod}, 0, workspace, 10

    bind = ${mainMod} SHIFT, 1, movetoworkspace, 1
    bind = ${mainMod} SHIFT, 2, movetoworkspace, 2
    bind = ${mainMod} SHIFT, 3, movetoworkspace, 3
    bind = ${mainMod} SHIFT, 4, movetoworkspace, 4
    bind = ${mainMod} SHIFT, 5, movetoworkspace, 5
    bind = ${mainMod} SHIFT, 6, movetoworkspace, 6
    bind = ${mainMod} SHIFT, 7, movetoworkspace, 7
    bind = ${mainMod} SHIFT, 8, movetoworkspace, 8
    bind = ${mainMod} SHIFT, 9, movetoworkspace, 9
    bind = ${mainMod} SHIFT, 0, movetoworkspace, 10

    bind = ${mainMod} Ctrl, H, resizeactive, -10 0
    bind = ${mainMod} Ctrl, L, resizeactive, 10 0
    bind = ${mainMod} Ctrl, K, resizeactive, 0 -10
    bind = ${mainMod} Ctrl, H, resizeactive, 0 10

    bindm = ${mainMod}, mouse:272, movewindow
    bindm = ${mainMod}, mouse:273, resizewindow

    monitor = eDP-1, preferred, 0x0, 1 
    monitor = HDMI-A-1, preferred, -554x-1080, 1
    monitor = DP-1,848x480@60, 1366x-473, 1
    monitor = virtual-1,1920x1080@60,1920x0,1
  '';

  home.file.".config/hypr/latexocr.sh" = {
    text = ''
      #!/usr/bin/env bash
      out=$(slurp | grim -g - - > /tmp/texocr.png)

      notify-send "Comienzo escaneo LaTeX" 
      wl-copy "$out"
      notify-send "Escaneo LaTeX finalizado"
    '';
    executable = true;
  };

}

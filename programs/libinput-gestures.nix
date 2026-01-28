{ ... }:
{
  home.file.".config/libinput-gestures.conf".text = ''
    gesture swipe up 3 hyprctl dispatch togglespecialworkspace 
    gesture swipe up 4 hyprctl dispatch movetoworkspace special 
  '';
}

{
  ...
}:
{
  fonts.fontconfig.enable = true;
  stylix.targets.kitty.enable = true;
  programs.kitty = {
    enable = false;
    shellIntegration.enableZshIntegration = true;
  };

  # xdg.enable = true;
  # xdg.desktopEntries.kitty = {
  #   name = "Kitty";
  #   genericName = "Terminal emulator";
  #   comment = "Fast, GPU-based terminal emulator";
  #   exec = "kitty --directory %f";
  #   terminal = false;
  #   icon = "kitty";
  #   categories = [
  #     "System"
  #     "TerminalEmulator"
  #   ];
  #   mimeType = [ "application/x-terminal" ];
  # };

  home.file.".local/share/applications/kitty.desktop".text = ''
    [Desktop Entry]
    Name=Kitty
    GenericName=Terminal emulator
    Comment=Fast, GPU-based terminal emulator
    Exec=kitty --directory %f
    Icon=kitty
    Terminal=false
    Type=Application
    Categories=System;TerminalEmulator;
    MimeType=application/x-terminal;
  '';

}

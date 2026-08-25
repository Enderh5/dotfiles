{
  ...
}:
{
  fonts.fontconfig.enable = true;
  stylix.targets.kitty.enable = true;
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      enable_audio_bell = false;
    };
  };

  xdg.desktopEntries.kitty = {
    name = "Kitty";
    genericName = "Terminal emulator";
    comment = "Fast, GPU-based terminal emulator";
    # Eliminamos el %f conflictivo para que abra siempre bien en Plasma
    exec = "kitty";
    icon = "kitty";
    terminal = false;
    categories = [
      "System"
      "TerminalEmulator"
    ];
    mimeType = [ "application/x-terminal" ];
  };

}

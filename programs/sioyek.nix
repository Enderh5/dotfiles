{
  pkgs,
  lib,
  home,
  config,
  ...
}:
{
  programs.sioyek = {
    enable = true;
    config = {
      "new-instance" = "1";
      "should_launch_new_window" = "1";
      "should_launch_new_instance" = "1";
    };
    bindings = {
      "goto_mark" = "ç";
    };
  };
}

{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  programs.noctalia = {
    enable = true;
    settings = {
    };
  };
}

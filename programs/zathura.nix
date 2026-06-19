{
  pkgs,
  lib,
  home,
  config,
  ...
}:
{
  programs.zathura = {
    enable = false;
    options = {
      adjust-open = "best-fit";
      pages-per-row = 1;

      scroll-page-aware = "true";
      smooth-scroll = "true";
      scroll-full-overlap = 0.01;
      scroll-step = 100;
      zoom-min = 10;
      recolor-reverse-video = "true";
      recolor-keephue = "true";
      render-loading = "false";
      statusbar-home-tilde = "true";
    };
    mappings = {
      "f" = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
    };
  };
}

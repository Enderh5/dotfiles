{
  config,
  pkgs,
  lib,
  ...
}:
{
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    icons = {
      enable = true;
      light = "dracula";
      dark = "dracula";
      package = pkgs.dracula-icon-theme;
    };

    # Imagen de fondo
    image = ./images/wallpaper.jpg;

    # Esquema de colores
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    # Fuentes
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
    };

    # Cursor
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    # Targets (aplicaciones/entornos)
    targets = {
      gtk.enable = true;
      mako = {
        enable = true;
        colors = {
          override = {
            border-color = lib.mkForce "aaa";
          };
        };
      };
      # kde.enable = true;
      # hyprland.enable = false;
    };
  };
  fonts.fontconfig.defaultFonts.monospace = [ "JetBrainsMono" ];

  gtk = {
    iconTheme.package = lib.mkForce pkgs.gruvbox-plus-icons;
    iconTheme.name = lib.mkForce "Gruvbox-Plus-Dark";
  };

}

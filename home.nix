{
  pkgs,
  lib,
  stylix,
  ...
}:
{

  home = {
    username = "rodrigo";
    homeDirectory = "/home/rodrigo";

    stateVersion = "25.11";

    packages = [
      # pkgs.xterm
      #Uni
      pkgs.obsidian
      pkgs.postman
      pkgs.geogebra6
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.texliveFull

      #SO
      pkgs.adwaita-icon-theme
      pkgs.tmux
      pkgs.tmuxinator
      pkgs.cargo
      pkgs.ripgrep
      pkgs.gtk4
      pkgs.libinput-gestures
      pkgs.wmctrl
      #Miscelanea
      pkgs.zapzap
      pkgs.thunderbird
      pkgs.vlc

      #Nvim
      pkgs.git
      pkgs.gcc
      pkgs.unzip
      pkgs.fzf
      pkgs.cbfmt
      pkgs.tree-sitter
      pkgs.marksman
      pkgs.lua-language-server
      pkgs.stylua

      pkgs.chromium

      pkgs.xfce.exo
      pkgs.gvfs
      pkgs.udisks2

      pkgs.nix-direnv
      pkgs.kdePackages.qtmultimedia

      pkgs.libreoffice-fresh

      pkgs.zotero

      pkgs.sioyek

      #Stremio
    ];

    sessionVariables = {
      GTK_USE_PORTAL = "1";
      EDITOR = "nvim";
      XDG_MENU_PREFIX = lib.mkForce "plasma-";
      XDG_DATA_DIRS = ''
        $XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/rodrigo/.local/share/flatpak/exports/share
      '';
    };

  };

  imports = [
    # ./programs/waybar.nix
    ./stylix.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/starship.nix
    ./programs/rofi.nix
    ./programs/tmux.nix
    ./programs/libinput-gestures.nix
    ./programs/hyprpanel.nix
    ./programs/yazi.nix
    ./programs/zathura.nix
    ./programs/kitty.nix
    ./programs/nvim.nix
    ./programs/nautilus.nix
    ./programs/firefox.nix
    ./programs/webapps.nix
  ];

  systemd = {
    user.services.udiskie = {
      serviceConfig = {
      };
    };
    user.services.attic-watch-store = {
      Unit = {
        Description = "Udiskie automount";
        After = [ "graphical-session.target" ];
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie --tray --automount --notify";
      };
    };
  };

  xdg = {
    enable = true;
    desktopEntries = { };
    mimeApps = {
      enable = true;
      associations.added = {
        "application/x-terminal" = [ "kitty.desktop" ];
        "application/zip" = [ "org.kde.ark.desktop" ];
        "application/x-zip-compressed" = [ "org.kde.ark.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/kdeconnect" = [ "kdeconnect-handler.desktop" ];
      };
      defaultApplications = {
        "application/x-terminal" = [ "kitty.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/zip" = [ "org.kde.ark.desktop" ];
        "application/x-zip-compressed" = [ "org.kde.ark.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/kdeconnect" = [ "kdeconnect-handler.desktop" ];
      };
    };
  };
}

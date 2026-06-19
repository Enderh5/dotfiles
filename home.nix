{
  pkgs,
  lib,
  stylix,
  config,
  ...
}:
let
  HOME = "/home/rodrigo";
in
{

  home = {
    username = "rodrigo";
    homeDirectory = HOME;

    stateVersion = "25.11";

    packages = with pkgs; [
      ghostty
      localsend
      #Uni
      obsidian
      postman
      geogebra6
      nerd-fonts.jetbrains-mono
      texliveFull

      #SO
      adwaita-icon-theme
      tmux
      tmuxinator
      cargo
      ripgrep
      gtk4
      libinput-gestures
      wmctrl
      #Miscelanea
      zapzap
      thunderbird
      vlc

      #Nvim
      git
      gcc
      unzip
      fzf
      cbfmt
      tree-sitter
      marksman
      lua-language-server
      stylua

      chromium

      xfce4-exo
      gvfs
      udisks2

      nix-direnv
      kdePackages.qtmultimedia

      libreoffice-fresh

      zotero

      fastfetch
      (import ./pkgs/mossel { inherit pkgs; })
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
    ./programs/waybar.nix
    ./stylix.nix
    ./programs/sioyek.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/niri.nix
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

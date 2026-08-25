{
  pkgs,
  lib,
  stylix,
  config,
  inputs,
  ...
}:
let
  HOME = "/home/rodrigo";
  # Wrapper que detecta si viene una URI o si es un inicio normal
  prismlauncher-wrapper = pkgs.writeShellScriptBin "prismlauncher-wrapper" ''
    if [ -z "$1" ]; then
      exec ${pkgs.prismlauncher}/bin/prismlauncher
    else
      exec ${pkgs.prismlauncher}/bin/prismlauncher --import "$@"
    fi
  '';
in
{

  home = {
    username = "rodrigo";
    homeDirectory = HOME;

    stateVersion = "26.05";

    packages = with pkgs; [
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

      fastfetch

      prismlauncher
      temurin-bin-21
    ];

    sessionVariables = {
      GTK_USE_PORTAL = "1";
      EDITOR = "nvim";
      XDG_DATA_DIRS = ''
        $XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/rodrigo/.local/share/flatpak/exports/share
      '';
    };

  };

  imports = [
    #./programs/waybar.nix
    ./stylix.nix
    ./programs/sioyek.nix
    ./programs/zsh.nix
    #./programs/hyprland.nix
    ./programs/niri.nix
    ./programs/starship.nix
    ./programs/rofi.nix
    ./programs/tmux.nix
    ./programs/libinput-gestures.nix
    ./programs/yazi.nix
    ./programs/zathura.nix
    ./programs/kitty.nix
    ./programs/nvim.nix
    ./programs/webapps.nix
    ./programs/noctalia.nix
  ];

  systemd = {
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
    desktopEntries = {
      "org.prismlauncher.PrismLauncher" = {
        name = "Prism Launcher";
        # Se llama al wrapper pasando el parámetro %u (que puede ir vacío o llevar la URI)
        exec = "${prismlauncher-wrapper}/bin/prismlauncher-wrapper %u";
        icon = "org.prismlauncher.PrismLauncher";
        mimeType = [
          "x-scheme-handler/prismlauncher"
          "x-scheme-handler/curseforge"
          "application/x-modrinth-modpack+zip"
          "application/zip"
        ];
        terminal = false;
        type = "Application";
        settings = {
          StartupWMClass = "PrismLauncher";
        };
      };
    };
    mimeApps = {
      enable = true;
      associations.added = {
        "application/x-terminal" = [ "kitty.desktop" ];
        "application/zip" = [ "org.kde.ark.desktop" ];
        "application/x-zip-compressed" = [ "org.kde.ark.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/kdeconnect" = [ "kdeconnect-handler.desktop" ];
        "x-scheme-handler/prismlauncher" = [
          "org.prismlauncher.PrismLauncher.desktop"
        ];
      };
      defaultApplications = {
        "application/x-terminal" = [ "kitty.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/zip" = [ "org.kde.ark.desktop" ];
        "application/x-zip-compressed" = [ "org.kde.ark.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/kdeconnect" = [ "kdeconnect-handler.desktop" ];
        "x-scheme-handler/prismlauncher" = [
          "org.prismlauncher.PrismLauncher.desktop"
        ];
      };
    };

  };

}

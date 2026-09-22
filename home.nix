{
  pkgs,
  hostName,
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
      xournalpp
      rnote

      bitwarden-desktop
      weylus
      discord
      concord-tui
      libGL
      mesa

      localsend

      #Uni
      postman
      geogebra6
      nerd-fonts.jetbrains-mono

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
      udisks2

      nix-direnv
      kdePackages.qtmultimedia

      libreoffice-stable

      fastfetch

      prismlauncher
      temurin-bin-17

      nemo
    ];

    sessionVariables = {
      GTK_USE_PORTAL = "1";
      EDITOR = "nvim";
      XDG_DATA_DIRS = ''
        $XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/rodrigo/.local/share/flatpak/exports/share
      '';
      HOSTNAME = hostName;
    };

  };

  imports = [
    ./stylix.nix
    ./programs/thunar.nix
    ./programs/sioyek.nix
    ./programs/zsh.nix
    ./programs/obsidian.nix
    ./programs/niri.nix
    ./programs/hyprland.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/yazi.nix
    ./programs/keyring.nix
    ./programs/kitty.nix
    ./programs/nvim.nix
    ./programs/webapps.nix
    ./programs/noctalia.nix
  ];

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

  programs.git = {
    enable = true;
    settings = {
      # Define la regla del driver para que Git sepa qué script ejecutar
      "merge \"flake-lock\"" = {
        name = "Elegir flake.lock más reciente";
        driver = "./scripts/merge-flake-lock.sh %A %B";
      };
    };
  };

}

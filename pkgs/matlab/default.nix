{ pkgs }:

let
  # Definimos el ejecutable y el prefijo
  wine = pkgs.wineWow64Packages.wayland;
  winePrefix = "$HOME/.wine-xpress-final";
  executablePath = "${winePrefix}/drive_c/xpressmp/bin/IVE.exe";

  iconFile = ./icon.png;
  # Creamos el script lanzador
  launcher = pkgs.writeShellScriptBin "xpress-ive" ''
    export WINEPREFIX="${winePrefix}"
    export WINEDEBUG="-all"

    # Comprobamos si el ejecutable existe para dar un error amigable
    if [ ! -f "${executablePath}" ]; then
      echo "Error: No se encuentra IVE.exe en ${executablePath}"
      exit 1
    fi

    exec ${wine}/bin/wine "${executablePath}" "$@" >/dev/null 2>&1
  '';

  # Creamos el archivo .desktop
  desktopItem = pkgs.makeDesktopItem {
    name = "fico-xpress-ive";
    desktopName = "FICO Xpress IVE";
    comment = "Editor y Optimizador para Programación Matemática";
    exec = "${launcher}/bin/xpress-ive";
    icon = "${iconFile}"; # Puedes cambiarlo por una ruta a un .png si quieres
    categories = [
      "Development"
      "Science"
      "Education"
    ];
    keywords = [
      "matlab"
      "matematicas"
      "universidad"
    ];
    terminal = false;
    startupNotify = true;
  };
in
# Combinamos el script y el .desktop en un solo paquete
pkgs.symlinkJoin {
  name = "fico-xpress-ive-package";
  paths = [
    launcher
    desktopItem
  ];
}

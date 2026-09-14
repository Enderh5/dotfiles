{
  lib,
  stdenv,
  cmake,
  pkg-config,
  binutils,
  qt6,
  wayland,
  wayland-scanner,
  libxkbcommon,
  libei,
  src,
}:

stdenv.mkDerivation {
  pname = "hypr-kdeconnect-fix";
  version = "unstable";

  inherit src;

  nativeBuildInputs = [
    cmake
    pkg-config
    binutils
    wayland-scanner
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    wayland
    libxkbcommon
    libei
  ];

  cmakeFlags = [
    (lib.cmakeFeature "HKCF_PORTAL_USE_IN" "Hyprland")
  ];

  meta = {
    description = "KDE Connect RemoteDesktop portal backend for Hyprland";
    homepage = "https://github.com/gfhdhytghd/hypr-kdeconnect-fix";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "hypr-kdeconnect-portal";
  };
}

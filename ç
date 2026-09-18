{
  config,
  pkgs,
  lib,
  ...
}:

let
  weylusSlopDir = "${config.home.homeDirectory}/.local/src/weylus-community-slop";
  weylusSlopBin = "${config.home.homeDirectory}/.local/bin/weylus-slop";

  buildWeylusSlop = pkgs.writeShellScript "build-weylus-slop" ''
    set -euo pipefail

    src="${weylusSlopDir}"

    if [ ! -d "$src/.git" ]; then
      mkdir -p "$(dirname "$src")"
      ${pkgs.git}/bin/git clone \
        https://github.com/electronstudio/WeylusCommunityEdition.git \
        "$src"
    fi

    cd "$src"

    ${pkgs.git}/bin/git fetch --tags origin
    ${pkgs.git}/bin/git checkout --force a1007af

    export PATH="${
      lib.makeBinPath [
        pkgs.cargo
        pkgs.rustc
        pkgs.nodejs
        pkgs.typescript
        pkgs.pkg-config
        pkgs.nasm
        pkgs.autoconf
        pkgs.libtool
        pkgs.gnumake
        pkgs.gcc
        pkgs.bash
        pkgs.git
      ]
    }:$PATH"

    export PKG_CONFIG_PATH="${
      pkgs.lib.makeSearchPath "lib/pkgconfig" [
        pkgs.libdrm
        pkgs.libx11
        pkgs.libxext
        pkgs.libxfixes
        pkgs.libxinerama
        pkgs.libxrender
        pkgs.libxcursor
        pkgs.libxrandr
        pkgs.libxcomposite
        pkgs.libxi
        pkgs.libxtst
        pkgs.libxv
        pkgs.pango
        pkgs.gst_all_1.gstreamer
        pkgs.gst_all_1.gst-plugins-base
        pkgs.dbus
        pkgs.wayland
        pkgs.libxkbcommon
      ]
    }:$PKG_CONFIG_PATH"

    # The slop release builds its own FFmpeg/libva with VA-API support.
    # Keep the upstream build path rather than replacing it with Nix's
    # system FFmpeg.
    cargo build --release --features va-static

    mkdir -p "$(dirname "${weylusSlopBin}")"
    install -Dm755 target/release/weylus "${weylusSlopBin}"
  '';
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "weylus-slop-build" ''
      exec ${buildWeylusSlop}
    '')

    (pkgs.writeShellScriptBin "weylus-slop" ''
      export WEYLUS_VAAPI_DEVICE=/dev/dri/renderD128
      export LIBVA_DRIVER_NAME=iHD
      export LIBVA_DRIVERS_PATH=/run/opengl-driver/lib/dri

      exec ${weylusSlopBin} "$@"
    '')
  ];

  home.activation.buildWeylusSlop = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "${weylusSlopBin}" ]; then
      ${buildWeylusSlop}
    fi
  '';
}

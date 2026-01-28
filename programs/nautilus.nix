{ pkgs, ... }:
let
  kdeOpenWrapper = pkgs.writeShellScriptBin "kde-open5" ''
    #!/bin/bash
    xdg-open "$1"
  '';
in
{
  home.packages = with pkgs; [
    nautilus
    unzip
    zip
  ];

  
}

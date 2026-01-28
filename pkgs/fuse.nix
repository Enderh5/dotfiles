{ pkgs, lib }:
pkgs.buildNpmPackage rec {
  pname = "fuse.js";
  version = "7.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "krisk";
    repo = "Fuse";
    rev = "v${version}";
    sha256 = "sha256-I+fB1+CMa7ULOVMF4nIXjaSm1gJ8IQupvk0Ec3zx5uM="; # paso 1: hash falso
  };

  npmDepsHash = "sha256-1f47Dw8lJ3JQ7j88Fyxx2hQ75oBBbGM3sdUFM9pguhI="; # paso 2: hash falso

  meta = with lib; {
    description = "Lightweight fuzzy-search library";
    homepage = "https://fusejs.io";
    platforms = platforms.all;
  };
}

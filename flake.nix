{
  description = "home-manager config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      stylix,
      home-manager,
      ...
    }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ ];
      };
    in
    {

      homeConfigurations = {
        "rodrigo@roderico" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            inputs.noctalia.homeModules.default
            stylix.homeModules.stylix
            ./home.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
            hostName = "roderico";
          };
        };
        "rodrigo@pcdrdg" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            inputs.noctalia.homeModules.default
            stylix.homeModules.stylix
            ./home.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
            hostName = "pcdrdg";
          };
        };
      };
    };

}

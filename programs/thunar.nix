{
  pkgs,
  programs,
  stylix,
  ...
}:
{
  home.packages = with pkgs; [
    (pkgs.thunar.override {
      thunarPlugins = with pkgs; [
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    })
    xarchiver # Necesario para que thunar-archive-plugin pueda descomprimir
  ];

}

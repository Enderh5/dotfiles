{ pkgs, config, ... }:
let
  colors = config.lib.stylix.colors;
  colorBg = "#${colors.base08}ff";
in
{

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 10;

    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set-option -g focus-events on

      if-shell '[ "$TERM" = "xterm-kitty" ]' "set-option -sa terminal-features ',xterm-kitty'" ""
      if-shell '[ "$TERM" = "xterm-256color" ]' "set-option -sa terminal-features ',xterm-256color'" ""


      set -g status-position top
      set -gq allow-passthrough on
      set -g visual-activity off

      set -g status-style "bg=#${config.lib.stylix.colors.base01},fg=#${config.lib.stylix.colors.base05}"
      set -g window-status-style "bg=#${config.lib.stylix.colors.base01},fg=#${config.lib.stylix.colors.base05}"

      # Opcional: Darle estilo al elemento activo dentro de la barra
      set -g window-status-current-style "bg=#${config.lib.stylix.colors.base00},fg=#${config.lib.stylix.colors.base05},bold"
    '';
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      #pkg.tmuxPlugins.power-theme
    ];
  };

}

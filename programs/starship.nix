{ config, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = ''[](#${config.lib.stylix.colors.base0F})$os$username[](bg:#${config.lib.stylix.colors.base0A} fg:#${config.lib.stylix.colors.base0F})$directory[](fg:#${config.lib.stylix.colors.base0A} bg:#${config.lib.stylix.colors.base0C})$git_branch$git_status[](fg:#${config.lib.stylix.colors.base0C} bg:#${config.lib.stylix.colors.base0D})$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:#${config.lib.stylix.colors.base0D} bg:#${config.lib.stylix.colors.base03})$docker_context[](fg:#${config.lib.stylix.colors.base03} bg:#${config.lib.stylix.colors.base01})$time[ ](fg:#${config.lib.stylix.colors.base01})$line_break$character'';

      os = {
        disabled = false;
        style = "bg:#${config.lib.stylix.colors.base0F} fg:#${config.lib.stylix.colors.base07}";
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CentOS = "󱄅";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          NixOS = "󱄅";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:#${config.lib.stylix.colors.base0F} fg:#${config.lib.stylix.colors.base07}";
        style_root = "bg:#${config.lib.stylix.colors.base0F} fg:#${config.lib.stylix.colors.base07}";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0A}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0C}";
        format = "[[ $symbol $branch ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0C})]($style)";
      };
      git_status = {
        style = "bg:#${config.lib.stylix.colors.base0C}";
        format = "[[($all_status$ahead_behind )](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0C})]($style)";
      };
      nodejs = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      c = {
        symbol = " ";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      php = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      java = {
        symbol = " ";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      kotlin = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      haskell = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      python = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base0D}";
        format = "[[ $symbol( $version) ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base0D})]($style)";
      };
      docker_context = {
        symbol = "";
        style = "bg:#${config.lib.stylix.colors.base03}";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:#${config.lib.stylix.colors.base03})]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#${config.lib.stylix.colors.base01}";
        format = "[[  $time ](fg:#${config.lib.stylix.colors.base07} bg:#${config.lib.stylix.colors.base01})]($style)";
      };
      line_break = {
        disabled = false;
      };
      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:#${config.lib.stylix.colors.base0A})";
      };
    };
  };

}

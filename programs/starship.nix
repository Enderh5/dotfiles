{ ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      # En los formatos inline de Starship se usa 'baseXX' o 'fg:baseXX', NUNCA '$baseXX' ni '#${...}'
      format = "[](base0F)$os$username[](bg:base0A fg:base0F)$directory[](fg:base0A bg:base0C)$git_branch$git_status[](fg:base0C bg:base0D)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:base0D bg:base03)$docker_context[](fg:base03 bg:base01)$time[ ](fg:base01)$line_break$character";

      os = {
        disabled = false;
        style = "bg:base0F fg:base07";
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
        style_user = "bg:base0F fg:base07";
        style_root = "bg:base0F fg:base07";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:base07 bg:base0A";
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
        style = "bg:base0C";
        format = "[[ $symbol $branch ](fg:base07 bg:base0C)]($style)";
      };

      git_status = {
        style = "bg:base0C";
        format = "[[($all_status$ahead_behind )](fg:base07 bg:base0C)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:base0D";
        format = "[[ $symbol( $version) ](fg:base07 bg:base0D)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:base03";
        format = "[[ $symbol( $context) ](fg:base0C bg:base03)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:base01";
        format = "[[  $time ](fg:base07 bg:base01)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[](bold fg:base0B)";
        error_symbol = "[](bold fg:base08)";
        vimcmd_symbol = "[](bold fg:base0B)";
        vimcmd_replace_one_symbol = "[](bold fg:base0E)";
        vimcmd_replace_symbol = "[](bold fg:base0E)";
        vimcmd_visual_symbol = "[](bold fg:base0A)";
      };
    };
  };
}

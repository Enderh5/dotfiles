{
  config,
  pkgs,
  lib,
  stylix,
  ...
}:

let
  colors = config.lib.stylix.colors;
  fonts = config.stylix.fonts;

  colorText = "#${colors.base05}";
  colorTextAlt = "#${colors.base04}";
  colorBg = "#${colors.base00}";
  colorBgAlt = "#${colors.base01}";
  colorBgHover = "#${colors.base03}";
  colorSelection = "#${colors.base02}";
  colorWarning = "#${colors.base0A}";
  colorUrgent = "#${colors.base09}";
  colorError = "#${colors.base08}";
  colorTextDarkBg = "#${colors.base00}";
  colorHotter = "#${colors.base08}";
  colorHot = "#${colors.base09}";
  colorMild = "#${colors.base0A}";
  colorCold = "#${colors.base0D}";
  colorColder = "#${colors.base0C}";
  colorDisbledButton = "#${colors.base04}";
  colorConfirm = "#${colors.base0B}";
  colorDeny = "#${colors.base0F}";
in
{
  stylix.targets.hyprpanel.enable = false;
  programs.hyprpanel = {
    enable = true;

    settings = {
      "bar" = {
        "autoHide" = "never";
        "battery" = {
          "hideLabelWhenFull" = true;
          "scrollDown" = "brightnessctl set 5%+";
          "scrollUp" = "brightnessctl set 5%-";
        };
        "notifications.show_total" = true;

        "clock" = {
          "format" = "%H:%M:%S";
          "icon" = "󰥔";
        };

        "customModules" = {
          "cpu.pollingInterval" = 1100;
          "ram.labelType" = "percentage";
        };
        "launcher.icon" = "󰊠";
        "layouts" = {
          "0" = {
            left = [
              "dashboard"
              "windowtitle"
              "systray"
            ];
            middle = [ "workspaces" ];
            right = [
              "volume"
              "network"
              "battery"
              "bluetooth"
              "clock"
              "notifications"
            ];
          };
          "1" = {
            left = [
              "dashboard"
              "workspaces"
              "windowtitle"
            ];
            middle = [ "media" ];
            right = [
              "volume"
              "clock"
              "notifications"
            ];
          };
          "2" = {
            left = [
              "dashboard"
              "workspaces"
              "windowtitle"
            ];
            middle = [ "media" ];
            right = [
              "volume"
              "clock"
              "notifications"
            ];
          };
        };

        "media" = {
          "format" = "{title}";
          "truncation_size" = 23;
        };
        "network.showWifiInfo" = true;
        "scrollSpeed" = 2;
        "windowtitle" = {
          "icon" = true;
          "title_map" = [
            [
              "armcord"
              ""
              "Armcord"
            ]
            [
              "org.pwmt.zathura"
              ""
              "Zathura"
            ]
            [
              "gjs"
              ""
              "Hyprpanel Settings"
            ]
            [
              "com.stremio.stremio"
              "󰈰"
              "Stremio"
            ]
            [
              "zen"
              "󰰶"
              "Zen Browser"
            ]
            [
              "org.qbittorrent.qBittorrent"
              "μ"
              "qBitTorrent"
            ]
            [
              "org.wireshark.Wireshark"
              "󱫋"
              "Wireshark"
            ]
            [
              "com.mitchellh.ghostty"
              "󰊠"
              "Ghostty"
            ]
            [
              "jetbrains-idea-ce"
              ""
              "IntelliJ Idea"
            ]
            [
              "YouTube Music Desktop App"
              ""
              "YT Music"
            ]
            [
              "com.github.th_ch.youtube_music"
              "󰗃"
              "YT Music"
            ]
            [
              "org.kde.kdeconnect.app"
              ""
              "KDE Connect"
            ]
            [
              "chrome-drive.google.com__drive_folders_11cukvhjwrdi6kr5nvtinfdrrsxffpjdr-default"
              "☭"
              "Comuna"
            ]
            [
              "chrome-drive.google.com__-default"
              ""
              "Google Drive"
            ]
            [
              "zapzap"
              ""
              "Whatsapp"
            ]
            [
              "chrome-campusvirtual.uva.es__my_-default"
              ""
              "Campus Virtual"
            ]
            [
              "chrome-matlab.mathworks.com__-default"
              ""
              "Matlab"
            ]
            [
              "chrome-www.mathcha.io__editor-default"
              "󰍘"
              "Mathcha"
            ]
            [
              "chrome-github.com__-default"
              ""
              "Github"
            ]
          ];
          "truncation" = true;
          "truncation_size" = 20;
        };

        "workspaces" = {
          "applicationIconOncePerWorkspace" = true;
          "hideUnoccupied" = true;
          "ignored" = "-99";
          "monitorSpecific" = true;
          "numbered_active_indicator" = "underline";
          "scroll_speed" = 2;
          "showAllActive" = true;
          "showApplicationIcons" = false;
          "showWsIcons" = true;
          "show_icons" = false;
          "spacing" = 1.2;
          "workspaceIconMap" = {
            "1" = {
              color = "#fab387";
              icon = "";
            };
            "10" = {
              color = "#a6adc8";
              icon = "";
            };
            "2" = {
              color = "#f9e2af";
              icon = "󰄛";
            };
            "3" = {
              color = "#cba6f7";
              icon = "";
            };
            "4" = {
              color = "#f38ba8";
              icon = "";
            };
            "5" = {
              color = "yellow";
              icon = "";
            };
            "6" = {
              color = "#94e2d5";
              icon = "󰉋";
            };
            "7" = {
              color = "#a6e3a1";
              icon = "";
            };
            "8" = {
              color = "lightgreen";
              icon = "󰓇";
            };
            "9" = {
              color = "#89b4fa";
              icon = "󰙯";
            };
          };
          "workspaces" = 2;
        };
      };

      "menus" = {
        "clock" = {
          "time" = {
            "hideSeconds" = false;
            "military" = true;
          };
          "weather" = {
            "key" = "";
            "location" = "Lalitpur";
            "unit" = "metric";
          };
        };
        "dashboard" = {
          "directories" = {
            "left" = {
              "directory1.label" = "󰉍   Downloads";
              "directory2.label" = "󰉏   Videos";
              "directory3.label" = "󰚝   Projects";
            };
            "right" = {
              "directory1.label" = "󱧶   Documents";
              "directory2.label" = "󰉏   Pictures";
              "directory3.label" = "󱂵   Home";
            };
          };
          "powermenu.avatar.image" = "/home/greed/.face";
        };

        "media" = {
          "displayTimeTooltip" = true;
          "hideAlbum" = false;
          "hideAuthor" = false;
          "noMediaText" = "No Media Currently Playing";
        };
        "transition" = "crossfade";
        "volume" = {
          "raiseMaximumVolume" = false;
          "scrollDown" = "hyprpanel vol -5";
          "scrollUp" = "hyprpanel vol +5";
        };
      };

      "notifications" = {
        "background" = colorBg;
        "displayedTotal" = 10;
        "position" = "top";
      };
      scalingPriority = "gdk";

      "theme" = {
        "bar" = {
          "background" = colorBg;
          "border" = {
            "color" = colorBg;
            "location" = "none";
          };

          "border_radius" = "0em";
          "borderColor" = colorUrgent;
          "borderSize" = "0.08em";

          "enableBorders" = true;
          "hover" = colorBgAlt;
          "icon" = colorText;
          "icon_background" = "#242438";

          "padding_x" = ".98rem";
          "radius" = "0.8em";
          "spacing" = "0.25em";
          "style" = "default";
          "text" = colorText;
          "floating" = true;

          "buttons" = {
            "background" = colorBg;

            "battery" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "bluetooth" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "clock" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "dashboard" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "media" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "modules" = {
              "cava" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "cpu" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "cpuTemp.enableBorder" = true;

              "hypridle" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "hyprsunset" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "kbLayout" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "netstat" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "power" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "ram" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "storage" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "submap" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };

              "weather" = {
                "borderSize" = "5px";
                "enableBorder" = true;
                "background" = colorBg;
                "border_radius" = "0em";
                "border" = colorUrgent;
                "icon" = colorText;
                "icon_background" = colorBg;
                "text" = colorText;
              };
            };

            "network" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "notifications" = {
              "total" = colorText;
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
              "notification_count" = colorText;
            };

            "systray" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "volume" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "windowtitle" = {
              "borderSize" = "5px";
              "enableBorder" = true;
              "background" = colorBg;
              "border_radius" = "0em";
              "border" = colorUrgent;
              "icon" = colorText;
              "icon_background" = colorBg;
              "text" = colorText;
            };

            "workspaces" = {
              "active" = colorUrgent;
              "available" = colorText;
              "background" = colorBg;
              "border" = colorUrgent;
              "enableBorder" = true;
              "fontSize" = "1em";
              "hover" = colorTextAlt;
              "numbered_active_highlight_border" = "0.55em";
              "numbered_active_highlight_padding" = "0.8em";
              "numbered_active_highlighted_text_color" = "#181825";
              "numbered_active_underline_color" = "#f5c2e7";
              "occupied" = "#f2cdcd";
              "pill" = {
                "active_width" = "12em";
                "height" = "4em";
                "radius" = "1.9rem * 0.6";
                "width" = "4em";
              };
              "smartHighlight" = true;
            };
          };

          "menus" = {
            "background" = colorBg;
            "border.color" = colorUrgent;

            "buttons" = {
              "active" = "#f5c2e6";
              "default" = "#b4befe";
              "disabled" = "#585b71";
              "text" = colorText;
            };

            "cards" = "#1e1e2e";

            "check_radio_button" = {
              "active" = "#b4beff";
              "background" = "#45475a";
            };

            "dimtext" = "#585b70";

            "dropdownmenu" = {
              "background" = "#11111b";
              "divider" = "#1e1e2e";
              "text" = colorText;
            };

            "feinttext" = "#313244";

            "iconbuttons" = {
              "active" = "#b4beff";
              "passive" = "#cdd6f3";
            };

            "icons" = {
              "active" = "#b4befe";
              "passive" = "#585b70";
            };

            "label" = colorText;

            "listitems" = {
              "active" = "#b4befd";
              "passive" = "#cdd6f4";
            };

            "menu" = {
              "battery" = {
                "scaling" = 93;
                "background.color" = colorBg;
                "border.color" = colorUrgent;
                "card.color" = colorBgAlt;
                "icons" = {
                  "active" = colorUrgent;
                  "passive" = colorBg;
                };
                "label.color" = colorText;
                "listitems.active" = "#f9e2af";
                "listitems.passive" = "#cdd6f3";

                "slider" = {
                  "background" = colorBg;
                  "backgroundhover" = colorBgHover;
                  "primary" = colorUrgent;
                  "puck" = colorUrgent;
                };
                "text" = colorText;
              };

              "bluetooth" = {
                "scaling" = 98;
                "background.color" = colorBg;
                "border.color" = colorUrgent;
                "card.color" = colorBgAlt;
                "iconbutton" = {
                  "active" = colorUrgent;
                  "passive" = colorText;
                };

                "icons" = {
                  "active" = colorUrgent;
                  "passive" = colorText;
                };

                "label.color" = colorText;

                "listitems" = {
                  "active" = colorUrgent;
                  "passive" = colorText;
                };
                "scroller.color" = colorSelection;
                "status" = colorTextAlt;

                "switch" = {
                  "disabled" = colorBg;
                  "enabled" = colorUrgent;
                  "puck" = colorBgAlt;
                };
                "switch_divider" = colorBgAlt;

                "text" = colorText;
              };

              "clock" = {
                "background.color" = colorBg;
                "border.color" = colorUrgent;
                "calendar" = {
                  "contextdays" = colorText;
                  "currentday" = colorUrgent;
                  "days" = colorTextAlt;
                  "paginator" = colorUrgent;
                  "weekdays" = colorUrgent;
                  "yearmonth" = colorUrgent;
                };

                "card.color" = colorBgAlt;
                "scaling" = 93;
                "text" = colorText;

                "time" = {
                  "time" = colorText;
                  "timeperiod" = colorTextAlt;
                };

                "weather" = {
                  "hourly" = {
                    "icon" = colorText;
                    "temperature" = colorText;
                    "time" = colorTextAlt;
                  };
                  "icon" = colorText;
                  "stats" = colorText;
                  "status" = colorText;
                  "temperature" = colorText;

                  "thermometer" = {
                    "cold" = colorCold;
                    "extremelycold" = colorColder;
                    "extremelyhot" = colorHotter;
                    "hot" = colorHot;
                    "moderate" = colorMild;
                  };
                };
              };

              "dashboard" = {
                "scaling" = 93;
                "background.color" = colorBg;
                "border.color" = colorUrgent;
                "card.color" = colorBgAlt;
                "profile.name" = colorText;

                "controls" = {
                  "disabled" = colorDisbledButton;

                  "bluetooth" = {
                    "background" = colorColder;
                    "text" = colorBg;
                  };

                  "input" = {
                    "background" = colorMild;
                    "text" = colorBg;
                  };

                  "notifications" = {
                    "scaling" = 93;
                    "height" = "50em";
                    "label" = colorTextDarkBg;
                    "menu.clock.scaling" = 93;
                    "background" = colorHot;
                    "text" = colorBg;
                  };

                  "volume" = {
                    "background" = colorHotter;
                    "text" = colorBg;
                  };

                  "wifi" = {
                    "wifi.background" = colorColder;
                    "wifi.text" = colorBg;
                  };
                };

                "directories" = {
                  "left.bottom.color" = colorText;
                  "left.middle.color" = colorText;
                  "left.top.color" = colorText;
                  "right.bottom.color" = colorText;
                  "right.middle.color" = colorText;
                  "right.top.color" = colorText;
                };

                "monitors" = {
                  "bar_background" = colorBg;

                  "cpu" = {
                    "bar" = colorHot;
                    "icon" = colorHot;
                    "label" = colorHot;
                  };

                  "disk" = {
                    "bar" = colorCold;
                    "icon" = colorCold;
                    "label" = colorCold;
                  };

                  "gpu" = {
                    "bar" = colorColder;
                    "icon" = colorColder;
                    "label" = colorColder;
                  };

                  "ram" = {
                    "bar" = colorMild;
                    "icon" = colorMild;
                    "label" = colorMild;
                  };
                };

                "powermenu" = {
                  "confirmation" = {
                    "background" = colorBg;
                    "body" = colorText;
                    "border" = colorUrgent;
                    "button_text" = colorBg;
                    "card" = colorBgAlt;
                    "confirm" = colorConfirm;
                    "deny" = colorDeny;
                    "label" = colorText;
                  };
                  "shutdown" = colorHotter;
                  "restart" = colorHot;
                  "logout" = colorCold;
                  "sleep" = colorColder;
                };

                "shortcuts" = {
                  "background" = colorColder;
                  "recording" = colorBg;
                  "text" = colorBg;
                };
              };

              "media" = {
                "album" = colorText;
                "artist" = colorText;
                "background.color" = colorBg;
                "border.color" = colorUrgent;
                "card.color" = colorBgAlt;
                "scaling" = 93;
                "song" = colorText;
                "timestamp" = colorText;

                "buttons" = {
                  "background" = colorUrgent;
                  "enabled" = colorUrgent;
                  "inactive" = colorBg;
                  "text" = colorText;
                };

                "slider" = {
                  "background" = colorBg;
                  "backgroundhover" = colorBgHover;
                  "primary" = colorUrgent;
                  "puck" = colorUrgent;
                };
              };

              "network" = {
                "text" = colorText;
                "background.color" = colorBg;
                "border.color" = colorUrgent;
                "card.color" = colorBgAlt;
                "label.color" = colorText;

                "iconbuttons" = {
                  "active" = colorBg;
                  "passive" = colorUrgent;
                };

                "icons" = {
                  "active" = colorUrgent;
                  "passive" = colorBg;
                };

                "listitems" = {
                  "active" = colorBg;
                  "passive" = colorUrgent;
                  "text" = colorText;
                };

                "scaling" = 97;
                "scroller.color" = colorSelection;
                "status.color" = colorText;

                "switch" = {
                  "disabled" = colorBg;
                  "enabled" = colorUrgent;
                  "puck" = colorBgAlt;
                };
              };

              "notifications" = {
                "background" = colorBg;
                "border" = colorUrgent;
                "text" = colorText;
                "card" = colorBgAlt;
                "clear" = colorUrgent;
                "height" = "45em";
                "label" = colorTextAlt;
                "no_notifications_label" = colorBgAlt;

                "pager" = {
                  "background" = colorBg;
                  "button" = colorUrgent;
                  "label" = colorUrgent;
                };

                "scaling" = 98;
                "scrollbar.color" = colorSelection;

                "switch" = {
                  "disabled" = colorBg;
                  "enabled" = colorUrgent;
                  "puck" = colorBgAlt;
                };
                "switch_divider" = colorBg;
              };

              "power" = {
                "background.color" = colorBg;
                "border.color" = colorUrgent;

                "buttons" = {
                  "logout" = {
                    "background" = colorBg;
                    "icon" = colorText;
                    "icon_background" = colorBg;
                    "text" = colorText;
                  };

                  "restart" = {
                    "background" = colorBg;
                    "icon" = colorText;
                    "icon_background" = colorBg;
                    "text" = colorText;
                  };

                  "shutdown" = {
                    "background" = colorBg;
                    "icon" = colorText;
                    "icon_background" = colorBg;
                    "text" = colorText;
                  };

                  "sleep" = {
                    "background" = colorBg;
                    "icon" = colorText;
                    "icon_background" = colorBg;
                    "text" = colorText;
                  };
                };
              };

              "systray.dropdownmenu" = {
                "background" = colorBg;
                "divider" = colorBgAlt;
                "text" = colorText;
              };

              "volume" = {
                "scaling" = 96;
                "text" = colorText;
                "label.color" = colorText;
                "background.color" = colorBg;
                "border.color" = colorUrgent;
                "card.color" = colorBgAlt;

                "audio_slider" = {
                  "background" = colorBg;
                  "backgroundhover" = colorBgHover;
                  "primary" = colorUrgent;
                  "puck" = colorUrgent;
                };

                "iconbutton" = {
                  "active" = colorUrgent;
                  "passive" = colorBg;
                };

                "icons" = {
                  "active" = colorUrgent;
                  "passive" = colorBg;
                };

                "input_slider" = {
                  "background" = colorBg;
                  "backgroundhover" = colorBgHover;
                  "primary" = colorUrgent;
                  "puck" = colorBgAlt;
                };

                "listitems" = {
                  "active" = colorUrgent;
                  "passive" = colorBg;
                };
              };
            };

            "popover" = {
              "background" = colorBg;
              "border" = colorUrgent;
              "text" = colorText;
            };

            "progressbar" = {
              "background" = colorBgAlt;
              "foreground" = colorUrgent;
            };

            "slider" = {
              "background" = colorBg;
              "backgroundhover" = colorBgHover;
              "primary" = colorUrgent;
              "puck" = colorBgAlt;
            };

            "switch" = {
              "disabled" = colorBg;
              "enabled" = colorUrgent;
              "puck" = colorBgAlt;
            };
            "text" = colorText;

            "tooltip" = {
              "background" = colorBg;
              "text" = colorText;
            };
          };
          "opacity" = 85;
          "outer_spacing" = "0.3em";
          "transparent" = true;
        };

        "font" = {
          "label" = fonts.monospace.name;
          "name" = fonts.monospace.name;
          "size" = "1em";
          "weight" = 600;
        };

        "matugen" = false;

        "notification" = {
          "actions" = {
            "background" = colorBg;
            "text" = colorText;
          };

          "background" = colorBg;
          "border" = colorUrgent;

          "close_button" = {
            "background" = colorUrgent;
            "label" = colorBg;
          };
          "label" = colorText;
          "labelicon" = colorText;
          "text" = colorText;
        };

        "osd" = {
          "bar_color" = colorUrgent;
          "bar_container" = colorBg;
          "bar_empty_color" = colorBgAlt;
          "bar_overflow_color" = colorWarning;
          "duration" = 2000;
          "icon" = colorTextDarkBg;
          "icon_container" = colorUrgent;
          "label" = colorText;
          "location" = "top";
          "margins" = "10px 5px 10px 0px";
          "orientation" = "horizontal";
          "radius" = "0.3em";
          "scaling" = 100;
        };
      };
      "wallpaper.pywal" = false;

      "menus.clock.weather.location" = "Valladolid";
    };
  };

  programs.wlogout = {
    enable = true;
    layout = [

      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      * {
      	background-image: none;
      	transition: 0;
      }
      window {
      	background-color: rgba(12, 12, 12, 0.1);
      }
      button {
        color: ${colorText};
      	background-color: ${colorBg};
      	border: 0.2rem solid ${colorUrgent};
      	border-radius: 1rem;
      	margin: 0.8rem;
      	background-repeat: no-repeat;
      	background-position: center 20%;
      	background-size: 20%;
      	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      	font-family: ${fonts.monospace.name};
      	font-size: 1.7rem;
      }

      button:focus, button:active, button:hover {
      	background-color: ${colorBgAlt};
      	outline-style: none;
      }

      #lock {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/generated/lock.png");
      }

      #logout {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/generated/logout.png");
      }

      #suspend {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/generated/pause.png");
      }

      #hibernate {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/generated/hibernate.png");
      }

      #shutdown {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/generated/shutdown.png");
      }

      #reboot {
          background-image: url("file:///home/${config.home.username}/.config/wlogout/icons/generated/reboot.png");
      }
    '';
  };

  home.activation.recolorIcons = lib.hm.dag.entryAfter [ "writeHomeFiles" ] ''
    #!/usr/bin/env bash
    set -e

    SVG_DIR="$HOME/.config/wlogout/icons/original"
    OUT_DIR="$HOME/.config/wlogout/icons/generated"

    mkdir -p "$OUT_DIR"

    # Usamos la variable Nix pasada al script
    COLOR="${colorText}"

    for svg in "$SVG_DIR"/*.svg; do
      base=$(basename "$svg" .svg)
      # Reemplaza el fill por el color de la variable Nix
      cp "$svg" "$OUT_DIR/''${base}.svg"
      
      sed -E -i \
        -e "s/fill=\"#[0-9a-fA-F]{3,6}\"/fill=\"$COLOR\"/g" \
        -e "s/fill:#[0-9a-fA-F]{3,6}/fill:$COLOR/g" \
        -e "s/stroke=\"#[0-9a-fA-F]{3,6}\"/stroke=\"$COLOR\"/g" \
        -e "s/stroke:#[0-9a-fA-F]{3,6}/stroke:$COLOR/g" \
        "$OUT_DIR/''${base}.svg"
      # Opcional: generar PNG
      ${pkgs.librsvg}/bin/rsvg-convert -w 128 -h 128 "$OUT_DIR/''${base}.svg" > "$OUT_DIR/''${base}.png"
    done
  '';

  home.file.".config/wlogout/icons/original/shutdown.svg".source = ./wlogout/shutdown.svg;
  home.file.".config/wlogout/icons/original/pause.svg".source = ./wlogout/pause.svg;
  home.file.".config/wlogout/icons/original/lock.svg".source = ./wlogout/lock.svg;
  home.file.".config/wlogout/icons/original/logout.svg".source = ./wlogout/logout.svg;
  home.file.".config/wlogout/icons/original/reboot.svg".source = ./wlogout/reboot.svg;
  home.file.".config/wlogout/icons/original/hibernate.svg".source = ./wlogout/hibernate.svg;

  home.packages = [ pkgs.librsvg ];
}

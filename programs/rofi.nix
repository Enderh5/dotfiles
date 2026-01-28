{
  config,
  ...
}:
let
  colors = config.lib.stylix.colors;
  fonts = config.stylix.fonts;

  colorText = "#${colors.base05}ff";
  colorTextAlt = "#${colors.base04}ff";
  colorBg = "#${colors.base00}ff";
  colorBgAlt = "#${colors.base01}ff";
  colorBgHover = "#${colors.base03}ff";
  colorSelection = "#${colors.base02}ff";
  colorWarning = "#${colors.base0A}ff";
  colorUrgent = "#${colors.base09}ff";
  colorError = "#${colors.base08}ff";
  colorTextDarkBg = "#${colors.base00}ff";
  colorHotter = "#${colors.base08}ff";
  colorHot = "#${colors.base09}ff";
  colorMild = "#${colors.base0A}ff";
  colorCold = "#${colors.base0D}ff";
  colorColder = "#${colors.base0D}ff";
  colorDisbledButton = "#${colors.base04}ff";
  colorConfirm = "#${colors.base0B}ff";
  colorDeny = "#${colors.base0F}ff";
in
{
  programs.rofi = {
    enable = true;
    # theme = "/home/rodrigo/.config/rofi/launcher.rasi";
  };

  home.file.".config/rofi/launcher.sh" = {
    text = ''
        #!/usr/bin/env bash

      ## Author : Aditya Shakya (adi1090x)
      ## Github : @adi1090x
      #
      ## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
      #
      ## Available Styles
      #
      ## style-1     style-2     style-3     style-4     style-5

      dir="$HOME/.config/rofi/"

      ## Run
      rofi \
          -show drun \
          -hover-select \
          -theme ''${dir}/launcher.rasi
    '';
    executable = true;
  };

  home.file.".config/rofi/launcher.rasi".text = ''
    	/**
    	 *
    	 * Author : Aditya Shakya (adi1090x)
    	 * Github : @adi1090x
    	 * 
    	 * Rofi Theme File
    	 * Rofi Version: 1.7.3
    	 **/

    	/*****----- Configuration -----*****/
    	configuration {
    		modi:                       "drun,filebrowser,window";
        show-icons:                 true;
        display-drun:               "Apps";
        display-run:                "Run";
        display-filebrowser:        "Files";
        display-window:             "Windows";
    		drun-display-format:        "{name}\n[<span weight='light' size='small'><i>({generic})</i></span>]";
    		window-format:              "Class : {c}\nWorkspace : {w}";
        terminal: "kitty";
    	}

    	/*****----- Global Properties -----*****/
    	* {
    	    font:                        "${fonts.monospace.name} Bold 10";
    	}

    	/*****----- Main Window -----*****/
    	window {
    	    /* properties for window widget */
    	    transparency:                "real";
    	    location:                    center;
    	    anchor:                      center;
    	    fullscreen:                  false;
    	    width:                       500px;
    	    x-offset:                    0px;
    	    y-offset:                    0px;

    	    /* properties for all widgets */
    	    enabled:                     true;
    	    margin:                      0px;
    	    padding:                     0px;
    	    border-radius:               10px;
    	    cursor:                      "default";
          border:                      2px;
          border-color:                ${colorUrgent};
    	    background-color:            ${colorBg};
    	}

    	/*****----- Main Box -----*****/
    	mainbox {
    	    enabled:                     true;
    	    spacing:                     15px;
    	    padding:                     30px;
    	    background-color:            transparent;
    	    children:                    [ "inputbar", "mode-switcher", "listview" ];
    	}

    	/*****----- Inputbar -----*****/
    	inputbar {
    	    enabled:                     true;
    	    spacing:                     15px;
    	    margin:                      0px;
    	    background-color:            transparent;
    	    children:                    [ "textbox-prompt-colon", "entry" ];
    	}

    	textbox-prompt-colon {
    	    enabled:                     true;
    	    expand:                      false;
    	    padding:                     12px 16px;
    	    border:                      0px;
    	    border-radius:               10px;
    	    background-color:            ${colorBgAlt};
    	    text-color:                  ${colorText};
    	    str:                         "";
    	}
    	entry {
    	    enabled:                     true;
    	    padding:                     12px 16px;
    	    border:                      1px;
    	    border-radius:               10px;
    	    background-color:            ${colorBgAlt};
    	    border-color:                ${colorBgAlt};
    	    text-color:                  ${colorText};
    	    cursor:                      text;
    	    placeholder:                 "Search...";
    	    placeholder-color:           inherit;
    	    vertical-align:              0.5;
    	    horizontal-align:            0.0;
    	}

    	/*****----- Listview -----*****/
    	listview {
    	    enabled:                     true;
    	    columns:                     1;
    	    lines:                       5;
    	    cycle:                       true;
    	    dynamic:                     true;
    	    scrollbar:                   false;
    	    layout:                      vertical;
    	    reverse:                     false;
    	    fixed-height:                true;
    	    fixed-columns:               true;
    	    
    	    spacing:                     10px;
    	    background-color:            transparent;
    	    cursor:                      "default";
    	}

    	/*****----- Elements -----*****/
    	element {
    	    enabled:                     true;
    	    spacing:                     10px;
    	    margin:                      0px;
    	    padding:                     10px;
    	    border:                      0px solid;
    	    border-radius:               10px;
    	    background-color:            ${colorBgAlt};
    	    text-color:                  ${colorText};
    	    cursor:                      pointer;
    	}
    	element normal.active {
          background-color:            ${colorCold};
    	    text-color:                  ${colorBg};
    	}
    	element selected.normal {
    	    border-radius:               10px;
          background-color:            ${colorUrgent};
    	    text-color:                  ${colorBg};
    	}
    	element selected.active {
          background-color:            ${colorUrgent};
    	    text-color:                  ${colorBg};
    	}
    	element-icon {
    	    background-color:            transparent;
    	    size:                        48px;
    	    cursor:                      inherit;
    	}

    	element-text {
    	    background-color:            inherit;
    	    text-color:                  inherit;
    	    cursor:                      inherit;
    	    vertical-align:              0.5;
    	    horizontal-align:            0.0;
    	}

    	/*****----- Mode Switcher -----*****/
    	mode-switcher{
    	    enabled:                     true;
    	    expand:                      false;
    	    spacing:                     15px;
    	    background-color:            transparent;
    	}
    	button {
    	    font:                        "${fonts.monospace.name}";
    	    padding:                     10px;
    	    border-radius:               100%;
          background-color:            ${colorBgAlt};
    	    text-color:                  ${colorText};
    	    cursor:                      pointer;
    	}
    	button selected {
          background-color:            ${colorUrgent};
    	    text-color:                  ${colorBg};
    	}

    	/*****----- Message -----*****/
    	error-message {
    	    padding:                     20px;
    	    background-color:            ${colorBg};
    	    text-color:                  ${colorText};
    	}
    	textbox {
    	    padding:                     0px;
    	    border-radius:               0px;
    	    text-color:                  ${colorText};
    	    vertical-align:              0.5;
    	    horizontal-align:            0.0;
    	}
  '';

}

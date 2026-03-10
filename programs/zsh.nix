{
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      share = true; # Share history across sessions
      ignoreDups = true; # Ignore consecutive duplicates
    };

    shellAliases = {
      ll = "ls -l";
      update = "home-manager switch --flake ~/home-flake/";
      # "java-run" =
      # "${pkgs.jetbrains.jdk}/lib/openjdk/bin/java -javaagent:${pkgs.jetbrains.idea-ultimate}/idea-ultimate/lib/idea_rt.jar=38389:${pkgs.jetbrains.idea-ultimate}/idea-ultimate/bin -Dfile.encoding=UTF-8 -classpath";
    };

    sessionVariables = { };

    initContent = ''
      eval "$(direnv hook zsh)"

      export PATH="$HOME/go/bin:$PATH"
      export PATH="/mnt/c/Users/rafv/AppData/Local/Microsoft/WinGet/Links:$PATH"
      export PATH="/mnt/c/Windows/System32:$PATH"
      export EDITOR='nvim'
      export VISUAL='nvim'
      export GRIM_DEFAULT_DIR='~/Pictures/Screenshots'
      export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD ')
    '';
  };
}

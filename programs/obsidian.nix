{ inputs, ... }:
{
  programs.obsidian = {
    enable = true;
    vaults = {
      "Apuntes" = {
        target = "Documentos/Apuntes";
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  browser = lib.getExe pkgs.chromium;
in
{
  xdg.desktopEntries = {
    Drive = {
      name = "Google Drive";
      exec = "${browser} --app=https://drive.google.com";
      icon = "google-drive";
    };
    Comuna = {
      name = "Comuna";
      exec = "${browser} --app=https://drive.google.com/drive/folders/11cukVHjWrdI6kr5NVtinFDRrsxfFPjDr";
      icon = "notes-up";
    };

    Campus = {
      name = "Campus virtual";
      exec = "${browser} --app=https://campusvirtual.uva.es/my/";
      icon = "applications-education";
    };
    Github = {
      name = "Github";
      exec = "${browser} --app=https://github.com";
      icon = "github";
    };
    Mathcha = {
      name = "Mathcha";
      exec = "${browser} --app=https://www.mathcha.io/editor";
      icon = "applications-maths";
    };
    Matlab = {
      name = "Matlab";
      genericName = "Software de cálculo numérico";
      comment = "Entorno de programación para algoritmos y datos.";
      exec = "env XDG_DATA_DIRS=\"\" distrobox enter Matlab -- env _JAVA_AWT_WM_NONREPARENTING=1 /home/rodrigo/MATLAB/R2025b/bin/matlab -desktop";
      icon = "matlab";
      categories = [
        "Development"
        "Science"
        "Education"
      ];
      settings = {
        StartupWMClass = "Matlab R2025b";
      };
    };
  };

}

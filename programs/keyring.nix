{ pkgs, home, ... }: {
  services.gnome-keyring = {
    enable = true;
    # Habilita los componentes necesarios (especialmente 'secrets' para la API org.freedesktop.secrets)
    components = [
      "secrets"
      "ssh"
      "pkcs11"
    ];
  };

  home.sessionVariables = {
    # Apunta la clave por defecto al socket de GNOME Keyring
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
  };
}

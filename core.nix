{ config, pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  finit.runlevel = 3;
  finit.services.nix-daemon = { environment.CURL_CA_BUNDLE = config.security.pki.caBundle; };
  services.nix-daemon = {
    enable = true;
    settings = { experimental-features = [ "nix-command" "flakes" ]; trusted-users = [ "root" "@wheel" ]; };
  };
  programs.limine = { enable = true; settings.editor_enabled = true; };
  programs.sudo.enable = true;
  programs.bash.enable = true;
  services.polkit.enable = true;
  services.sysklogd.enable = true;
  services.dbus.enable = true;
}

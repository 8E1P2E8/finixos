{ ... }: {
  networking.hostName = "latitude5400"; 
  time.timeZone = "America/Los_Angeles";
  services.dhcpcd.enable = true;
  services.iwd.enable = true;
  services.openssh = { enable = true; settings.PermitRootLogin = "no"; };
}

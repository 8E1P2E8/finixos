{ pkgs, config, ... }: {
  users.users.EPE = {
    isNormalUser = true;
    description = "EPE";
    extraGroups = [ "wheel" "video" "kvm" config.services.seatd.group ];
    password = "$y$j9T$ger6rFJk9H.iujdy2aPGc1$UmV.PRDaSg.zBXUFqsUFOZDqO8XraS.rNXHXVehDLq5";
  };
  users.users.greeter = { extraGroups = [ "video" config.services.seatd.group ]; };
  environment.systemPackages = with pkgs; [ vim wget git nixos-rebuild-ng iputils iproute2 foot crosvm chromium gh ];
}

{ pkgs, config, ... }: {
  programs.labwc.enable = true;
  programs.sway.enable = true;
  services.mdevd.enable = true;
  services.seatd.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      initial_session = { command = "sway"; user = "EPE"; };
      default_session = { command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway"; user = "greeter"; };
    };
  };
  fonts = { fontconfig.enable = true; enableDefaultPackages = true; packages = with pkgs; [ nerd-fonts.fira-code ]; };
}

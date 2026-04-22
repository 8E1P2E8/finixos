# Minimal Finix
This is my minimal configuration for finix. It installs absolutely nothing but the things needed to work on and expand a finix configuration.

It is primarily written for people to mess around in a Virtual Machine and see how they like configuring finix, though it should work on bare metal with an ethernet cable as far as I'm aware, but I haven't tested it. There is no built in wireless support because :sparkles:*minimalism*:sparkles: (I will likely add wifi later via wpa\_supplicant, just haven't needed it yet).

# Notes

Make sure that the NixOS installation boots using UEFI, legacy booting was causing issues with `limine` not being detected. If you have a fix please let me know.

I try not to inject any opinions into this configuration. The only choice I have made is between `mdevd` and `udev`. I chose `mdevd` simply because that is what the other members of the finix community suggested and use.

# Installing

Clone or download this repo to a folder on your system, then make sure you change the username in `./finix/configuration.nix` to whatever the nix systems username actually is, then change the hostname in the same file as well as the configuration name in `flake.nix`. Then you can run

```bash
nixos-rebuild boot --install-bootloader --sudo --flake .
```

and reboot. You're in!

# Requirements

- Nix Flakes

# Helpful links

[Finix](https://github.com/finix-community/finix)
[Finix Options Wiki](https://finix-community.github.io/finix/options.html)
[aanderse Config](https://github.com/aanderse/finix-config)
[Finit](https://github.com/finit-project/finit)

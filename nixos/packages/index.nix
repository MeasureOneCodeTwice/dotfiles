{ config, pkgs, ...}:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./core/index.nix
    ./cpp/index.nix
    ./desktop-environment/index.nix
    ./development/index.nix
    ./graphical/index.nix
    ./java/index.nix
    ./misc/index.nix
    ./network-dev/index.nix
    ./python/index.nix
    ./terminal-basics/index.nix
    ./typescript/index.nix
  ];
}

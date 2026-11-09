{ config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./package-configuration.nix
  ];


  environment.systemPackages = 
    (import ./groups/desktop-environment.nix) pkgs unstable       ++
    (import ./groups/terminal-basics.nix)     pkgs unstable ++
    (import ./groups/development.nix)         pkgs unstable ++
    (import ./groups/network-dev.nix)         pkgs unstable ++
    # (import ./groups/typescript.nix)          pkgs unstable ++
    (import ./groups/graphical.nix)           pkgs unstable ++
    (import ./groups/python.nix)              pkgs unstable       ++
    (import ./groups/cpp.nix)                 pkgs unstable ++ 
    # (import ./groups/java.nix)                pkgs unstable       ++
    (import ./groups/misc.nix)                pkgs unstable ++
    (import ./groups/core.nix)                pkgs unstable;
}

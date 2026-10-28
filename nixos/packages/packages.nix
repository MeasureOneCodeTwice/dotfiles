{ config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    ./package-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = 
  let 
    developmentPackages        = (import ./groups/development.nix);
    pythonPackages             = (import ./groups/python.nix);
    cppPackages                = (import ./groups/cpp.nix);
    graphicalPackages          = (import ./groups/graphical.nix);
    javaPackages               = (import ./groups/java.nix);
    typescriptPackages         = (import ./groups/typescript.nix);
    networkDevelopmentPackages = (import ./groups/network-dev.nix);
    basicTerminalPackages      = (import ./groups/terminal-basics.nix);
    desktopEnvironmentPackages = (import ./groups/desktop-environment.nix);
    miscPackages               = (import ./groups/misc.nix);
  in
    developmentPackages        pkgs unstable ++
    pythonPackages             pkgs {}       ++
    cppPackages                pkgs unstable ++
    graphicalPackages          pkgs unstable ++
    javaPackages               pkgs {}       ++
    typescriptPackages         pkgs unstable ++
    networkDevelopmentPackages pkgs unstable ++
    basicTerminalPackages      pkgs unstable ++ 
    desktopEnvironmentPackages pkgs {}       ++
    miscPackages               pkgs {};
}

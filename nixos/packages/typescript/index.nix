{config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
    environment.systemPackages = with pkgs; [
        unstable.nodejs_26
        typescript
        typescript-language-server
    ];
}

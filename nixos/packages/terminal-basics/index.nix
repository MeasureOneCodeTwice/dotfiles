{config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    ./bash.nix
    ./nvim.nix
  ];

  environment.systemPackages = with pkgs; [
    unstable.neovim
    tmux
    openssh
    zip
    unzip
    ripgrep
    fd
    ffmpeg
    wget
  ];
}

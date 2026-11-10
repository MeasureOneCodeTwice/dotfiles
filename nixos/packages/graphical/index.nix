{config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
    imports = [
	./hyprlock.nix
	./vmware.nix
    ];

    environment.systemPackages = with pkgs; [
	hyprlock
	firefox
	thunderbird
	telegram-desktop
	discord
	gimp
	swayimg #everything but pdf viewer
	zathura #pdf viewer
	obsidian
	libreoffice-qt6-fresh
	anki
	zoom-us
	arduino-ide
	pavucontrol
	unstable.spotify-player
	alacritty
	qbittorrent
    ];
}

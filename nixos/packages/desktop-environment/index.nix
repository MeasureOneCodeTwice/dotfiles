{config, pkgs, ...}:
{
    imports = [
	./sway.nix
    ];
    environment.systemPackages = with pkgs; [
	wl-clipboard
	cliphist
	fuzzel
	alsa-utils
	brightnessctl
	wl-clipboard
	sway-contrib.grimshot
    ];
}

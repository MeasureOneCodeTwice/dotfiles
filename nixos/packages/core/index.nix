{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
	keyd
    ];
}

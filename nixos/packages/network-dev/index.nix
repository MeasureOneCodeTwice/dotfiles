{config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
    environment.systemPackages = with pkgs; [
	tshark
	# unstable.cisco-packet-tracer_9
	netcat
	socat
    ];
}

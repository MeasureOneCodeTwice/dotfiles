{config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
    environment.systemPackages = with pkgs; [
	unstable.clang-tools
	unstable.gcc
	clang
	cmake
	gnumake
	valgrind
	gdb
	xxd
	lldb
    ];
}

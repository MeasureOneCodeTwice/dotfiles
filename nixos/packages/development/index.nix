{config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
    environment.systemPackages = with pkgs; [
	unstable.awscli2
	tenv
	    
	man-pages
	man-pages-posix
	git
	github-cli
	gitlab-runner

	bash-language-server

	postman
	dos2unix
    ];
}

{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
	google-java-format
	openjdk25
	jdt-language-server
    ];
}

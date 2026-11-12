{config, pkgs ...}: {
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

	makeDesktopItem {
		type = "Application"
		name = "pavucontrol"
		exec = "pavucontrol"
		categories = [ "Sound", "Audio" ]
	};
}

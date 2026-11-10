{ config, pkgs, ... }:
{
  imports = [
    ./packages/index.nix
    ./etc-nixos-configuration.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Winnipeg";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.xkb = {
    layout = "us";
  };
  console.keyMap = "dvorak";


  users.users.logan = {
    isNormalUser = true;
    description = "Logan Decock";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  #To get electron to respect custom keymap. 
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  
  # Enable the OpenSSH daemon.
  services.openssh.enable = false;
  programs.ssh.startAgent = false;



}

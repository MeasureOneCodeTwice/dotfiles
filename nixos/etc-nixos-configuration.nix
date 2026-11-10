{config, pkgs, ...}:
{
  
  imports = [
    /etc/nixos/hardware-configuration.nix 
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #audio
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   pulse.enable = true;
  # };

  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    features.containerd-snapshotter = true;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["logan"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  services.tlp.enable = true;
  #taken from this great blog
  #https://linuxblog.io/thinkpad-t14s-gen-3-amd-linux-user-review-tweaks/
  #trades extra performance for battery. 
  services.tlp.settings = {

    CPU_DRIVER_OPMODE_ON_AC="passive";
    CPU_DRIVER_OPMODE_ON_BAT="passive";

    CPU_SCALING_GOVERNOR_ON_AC="ondemand";
    CPU_SCALING_GOVERNOR_ON_BAT="conservative";

    CPU_BOOST_ON_AC=1;
    CPU_BOOST_ON_BAT=0;

    PLATFORM_PROFILE_ON_AC="balanced";
    PLATFORM_PROFILE_ON_BAT="low-power";

    RADEON_DPM_PERF_LEVEL_ON_AC="auto";
    RADEON_DPM_PERF_LEVEL_ON_BAT="low";

    USB_EXCLUDE_BTUSB=1;

    #possibly caused wifi to be disabled. Use 
    #nmcli radio' to see if wifi is disabled.
    #use 'nmcli radio wifi on' to enable wifi.
    DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="bluetooth nfc wwan";

    START_CHARGE_THRESH_BAT0=50;
    STOP_CHARGE_THRESH_BAT0=80;

    NATACPI_ENABLE=1;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

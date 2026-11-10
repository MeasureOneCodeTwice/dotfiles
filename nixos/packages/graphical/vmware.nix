{config, pkgs, ...}:
{
  services.xserver.videoDrivers = [ "vmware" ];
    virtualisation.vmware.guest = { 
    headless = false;
    enable = true;
  };
  virtualisation.vmware.host.enable = true;
  environment.etc."xdg/autostart/vmware-user.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=VMware User Agent
    Exec=/run/wrappers/bin/vmware-user-suid-wrapper
    NoDisplay=true
  '';
}

{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [ hyprlock ];

    security.pam.services.hyprlock = {};
}


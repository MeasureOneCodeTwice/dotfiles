{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        python313
        # python312Packages.pip
        # python312Packages.flask
        # python312Packages.flake8
        # python313Packages.pyserial
        # pyright
    ];
}

{ config, pkgs, ...}:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{
# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
    #terminal applications 

        cowsay 

        ffmpeg
        wev

        #development
        unstable.awscli2
        tenv

        pkgs.man-pages
        pkgs.man-pages-posix
        github-cli
        git
        gitlab-runner

        sqlite
        mysql80

        go

        bun

        python3
        python312Packages.pip
        python312Packages.flask
        python312Packages.flake8
        python313Packages.pyserial
        pyright

        # rstudio

        clang
        clang-tools
        gcc
        gnumake
        valgrind
        gdb
        xxd
        lldb

        android-tools
        google-java-format
        openjdk23
        jdt-language-server


        unstable.nodejs_26
        typescript
        typescript-language-server

        ruby
        gemstash
        jekyll

        dos2unix

        postman
        netcat
        socat

        #terminal necisseties
        tmux
        openssh
        zip
        unzip
        ripgrep
        fd

    texliveFull

    #graphical applications
    firefox
    thunderbird
    telegram-desktop
    discord
    gimp
    swayimg #everything but pdf viewer
    zathura #pdf viewer
    obsidian
    vscode
    libreoffice-qt6-fresh
    anki
    zoom-us
    arduino-ide
    pavucontrol
    unstable.spotify-player
    alacritty

    #nvim
    unstable.neovim
    bash-language-server

    #desktop environment specific packages
    wl-clipboard
    cliphist
    fuzzel
    alsa-utils
    brightnessctl
    wl-clipboard #nvim uses to interface with clipboard
    slurp
    grim

    #network
    tshark
    ns-3
    unstable.cisco-packet-tracer_9
  ];
}

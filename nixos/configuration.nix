# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #nmcli config for uni wifi
  #ipv4.method auto
  #802-1x.eap peap
  #802-1x.phase2-auth mschapv2
  #802-1x.identity username
  #802-1x.password password
  #802-1x.wifi-sec.key-mgmt wpa-eap
  networking.networkmanager.enable = true;

  #audio
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   pulse.enable = true;
  # };




  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Set your time zone.
  time.timeZone = "America/Winnipeg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  #To get electron to respect custom keymap. 
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.logan = {
    isNormalUser = true;
    description = "Logan Decock";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };


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
    unstable.spotifyd

    #nvim
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
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    swt
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  
    # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #nvim config
  #Use the Nix package search engine to find
  #even more plugins : https://search.nixos.org/packages
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.foot = {
    enable = true;
    # needed?
    # enableBashIntegration = true

    settings = {

      main = {
        font="monospace:size=18";
      };

      colors = {
        background="000000";
        alpha=0.985;
      };

    };

  };

  #sway window manager config
  programs.sway = {
  	enable = true;
	wrapperFeatures.gtk = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;
}

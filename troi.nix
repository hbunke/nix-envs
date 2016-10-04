# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /home/bunke/nix-envs/network.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.gummiboot.timeout = 15;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/mnt/arch_root" = { device = "/dev/sda2"; };
  fileSystems."/mnt/arch" = { device = "/dev/sda3"; };


  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n = {
     consoleFont = "lat9w-16";
     consoleKeyMap = "de";
     defaultLocale = "de_DE.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
     wget
     #vim_configurable
#     htop
#     python27Full
#     python27Packages.pip
#     python27Packages.virtualenv
     stdenv
     gcc
#     libxml2
#     libxslt

      #XXX zlib is needed here for otherwise lxml for python won't build. for
      #some reason a zlib in a myEnvFun environment is not sufficient
#      zlib
#     libzip
      firefox
  ];

  # pip otherwise had difficulties with psycopg
  environment.pathsToLink = [ "/include" ];
  environment.shellInit =
    ''
    # help pip to find libraries
    export LIBRARY_PATH=/var/run/current-system/sw/lib;
    # ditto for header files, e.g. sqlite
    export C_INCLUDE_PATH=/var/run/current-system/sw/include
    ''
    ;


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;
#  services.openssh.listenAddresses = [
#    { addr = "192.168.0.10"; }
#    { addr = "127.0.0.1"; }
#  ];
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "no";


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.displayManager.slim.enable = true;

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  #services.xserver.windowManager.xmonad.extraPackages = haskellPackages: [
  #  haskellPackages.xmonad-utils
  #  ];
  services.xserver.windowManager.default = "xmonad";


  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];


  # for some reason user postgres is not created during setup.
  # add it with:
  # createuser -s -r postgres
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql94; #no, this is NOT a string! ;-)

  services.solr.enable = true;
  services.solr.user = "bunke";
  services.solr.group = "wheel";
  services.solr.solrHome = "/home/bunke/solr";

  services.cron.enable = true;
  services.cron.cronFiles = [ "/home/bunke/.crontab" ];



  programs.zsh.enable = true;
  programs.zsh.promptInit = "";

  hardware.pulseaudio.enable = true;

 # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  users.extraUsers.bunke = {
    name = "bunke";
    isNormalUser = true;
    #createHome = true;
    #home = "/home/bunke";
    #group = "users";
    extraGroups = [ "wheel" ];
    shell = "/run/current-system/sw/bin/zsh";
  };



}

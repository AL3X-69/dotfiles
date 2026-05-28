# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
    imports = [ 
        ./hardware-configuration.nix
    ];

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "alpha"; 
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "fr_FR.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
    };

    services.xserver.xkb = {
        layout = "fr";
        variant = "azerty";
    };

    environment.shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake /home/alex6/dotfiles#alpha";
    };
    environment.pathsToLink = [ "/share/zsh" ];

    services.displayManager.ly.enable = true;
    programs.hyprland.enable = true;
    programs.zsh.enable = true;

    console.keyMap = "fr";

    users.users.alex6 = {
        isNormalUser = true;
        description = "Alex6";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };


    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        neovim 
        wget
        fastfetch
        bat
    ];

    system.stateVersion = "25.11"; 

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot = {
        loader = {
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
            };
        };
        initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/5991cbe5-6c3b-41a8-a989-da6c6144f8a8";
    };
}

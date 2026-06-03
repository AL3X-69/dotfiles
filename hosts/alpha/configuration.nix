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

    services.displayManager.ly = {
        enable = true;
        settings = {
            animation = "colormix";
            bigclock = "en";
            bigclock_seconds = true;
            clear_password = true;
            clock = "%D %T";
            lang = "fr";
            numlock = true;
        };
    };
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

    system.stateVersion = "26.05"; 

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot = {
        loader = {
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
                theme = pkgs.stdenv.mkDerivation {
                    pname = "marathon-grub-theme";
                    version = "1.0.0";
                    src = pkgs.fetchFromGitHub {
                        owner = "Woysful";
                        repo = "Marathon-Grub-Themes";
                        rev = "a235901";
                        hash = "sha256-WcPuFoyIESUwSmOa6wK6+3p7O13l+eziHU4jIEIY9Pw=";
                    };
                    installPhase = "cp Marathon-TitleScreen/theme_1080p.txt Marathon-TitleScreen/theme.txt && cp -r Marathon-TitleScreen $out";
                };
            };
        };
        initrd = {
            luks.devices.cryptroot.device = "/dev/disk/by-uuid/5991cbe5-6c3b-41a8-a989-da6c6144f8a8";
            systemd = {
                storePaths = [
                    "${pkgs.kbd}/bin/setleds"
                ];
                services.numlockon = {
                    description = "Enable NumLock at startup";
                    wantedBy = [ "initrd.target" ];
                    before = [ "initrd-root-device.target" ];
                    unitConfig = {
                        DefaultDependencies = false;
                    };
                    serviceConfig = {
                        Type = "oneshot";
                        ExecStart = "${pkgs.kbd}/bin/setleds -D +num";
                        StandardInput = "tty";
                        TTYPath = "/dev/tty0";
                    };
                };
            };
        };
        plymouth.enable = true;
    };
}

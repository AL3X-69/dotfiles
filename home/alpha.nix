{ config, pkgs, inputs, ... }:
{
    home.username = "alex6";
    home.homeDirectory = "/home/alex6";
    home.stateVersion = "26.05";

    imports = [
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
        ./hyprland
        ./kitty
        ./matugen
        ./wpaperd
        ./apps
    ];

    home.packages = with pkgs; [
        tree
        git
        rofi
        yazi
        thunar
        firefox-devedition
        waybar
        arduino
        kdePackages.ark
        unzip
        kdePackages.okular
        fritzing
        kdePackages.kate
    ];

    services.flatpak.packages = [
        "com.github.unrud.VideoDownloader"
        "com.obsproject.Studio"
        "com.usebottles.bottles"
        "io.github.flattool.Warehouse"
        "it.mijorus.smile"
        "moe.launcher.sleepy-launcher"
        "org.gimp.GIMP"
        "org.inkscape.Inkscape"
        "org.kde.krita"
        "org.vinegarhq.Sober"
        "org.vinegarhq.Vinegar"
    ];

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
            "nano" = "nvim";
            "v" = "nvim";
            "cat" = "bat";
        };
        initContent = ''
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            source ~/.p10k.zsh

            if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi

            echo
            fastfetch
        '';
    };

    programs.thunderbird.enable = true;
    programs.gpg.enable = true;
    programs.prismlauncher.enable = true;
    services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-gtk2;
        enableSshSupport = true;
        enableZshIntegration = true;
    };
    programs.gh.enable = true;

    programs.zsh.oh-my-zsh = {
        enable = true;
        plugins = [ "git" "aliases" "battery" ];
    };
}


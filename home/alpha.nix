{ config, pkgs, ... }:
{
    home.username = "alex6";
    home.homeDirectory = "/home/alex6";
    home.stateVersion = "25.11";
    home.file.".config/hypr".source = ./hypr;

    home.packages = with pkgs; [
        tree
            git
            rofi
            yazi
            thunar
            kitty
            firefox-devedition
            waybar
    ];

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
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

    programs.gpg.enable = true;
    services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-gtk2;
        enableSshSupport = true;
        enableZshIntegration = true;
    };

    programs.zsh.oh-my-zsh = {
        enable = true;
        plugins = [ "git" "aliases" "battery" ];
    };
}


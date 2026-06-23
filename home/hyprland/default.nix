{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        # hyprland is in system file
        hyprshutdown
        hyprlock
        hyprpicker
        hyprsunset
        hyprpolkitagent
    ];

    home.file.".config/hypr" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/hyprland/config";
        recursive = true;
    };

    services.cliphist.enable = true;
    services.dunst.enable = true;
}

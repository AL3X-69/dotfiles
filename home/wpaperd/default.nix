{ config, pkgs, ... }:
{
    services.wpaperd.enable = true;

    home.file = {
        ".config/wpaperd/config.toml".source = ./config.toml;
        ".config/wpaperd/matugen.sh".source = ./matugen.sh;
    };
}

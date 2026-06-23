{
    description = "Alex6 NixOS system configuration flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        nix-snapd.url = "github:nix-community/nix-snapd";
        nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
        nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    };

    outputs = inputs@{ nixpkgs, home-manager, nix-snapd, ... }: {
        nixosConfigurations.alpha = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [ 
                ./hosts/alpha/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs; };
                    home-manager.backupFileExtension = "backup";
                    home-manager.users.alex6 = ./home/alpha.nix;
                }
                nix-snapd.nixosModules.default
                {
                    services.snap.enable = true;
                }
            ];
        };
    };
}

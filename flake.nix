{
    description = "Alex6 NixOS system configuration flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
    };

    outputs = inputs@{ nixpkgs, home-manager, ... }: {
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
            ];
        };
    };
}

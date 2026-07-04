{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    mnw.url = "github:Gerg-L/mnw";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      testSpecialArgs = "i am special args";
      testExtraSpecialArgs = "i am extra special args";
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.photon = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit testExtraSpecialArgs;
              };
            };
          }
        ];

        specialArgs = {
          inherit testSpecialArgs;
        };
      };
    };
}

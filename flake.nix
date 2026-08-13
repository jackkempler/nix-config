{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:jackkempler/neovim-overlay/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, home-manager, neovim, ...}: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
	        nixpkgs.overlays = [neovim.overlays.default];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."jack" = import ./home.nix;
          };
        }
      ];
    };
    homeConfigurations."jack" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system}.extend neovim.overlays.default;
      modules = [./home.nix];
    };
  };
}

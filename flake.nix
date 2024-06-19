{
  description = "Gischthoge's NeoVim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    #    flake-parts = {
    #      url = "github:hercules-ci/flake-parts";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    systems,
    pre-commit-hooks,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    eachSystem = lib.genAttrs (import systems);

    pkgsFor = eachSystem (system: import nixpkgs {localSystem.system = system;});

    nvimFor = eachSystem (
      system: let
        nixvim' = nixvim.legacyPackages.${system};
      in {
        nvim = with pkgsFor.${system};
          nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module = ./config;
          };
      }
    );
  in {
    packages = eachSystem (system: {
      default = nvimFor.${system}.nvim;
    });

    formatter = eachSystem (system: pkgsFor.${system}.alejandra);

    devShells = eachSystem (system: {
      default = with pkgsFor.${system};
        import ./shell.nix {inherit pkgs;};
    });

    checks = eachSystem (
      system: let
        nixvimLib = nixvim.lib.${system};
      in {
        default = with nvimFor.${system}.nvim;
          nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "A nixvim configuration";
          };
      }
    );
  };
}

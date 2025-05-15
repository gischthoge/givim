# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license

{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  # see :help nixCats.flake.outputs
  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (inputs.nixCats) utils;
      luaPath = "${./.}";
      # this is flake-utils eachSystem
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        # allowUnfree = true;
      };
      dependencyOverlays = # (import ./overlays inputs) ++
        [ (utils.standardPluginOverlay inputs) ];

      categoryDefinitions = import ./nix/categories.nix;

      packageDefinitions = {
        givim = import ./nix/packageDefinitions/nixCats.nix;
        regularCats = import ./nix/packageDefinitions/regularCats.nix;
      };

      defaultPackageName = "givim";
    in forEachSystem (system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;

        pkgs = import nixpkgs { inherit system; };
      in {
        packages = utils.mkAllWithDefault defaultPackage;
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = with pkgs; [ 
              defaultPackage
              lua-language-server 
              nil 
              stylua 
              alejandra 
            ] ;
            inputsFrom = [ ];
            shellHook = "";
          };
        };

      }) // (let
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
      in {
        # these outputs will be NOT wrapped with ${system}
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      });
}

{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { lib, ... }:
      {
        systems = lib.systems.flakeExposed;

        perSystem =
          {
            config,
            pkgs,
            lib,
            ...
          }:
          {
            legacyPackages = import ./default.nix { inherit pkgs; };

            packages = lib.filterAttrs (_: v: lib.isDerivation v) config.legacyPackages;
          };

        flake = {
          nixosModules = import ./nixos-modules;
          # homeModules = import ./home-modules;
          # darwinModules = import ./darwin-modules;
          # flakeModules = import ./flake-modules;
        };
      }
    );
}

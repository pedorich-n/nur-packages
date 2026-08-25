{
  self,
  inputs,
  ...
}:
{
  perSystem =
    {
      system,
      config,
      pkgs,
      lib,
      ...
    }:
    {
      packages = lib.mkMerge [
        (lib.filterAttrs (_: v: lib.isDerivation v) config.legacyPackages)
        {
          docs = pkgs.callPackage ../dev/pkgs/nixos-module-docs {
            ndg-builder = inputs.ndg.packages.${system}.ndg-builder.override { ndg = pkgs.ndg; };
            nixosModules = lib.attrValues self.nixosModules;
          };
        }
      ];
    };
}

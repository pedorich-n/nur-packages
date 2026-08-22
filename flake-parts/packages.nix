{
  self,
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
    lib.mkMerge [
      {
        packages = (lib.filterAttrs (_: v: lib.isDerivation v) config.legacyPackages);
      }
      {
        packages = {
          nur-readme-generator = pkgs.callPackage ../dev/pkgs/nur-readme-generator {
            flake = self;
            inherit system;
          };
        };
      }
    ];
}

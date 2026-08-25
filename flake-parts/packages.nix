{
  self,
  inputs,
  ...
}:
{
  perSystem =
    {
      system,
      pkgs,
      lib,
      ...
    }:
    {
      packages = lib.mkMerge [
        (import ../packages.nix {
          inherit pkgs;
          inherit lib;
        })
        {
          docs = pkgs.callPackage ../dev/pkgs/nixos-module-docs {
            ndg-builder = inputs.ndg.packages.${system}.ndg-builder.override { ndg = pkgs.ndg; };
            rev = self.shortRev or "main";
            nixosModules = lib.attrValues self.nixosModules;
          };
        }
      ];
    };
}

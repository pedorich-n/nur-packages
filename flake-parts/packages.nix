{
  perSystem =
    {
      config,
      lib,
      ...
    }:
    lib.mkMerge [
      {
        packages = (lib.filterAttrs (_: v: lib.isDerivation v) config.legacyPackages);
      }
    ];
}

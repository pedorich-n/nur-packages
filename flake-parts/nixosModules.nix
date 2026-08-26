{
  self,
  ...
}:
{
  flake = {
    nixosModules = self.lib.modulesFromDirectoryRecursive {
      directory = ../nixos-modules;
    };
  };
}

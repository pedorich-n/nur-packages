{
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.touchup
  ];

  touchup = {
    # Hide `packages.<system>.docs` from `nix flake show` output`
    attr.packages.any.attr.docs.enable = false;

    # Hide `apps.<system>.nur-readme-update` from `nix flake show` output`
    attr.apps.any.attr.nur-readme-update.enable = false;
  };
}

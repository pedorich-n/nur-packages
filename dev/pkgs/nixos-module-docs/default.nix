{
  pkgs,
  ndg-builder,
  nixosModules ? [ ],
}:
ndg-builder.override {
  title = "Custom NixOS Modules";
  inputDir = ../../../docs;
  generateSearch = true;
  highlightCode = true;
  optionsDepth = 2;

  rawModules = nixosModules;
  moduleName = "pedorich-n/nur-packages/nixos-modules";
  basePath = ../../../nixos-modules;
  repoPath = "https://github.com/pedorich-n/nur-packages/blob/main/nixos-modules";

  extraConfig = {
    sidebar = {
      nested = true;
      ordering = "alphabetical";
    };
    stylesheet_paths = [
      ../../../docs/assets/custom.css
    ];
    # template_dir = ../../../docs/templates;
  };

  checkModules = false;
  specialArgs = { inherit pkgs; };
  moduleArgs = { inherit pkgs; };
}

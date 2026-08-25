{
  pkgs,
  ndg-builder,
  nixosModules ? [ ],
  rev ? "main",
}:
ndg-builder.override {
  title = "NUR";
  inputDir = ../../../docs;
  generateSearch = true;
  highlightCode = true;
  optionsDepth = 2;

  rawModules = nixosModules;
  moduleName = "pedorich-n/nur-packages/nixos-modules";
  basePath = ../../../nixos-modules;
  repoPath = "https://github.com/pedorich-n/nur-packages/blob/${rev}/nixos-modules";

  extraConfig = {
    footer_text = ''Generated with <a href="https://github.com/feel-co/ndg">ndg</a> | Commit: ${rev}'';
    sidebar = {
      ordering = "alphabetical";
      options = {
        depth = 2;
        nested = true;
      };
    };
    stylesheet_paths = [
      ../../../docs/assets/custom.css
    ];
  };

  checkModules = false;
  specialArgs = { inherit pkgs; };
  moduleArgs = { inherit pkgs; };
}

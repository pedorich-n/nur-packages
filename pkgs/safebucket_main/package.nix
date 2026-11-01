{
  pkgs,
  ...
}:
let
  safebucket = pkgs.callPackage ../safebucket/package.nix { };
in
safebucket.overrideAttrs (
  final: prev: {
    pname = "safebucket_main";
    version = "0.8.0-unstable-2026-10-31";
    src = pkgs.fetchFromGitHub {
      owner = "safebucket";
      repo = "safebucket";
      rev = "2de8a6299d4c4058f9ced6f79e23b5456275b75d";
      sha256 = "sha256-okblZmpjK0gbE6+9x2I7OYURxih7FKqSC0V5kCKfqKs=";
    };

    vendorHash = "sha256-tJF3N7ao4dwyg7fL6HSAUomW3u1TpnVcqPuxPzNrL1M=";

    passthru = prev.passthru // {
      updateScript = pkgs.nix-update-script {
        extraArgs = [
          "--flake"
          "--version=branch"
          "--subpackage"
          "frontend"
        ];
      };

      frontend = prev.passthru.frontend.overrideAttrs (
        feFinal: fePrev: {
          npmDepsHash = "sha256-F0pu3mQpGARBnx/OJm7R8FgOLg/w2fel+xjTrXwn8z4=";
          npmDeps = pkgs.fetchNpmDeps {
            inherit (final) src;
            sourceRoot = "${feFinal.src.name}/web";
            hash = feFinal.npmDepsHash;
          };
        }
      );
    };

    meta = prev.meta // {
      description = prev.meta.description + " (tracking main branch)";
    };
  }
)

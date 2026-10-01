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
    version = "0.7.5-unstable-2026-09-28";
    src = pkgs.fetchFromGitHub {
      owner = "safebucket";
      repo = "safebucket";
      rev = "fadc278092772c63d969e61dac72fedbee34ae53";
      sha256 = "sha256-COWHBODPY4g/B2eSWnPdHeIi7CvmfonPnVesmP7I7r8=";
    };

    vendorHash = "sha256-WKTZTi0mm8uTVOq7RjFapR79ylSF6iHkDtNcjBDhyjU=";

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
          npmDepsHash = "sha256-x4dgdMXEHhvB+2di+uHY/S/HMx4p901z9AnKvjfY3Rs=";
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

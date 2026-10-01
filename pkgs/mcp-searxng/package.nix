{
  buildNpmPackage,
  fetchFromGitHub,
  nix-update-script,
  lib,
}:
buildNpmPackage (finalAttrs: {
  pname = "mcp-searxng";
  version = "2.5.0";

  src = fetchFromGitHub {
    owner = "ihor-sokoliuk";
    repo = "mcp-searxng";
    rev = "v${finalAttrs.version}";
    hash = "sha256-yfxnYD1onNw5J6yLq2RxqAtlNnH319DWD1Zu3JM8eq0=";
  };

  npmDepsHash = "sha256-QhUqB/+R3BGwx8gH0MDn+PiMEtira3vZdosJj8oMsaI=";

  strictDeps = true;

  passthru = {
    updateScript = nix-update-script {
      extraArgs = [
        "--flake"
      ];
    };
  };

  meta = {
    mainProgram = "mcp-searxng";
    description = "MCP Server for SearXNG";
    homepage = "https://github.com/ihor-sokoliuk/mcp-searxng";
    changelog = "https://github.com/ihor-sokoliuk/mcp-searxng/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
})

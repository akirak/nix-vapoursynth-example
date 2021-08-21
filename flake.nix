{
  description = "Running vapoursynth with specific plugins installed";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  inputs.vapoursynth-plugins.url = "github:akirak/nix-vapoursynth-plugins";

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks, vapoursynth-plugins }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        plugins = pkgs.callPackage ./plugins.nix {
          inherit (vapoursynth-plugins.packages.${system}) vapoursynth-eedi3;
        };
      in
      rec {
        packages = flake-utils.lib.flattenTree {
          # The main package of this flake.
          vapoursynth = pkgs.callPackage ./wrapper.nix {
            inherit plugins;
          };
          # Provide the plugins as a separate derivation for debugging.
          vapoursynth-plugins = plugins;
        };
        defaultPackage = packages.vapoursynth;

        # Allow running the package using `nix run`.
        apps.vspipe = flake-utils.lib.mkApp {
          drv = packages.vapoursynth;
          name = "vapoursynth";
        };
        defaultApp = apps.vspipe;

        # Format and lint the code on a pre-commit hook.
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
            };
          };
        };
        devShell = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
        };
      }
    );
}

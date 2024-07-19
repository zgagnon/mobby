{
  description = "Mobby Basic Remote Mobbing Tool";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkg = pkgs.callPackage ./default.nix { };
      in {
        overlay.default = final: prev: {
          final.mobby = prev.callPackage ./default.nix { };
        };
        packages.default = pkg;
        devShells.default =
          pkgs.mkShell { buildInputs = with pkgs; [ argc nixfmt ]; };
      });
}

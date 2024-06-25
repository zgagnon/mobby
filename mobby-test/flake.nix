{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mobby-flake.url = "path:../.";
  flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, mobby-flake, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkg = pkgs.callPackage ../default.nix {};
      in{

        devShells.default = pkgs.mkShell { buildInputs = [ pkg]; };
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    });
}

{
  description = "Mobby Basic Remote Mobbing Tool";

  inputs = {
    naersk.url = "github:nix-community/naersk";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      naersk,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkg = pkgs.callPackage ./default.nix { };
        naersk' = pkgs.callPackage naersk {};
      in
      {
        overlay.default = final: prev: { final.mobby = prev.callPackage ./default.nix { }; };
        defaultPackage = naersk'.buildPackage {
          src = ./.;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            argc
            nixfmt-rfc-style
            just
            rustc
            cargo
            clang
            libiconv
            openssl
            darwin.apple_sdk.frameworks.Security
            darwin.apple_sdk.frameworks.SystemConfiguration
          ];

          shellHook = ''
            export OPENSSL_DIR="${pkgs.openssl.dev}"
            export OPENSSL_LIB_DIR="${pkgs.openssl.out}/lib"
            export OPENSSL_INCLUDE_DIR="${pkgs.openssl.dev}/include"
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.openssl ]}"
            export LIBRARY_PATH=$LIBRARY_PATH:${pkgs.darwin.apple_sdk.frameworks.Security}/Library/Frameworks
          '';
        };
      }
    );
}

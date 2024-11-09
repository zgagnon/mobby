{
  stdenv,
  pkgs,
  lib,
  fetchFromGithub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  name = "mobby";
  version = "2.0";
  src = ./.;

  cargoHash = "sha256-bHL2PqnuLnMfm8cVbXt6IlJKJR6jel4Pi3CKh6jUdR4";

  nativeBuildInputs = with pkgs; [
    openssl
    pkg-config
  ];
  buildInputs = with pkgs; [
    libgit2
    openssl
    libiconv
    openssl
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration

  ];

  build = ''
    export OPENSSL_DIR="${pkgs.openssl.dev}"
    export OPENSSL_LIB_DIR="${pkgs.openssl.out}/lib"
    export OPENSSL_INCLUDE_DIR="${pkgs.openssl.dev}/include"
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.openssl ]}"
    export LIBRARY_PATH=$LIBRARY_PATH:${pkgs.darwin.apple_sdk.frameworks.Security}/Library/Frameworks
    export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"

    cargo build
  '';
  meta = {
    description = "A fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = lib.licenses.unlicense;
    maintainers = [ ];
  };
}

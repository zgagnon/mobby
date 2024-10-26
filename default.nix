{ stdenv, pkgs }:
stdenv.mkDerivation {
  name = "mobby";
  src = ./.;
  buildInputs = [ pkgs.bun ];
  runtimeInputs = with pkgs; [ bun ];

  buildPhase = ''
    bun install
    bun build src/mobby.ts \
        --outdir ./build \
        --target bun \
        --entry-naming "[dir]/[name]"
  '';
  installPhase = ''
        mkdir -p $out/bin
        cp build/mobby $out/bin
    ls $out/bin
        chmod +x $out/bin/mobby
  '';
}

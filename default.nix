{ stdenv, pkgs }:
stdenv.mkDerivation {
  name = "mobby";
  src = ./.;
  buildInputs = [ pkgs.bun ];
  runtimeInputs = with pkgs; [ bun cowsay ];

  buildPhase = ''
    bun install
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp mobby.ts $out/bin/mobby
    cp package.json $out/bin
    cp -r node_modules $out/bin
    cp -r src $out/bin/src
    ls $out/bin
    chmod +x $out/bin/mobby
  '';
}

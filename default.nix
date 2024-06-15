{ stdenv, pkgs }:
stdenv.mkDerivation {
          pname = "mobby";
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = [ pkgs.cowsay ];
          buildInputs = [];
          installPhase = ''
            ls
            mkdir -p $out/bin
            cp ./mobby $out/bin/mobby
          '';
        }

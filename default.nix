{ stdenv, pkgs }:
pkgs.writeShellApplication {
          name = "mobby";
          runtimeInputs = [ pkgs.cowsay ];
          text = builtins.readFile ./mobby;
}

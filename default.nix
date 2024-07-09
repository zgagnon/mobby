{ stdenv, pkgs }:
pkgs.writeShellApplication {
          name = "mobby";
          runtimeInputs = with pkgs; [ cowsay argc ];

          text = builtins.readFile ./mobby;
}

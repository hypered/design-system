let
  pkgs = import <nixpkgs> {};
in
  pkgs.runCommand "example" {
    buildInputs = [
      pkgs.texlive.combined.scheme-full
    ];
    example = ./example.tex;
  } ''
    mkdir -p $out
    xelatex --jobname example --output-directory $out/ $example
  ''

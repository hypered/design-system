let
  pkgs = import <nixpkgs> {};
in
  pkgs.runCommand "example" {
    buildInputs = [
      pkgs.texlive.combined.scheme-full
    ];
    example = ./example.tex;
    fonts = ../docs/static/fonts;
  } ''
    mkdir -p $out
    cp $fonts/ibm-plex-*.ttf .
    xelatex --jobname example --output-directory $out/ $example
  ''

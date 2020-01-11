{ nixpkgs ? <nixpkgs>
}:
let
  pkgs = import nixpkgs { };
in
{
  example = pkgs.runCommand "example.html"
    {
      nativeBuildInputs = with pkgs; [
        buildPackages.libxml2.bin
        buildPackages.libxslt.bin
      ];
      meta.description = "XSLT example";
    }
    ''
      mkdir -p $out
      xsltproc \
        --nonet --output $out/example.html \
        ${./table.xsl} \
        ${./data.xml}
    '';
}

{ nixpkgs ? <nixpkgs>
}:
let
  pkgs = import nixpkgs {};
in rec
{
  template = pandoc/default.html;
  lua-filter = pandoc/tachyons.lua;
  to-prefixed-html = prefix: font: src: pkgs.runCommand "html" {} ''
    ${pkgs.pandoc}/bin/pandoc \
      --from markdown \
      --to html \
      --standalone \
      --template ${template} \
      -M prefix="${prefix}" \
      -M font="${font}" \
      --lua-filter ${lua-filter} \
      --output $out \
      ${src}
  '';
  to-html = src: to-prefixed-html "" "inter" src;
  replace-md-links = scripts/replace-md-links.sh;

  md.lua = pandoc/lua.md;

  docbook-example = (import docbook/default.nix {}).minimal;
  pandoc-example = to-html md.lua;

  app = (import ./release.nix).guide;
  site = (import site/default.nix {}).html.all;
  static = (import site/default.nix {}).static;
}

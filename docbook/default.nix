{ nixpkgs ? <nixpkgs>
}:
let
  pkgs = import nixpkgs { };
in rec
{
  toc = builtins.toFile "toc.xml"
    ''
      <toc role="chunk-toc">
        <d:tocentry xmlns:d="http://docbook.org/ns/docbook" linkend="minimal-example"><?dbhtml filename="index.html"?>
          <d:tocentry linkend="ch-options"><?dbhtml filename="options.html"?></d:tocentry>
          <d:tocentry linkend="ch-release-notes"><?dbhtml filename="release-notes.html"?></d:tocentry>
        </d:tocentry>
      </toc>
    '';

  manualXsltprocOptions = toString [
    "--param section.autolabel 1"
    "--param section.label.includes.component.label 1"
    "--stringparam html.stylesheet '/static/css/ibm-plex.css /static/css/tachyons.min.v4.11.1.css /static/css/styles.css'"
    "--param xref.with.number.and.title 1"
    "--param toc.section.depth 3"
    "--stringparam admon.style ''"
    "--stringparam callout.graphics.extension .svg"
    "--stringparam current.docid minimal-example"
    "--param chunk.section.depth 0"
    "--param chunk.first.sections 1"
    "--param use.id.as.filename 1"
    "--stringparam generate.toc 'book toc appendix toc'"
    "--stringparam chunk.toc ${toc}"
  ];

  # Stylesheet customization layer for the non-chunking dockbook.xsl stylesheet.
  # See http://www.sagehill.net/docbookxsl/OutputEncoding.html.
  docbook-utf8-xsl = pkgs.writeText "docbook-utf8.xsl"
    ''
      <?xml version='1.0'?>
      <xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                       xmlns:d="http://docbook.org/ns/docbook"
                       exclude-result-prefixes="d"
                       version="1.0">

        <xsl:import href="${pkgs.docbook_xsl_ns}/xml/xsl/docbook/html/docbook.xsl"/>
        <xsl:output method="html"
                    encoding="UTF-8"
                    indent="yes"/>

          <xsl:template match="*" mode="process.root">
            <xsl:variable name="doc" select="self::*"/>

            <xsl:call-template name="user.preroot"/>
            <xsl:call-template name="root.messages"/>

            <html>
              <xsl:call-template name="root.attributes"/>
              <head>
                <xsl:call-template name="system.head.content">
                  <xsl:with-param name="node" select="$doc"/>
                </xsl:call-template>
                <xsl:call-template name="head.content">
                  <xsl:with-param name="node" select="$doc"/>
                </xsl:call-template>
                <xsl:call-template name="user.head.content">
                  <xsl:with-param name="node" select="$doc"/>
                </xsl:call-template>
              </head>
              <body>
                <xsl:call-template name="body.attributes"/>
              <div class="ph3 mt2 mb4 f4 center main-mw">
                <xsl:call-template name="user.header.content">
                  <xsl:with-param name="node" select="$doc"/>
                </xsl:call-template>
                <xsl:apply-templates select="."/>
                <xsl:call-template name="user.footer.content">
                  <xsl:with-param name="node" select="$doc"/>
                </xsl:call-template>
              </div>
              </body>
            </html>
            <xsl:value-of select="$html.append"/>

            <!-- Generate any css files only once, not once per chunk -->
            <xsl:call-template name="generate.css.files"/>
          </xsl:template>

        <xsl:template name="user.head.content">
          <meta name="viewport">
            <xsl:attribute name="content">
              <xsl:value-of select="'width=device-width, initial-scale=1'"/>
            </xsl:attribute>
          </meta>
        </xsl:template>

        <xsl:template name="body.attributes">
          <xsl:attribute name="class">hy-ibm-plex</xsl:attribute>
        </xsl:template>

        <xsl:template match="d:para[@status = 'draft']" mode="class.value">
          <xsl:value-of select="'draft-chapter'"/>
        </xsl:template>

      </xsl:stylesheet>
    '';

  minimal = pkgs.runCommand "minimal.html"
    {
      nativeBuildInputs = with pkgs; [
        buildPackages.libxml2.bin
        buildPackages.libxslt.bin
      ];
      meta.description = "Minimal DocBook example";
    }
    ''
      mkdir -p $out
      xsltproc \
        ${manualXsltprocOptions} \
        --nonet --output $out/minimal.html \
        ${docbook-utf8-xsl} \
        ${./minimal.xml}
    '';
}

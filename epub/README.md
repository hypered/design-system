---
title: EPUB example
author: Võ Minh Thu
---


Pandoc can be used to create content in the EPUB format.


# Building

This file can be converted to EPUB with the following command:

```
$ pandoc -o README.epub README.md
```

When using, say, one file per chapter, multiple `.md` files can be given on the
command-line. Pandoc also accepts a YAML metadata block given as a separate
file.

Using the custom `epub.css` that uses the IBM Plex fonts:

```
$ pandoc --css epub.css \
  --epub-embed-font ../static/fonts/ibm-plex-mono.ttf \
  --epub-embed-font ../static/fonts/ibm-plex-sans-italic.ttf \
  --epub-embed-font ../static/fonts/ibm-plex-sans-semibold-italic.ttf \
  --epub-embed-font ../static/fonts/ibm-plex-sans-semibold.ttf \
  --epub-embed-font ../static/fonts/ibm-plex-sans.ttf \
  -o README.epub README.md
```

Note: a single `epub.css` file is used, althoug re-using the `--css` option to
also include `../static/css/ibm-plex.css` should work. There was a problem with
Pandoc re-using the same id in the generated EPUB file for multiple CSS. Maybe
it's gone.


# Pro Git


The documnetation of Pandoc shows how to render Pro Git:
https://pandoc.org/epub.html

The first edition of Pro Git used Markdown. The second edition uses Asciidoc.

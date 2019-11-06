# Learning DocBook.


The DocBook `.xsd` can be obtained with:

```
$ nix-build '<nixpkgs>' -A docbook5 --out-link docbook
$ ls docbook/share/xml/docbook-5.0/xsd/docbook.xsd
```

Building the minimal example in this directory can be done with:

```
$ nix-build -A docbook-example
```

Notes:

When following
http://www.sagehill.net/docbookxsl/HtmlCustomEx.html#CustomClassValues to add
custom CSS classes to the generated HTML, I had to declare the `d` namespace to
match e.g. `d:article` instead of `article`. This seems to be what is done
here: http://infohost.nmt.edu/~shipman/doc/doc5style/web/index.html. No idea
why it is not done that way in the Stayton book.

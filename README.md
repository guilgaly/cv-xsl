CV Guillaume Galy
=================

To build the html and pdf targets, run the `build` script

Requirements:
* `libxslt` (we use the `xsltproc` command)
* Apache `fop`

For ease of development, install `entr` and run it with `ls *.xml *.xsl *.css build | entr -c ./build`.

These scripts are based on the good work of Érdi Gergő: https://gergo.erdi.hu/projects/cv-xsl/. Any silly mistake would certainly be my own addition though. Thanks a lot Érdi for sharing those!

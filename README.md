CV Guillaume Galy
=================

To build the html and pdf targets, just execute the `build` script.

Requirements:
* libxslt (we use the `xsltproc` command): http://xmlsoft.org/libxslt/
* Apache FOP: https://xmlgraphics.apache.org/fop/

For ease of development, install entr(1) (http://entrproject.org/) and run it with `ls *.xml *.xsl *.css build | entr -c ./build`.

These scripts are based on the good work of Gergő Érdi: https://gergo.erdi.hu/projects/cv-xsl/. Any silly mistake would certainly be my own addition though. Thanks a lot Gergő for sharing those!

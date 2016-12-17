<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xml"
	      encoding="utf-8"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	      doctype-system="DTD/xhtml1-strict.dtd"
	      omit-xml-declaration="no"
	      indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="text-fullname">
      <xsl:if test="cv/data/name/title">
	<xsl:value-of select="cv/data/name/title"/>
	<xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="cv/data/name/firstname"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="cv/data/name/lastname"/>
    </xsl:variable>

    <xsl:variable name="text-cv">Curriculum vit&#xe6;</xsl:variable>
    
    <html>
      <head>
	<title><xsl:value-of select="$text-fullname"/> &#8211; <xsl:value-of select="$text-cv"/></title>
	<link rel="stylesheet" href="cv.css" />
       </head>
      <body>
	<div id="photo"><img src="/photo" alt="Photo"/></div>
	<h1 id="headline"><xsl:value-of select="$text-fullname"/></h1>

	<p>
	  You can <a href="cv.pdf">download a PDF</a> of this CV, ready for printing.
	  <a href="http://cactus.rulez.org/projects/cv-xsl/">Read how it was made</a>.
	</p>
	
	<table width="100%">
	  <xsl:apply-templates/>
	</table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="data"/>
  
  <xsl:template match="section">
    <tbody>
      <xsl:apply-templates/>
    </tbody>
  </xsl:template>
  
  <xsl:template match="section/title">    
    <tr>
      <th class="h1" colspan="2">
	<xsl:apply-templates/>
      </th>
    </tr>
  </xsl:template>

  <xsl:template match="subsection/title">
    <tr>
      <th class="h2" colspan="2">
	<xsl:apply-templates/>
      </th>
    </tr>
  </xsl:template>

  <xsl:template match="section/desc">
    <tr>
      <td colspan="2">
	<xsl:apply-templates/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="subsection/desc">
    <tr>
      <td colspan="2">
	<xsl:apply-templates/>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="section/item|subsection/item">
    <tr>
      <td class="title" valign="top"><xsl:apply-templates select="title"/></td>
      <td valign="top"><xsl:apply-templates select="desc"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="list">
    <tr>
      <td colspan="2">
	<ul><xsl:apply-templates/></ul>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="list/item">
    <li><xsl:apply-templates/></li>
  </xsl:template>
  
  <xsl:template match="a">
    <a href="{@href}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="prod">
    <cite><xsl:apply-templates/></cite>
  </xsl:template>

  <xsl:template match="p">
    <p><xsl:apply-templates/></p>
  </xsl:template>
  
</xsl:stylesheet>

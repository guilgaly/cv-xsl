<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:output method="xml" encoding="utf-8"
      omit-xml-declaration="no" indent="yes"/>

  <xsl:param name="base-size" select="9"/> <!-- in points -->
  <xsl:param name="headline-size" select="1.8 * $base-size"/>
  <xsl:param name="section-size" select="1.4 * $base-size"/>
  <xsl:param name="subsection-size" select="1.2 * $base-size"/>
  <xsl:param name="text-size" select="1.0 * $base-size"/>
  <xsl:param name="footer-size" select="0.9 * $base-size"/>
  
  <xsl:param name="item-indent" select="3"/> <!-- in milimeters -->
  <xsl:param name="item-spacing" select="1"/> <!-- in milimeters -->
  <xsl:param name="margin-horiz" select="25"/>
  <xsl:param name="margin-vert" select="15"/>

  <xsl:variable name="margin-left" select="$margin-horiz - $item-indent"/>
  <xsl:variable name="margin-right" select="$margin-horiz + $item-indent"/>
  <xsl:variable name="margin-top" select="$margin-vert"/>
  <xsl:variable name="margin-bottom" select="$margin-vert + 10"/>
  
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

    <xsl:variable name="text-cv">Curriculum Vit&#xe6;</xsl:variable>
  
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4"
            page-height="29.7cm" page-width="21cm">
          <fo:region-body margin-left="{$margin-left}mm"
              margin-right="{$margin-right}mm"
              margin-top="{$margin-top}mm"
              margin-bottom="{$margin-bottom}mm"/>
          <fo:region-after extent="{$margin-vert + 5}mm" />
        </fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="A4" font-family="Times">

        <fo:static-content flow-name="xsl-region-after">
          <fo:block margin-left="{$margin-left}mm"
              margin-right="{$margin-right}mm"
              font-size="{$footer-size}pt"
              text-align-last="justify">
            <xsl:value-of select="$text-cv"/> de <xsl:value-of select="$text-fullname"/>
            <fo:leader leader-pattern="space" />&#8211;<fo:leader leader-pattern="space" />
            Page <fo:page-number />
            <fo:leader leader-pattern="space" />&#8211;<fo:leader leader-pattern="space" />
            Code source : <fo:inline font-family="Courier"><xsl:value-of select="/cv/@uri"/></fo:inline>
          </fo:block>      
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <fo:block font-size="{$headline-size}pt" font-weight="bold" width="100%"
              text-align="center" margin-bottom="2mm">
            <xsl:value-of select="$text-fullname"/>
          </fo:block>
          <!--
          <xsl:variable name="photo-width" select="128"/>
          <xsl:variable name="photo-height" select="150"/>
          <xsl:variable name="photo-scale" select="0.22"/>
          
          <fo:block-container position="absolute"
                      left="{210 - 2 * $margin-horiz - $photo-scale * $photo-width}mm"
                      top="23mm"
                      width="{$photo-scale * $photo-width}mm"
                      height="{$photo-scale * $photo-height}mm"
                      border-width="0.5pt" border-style="solid" border-color="black">
            <fo:block>
              <fo:external-graphic src="http://www.cactus/photo"
                       width="{$photo-scale * $photo-width}mm"
                       height="{$photo-scale * $photo-height}mm"/>
            </fo:block>
          </fo:block-container>
          -->
          <xsl:apply-templates/>
          <!--
          <fo:block space-before="5mm" font-size="{$text-size}pt">
            Voir
              <fo:inline font-family="Courier" font-weight="bold"><xsl:value-of select="/cv/@uri"/></fo:inline>
            pour consulter les sources de ce CV, généré à l'aide de libxslt 
            (<fo:inline font-family="Courier">http://xmlsoft.org/libxslt</fo:inline>) 
            et Apache FOP 
            (<fo:inline font-family="Courier">https://xmlgraphics.apache.org/fop/</fo:inline>).
          </fo:block>
          -->
        </fo:flow>

      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="data"/>

  <xsl:template match="section|subsection">
    <fo:table table-layout="fixed" width="100%">
      <fo:table-column column-number="1" column-width="100%" />
      <fo:table-body>
        <fo:table-row keep-with-next="always">
          <fo:table-cell>
            <xsl:apply-templates select="title"/>
          </fo:table-cell>
        </fo:table-row>
        <fo:table-row>
          <fo:table-cell>
            <xsl:apply-templates select="*[2]"/>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    <xsl:apply-templates select="*[position() > 2]"/>
  </xsl:template>
  
  <xsl:template match="section/title">
    <fo:block font-size="{$section-size}pt" font-weight="bold"
        border-bottom-width=".8pt" border-color="black" border-bottom-style="solid"
        keep-with-next.within-page="always" margin-bottom="2mm" padding-bottom="1mm"
        margin-top="2mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="subsection/title">
    <fo:block font-size="{$subsection-size}pt" font-weight="bold"
        border-bottom-width=".8pt" border-color="rgb(210,210,210)" border-bottom-style="solid"
        keep-with-next.within-page="always" margin-bottom="2mm" padding-bottom="1mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="section/desc|subsection/desc">
    <fo:block margin-left="{$item-indent}mm" text-align="justify" font-size="{$text-size}pt">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="prod">
    <fo:inline font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
  
  <xsl:template match="item/title">
    <fo:block text-align="start" font-style="italic">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="item/desc">
    <fo:block text-align="justify">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="section/item|subsection/item">
    <fo:block font-size="{$text-size}pt">
      <fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="30mm"/>
        <fo:table-column column-width="{210 - 2 * $margin-horiz - 30}mm" />
        <fo:table-body start-indent="{$item-indent}mm">
          <fo:table-row keep-together="always">
            <fo:table-cell padding-bottom="{$item-spacing}mm"
                keep-together.within-column="always">
              <xsl:apply-templates select="title"/>
            </fo:table-cell>
            <fo:table-cell padding-bottom="{$item-spacing}mm" padding-left="2mm"
                keep-together.within-column="always">
              <fo:block text-align="justify">
                <xsl:apply-templates select="desc"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>      
  </xsl:template>

  <xsl:template match="list/item">
    <fo:list-item>
      <fo:list-item-label start-indent="{$item-indent}mm">
        <fo:block>&#x2022;</fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="{$item-indent*2}mm">
        <fo:block><xsl:apply-templates/></fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>
      

  <xsl:template match="list">
    <fo:list-block font-size="{$text-size}pt">
      <xsl:apply-templates/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="p">
    <fo:block space-after="{$item-spacing}mm">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
    
</xsl:stylesheet>

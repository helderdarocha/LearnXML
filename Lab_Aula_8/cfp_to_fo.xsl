<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <!-- Para imprimir comentários passe o parametro draft=any para o processador -->
    <xsl:param name="draft" />
    
    <xsl:output method="xml" encoding="iso-8859-1" />
    
    <xsl:attribute-set name="all-style">
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="color">rgb(20,20, 40)</xsl:attribute>
        <xsl:attribute name="space-before">10px</xsl:attribute>
        <xsl:attribute name="space-after">10px</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="p1"
                       margin-top="1.5cm" margin-bottom="2cm"
                       margin-left="2.5cm" margin-right="1.5cm"
                       page-width="21cm" page-height="29.7cm">
                    <fo:region-body margin-top="1.7cm"
                                    margin-bottom="1.7cm"/>
                    <fo:region-before extent="1.5cm" />
                    <fo:region-after extent="1.5cm" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-name="p1">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="7pt" text-align="end"
                              border-bottom-width="1px"
                              border-bottom-style="solid"
                              border-bottom-color="rgb(0,0,80)">
                        <xsl:value-of select="/document/head/title-line[2]" />
                        <xsl:text> - </xsl:text>
                        <xsl:value-of select="/document/head/title-line[1]" />
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-size="7pt" text-align="end"
                              border-top-width="1px"
                              border-top-style="solid"
                              border-top-color="rgb(0,0,80)">
                        Página <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Ignore elementos <comment> -->
    <xsl:template match="comment" />
    
    <xsl:template match="document">
        <xsl:apply-templates select="head" />
        <xsl:apply-templates select="section" />
    </xsl:template>
    
    <xsl:template match="head">
        <fo:block font-size="18pt" color="rgb(20, 80, 80)" xsl:use-attribute-sets="all-style">
        <xsl:value-of select="title-line[1]" /></fo:block>
        <fo:block font-size="16pt" color="rgb(20, 80, 80)" xsl:use-attribute-sets="all-style">
        <xsl:value-of select="title-line[2]" /></fo:block>
        <fo:list-block>
        <xsl:for-each select="/document/section">
            <fo:list-item>
                <xsl:call-template name="bullet" />
                <fo:list-item-body start-indent="10pt" xsl:use-attribute-sets="all-style">
                    <fo:block>
                        <fo:basic-link  internal-destination="{@name}"
                                        text-decoration="underline"
                                        color="gray">
                            <xsl:value-of select="@title"/>
                        </fo:basic-link>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </xsl:for-each>
        </fo:list-block>
    </xsl:template>
    
    <xsl:template match="section">
      <fo:block id="{@name}">
        <fo:block font-size="16pt" color="rgb(20, 80, 80)" xsl:use-attribute-sets="all-style">
        <xsl:value-of select="@title" /></fo:block>
        <xsl:apply-templates />
      </fo:block>
    </xsl:template>
    
    <xsl:template match="list">
        <fo:block  xsl:use-attribute-sets="all-style">
          <fo:list-block><xsl:apply-templates /></fo:list-block>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="deadline | item | topic">
        <fo:list-item>
            <xsl:call-template name="bullet" />
            <fo:list-item-body start-indent="20pt">
                <fo:block>
                    <xsl:apply-templates />
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="p">
        <fo:block xsl:use-attribute-sets="all-style"><xsl:apply-templates /></fo:block>
    </xsl:template>
    
    <xsl:template match="date">
        <xsl:text>: </xsl:text><xsl:value-of select="." />
    </xsl:template>
    
    <xsl:template match="a">
        <fo:basic-link  external-destination="{@href}"
                        text-decoration="underline"
                        color="gray">
            <xsl:value-of select="."/>
        </fo:basic-link>
    </xsl:template>
    
    <xsl:template match="b">
        <fo:inline font-weight="bold">
        <xsl:value-of select="." /></fo:inline>
    </xsl:template>
    
    <xsl:template match="i">
        <fo:inline font-style="italic">
        <xsl:value-of select="." /></fo:inline>
    </xsl:template>
    
    <xsl:template name="bullet">
        <fo:list-item-label>
            <fo:block font-size="10pt" color="blue">
                <xsl:text>&#x2022;</xsl:text>
            </fo:block>
        </fo:list-item-label>
    </xsl:template>

</xsl:stylesheet>

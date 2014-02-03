<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:strip-space elements="*"/>
    <xsl:decimal-format decimal-separator="," grouping-separator="."/>
    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css">
                    h1, h2, h3 {font-family: calibri, sans-serif; margin: 0pt; padding: 0pt; font-weight: normal}
                    blockquote {margin-top: 0pt; margin-bottom: 0pt}
                    h1 {font-size: 15pt; color: navy}
                    h2 {font-size: 13pt; color: black}
                    h3 {font-size: 11pt; color: maroon}
                    body {-webkit-column-count: 4; -webkit-column-gap: 1em; -webkit-column-rule: 1px solid black;
                          -moz-column-count: 4; -moz-column-gap: 1em; -moz-column-rule: 1px solid black;
                          column-count: 4; column-gap: 1em; column-rule: 1px solid black;}
                </style>
            </head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="orbita">
        <h1><xsl:number count="orbita" level="multiple" format="1. "/>Orbita de raio <xsl:value-of select="format-number(@raioMedUA, '0,00#')" /> UA</h1>
        <blockquote><xsl:apply-templates /></blockquote>
    </xsl:template>
    <xsl:template match="planeta|asteroide">
        <h2><xsl:number count="orbita|planeta|asteroide" level="multiple" format="1.1. "/><xsl:value-of select="@nome"/></h2>
        <blockquote><xsl:apply-templates /></blockquote>
    </xsl:template>
    <xsl:template match="satelite">
        <h3><xsl:number count="orbita|planeta|satelite" level="multiple" format="1.1.1. "/><xsl:value-of select="@nome"/></h3>
        <xsl:apply-templates />
    </xsl:template>
</xsl:stylesheet>
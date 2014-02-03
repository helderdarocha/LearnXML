<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />

    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="sistemaEstelar">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="centro">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="orbita">
        <h3 style="border-top: solid black 1px">
        <xsl:value-of select="@raioMedUA" /><xsl:text> UA</xsl:text>
        </h3>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="planeta">
        <p><b><xsl:value-of select="@nome" /></b></p>
        <ol>
        <xsl:apply-templates />
        </ol>
    </xsl:template>
    
    <xsl:template match="asteroide">
        <p style="margin: 0px">
        <xsl:value-of select="@nome" />
        (asteróide)</p>
    </xsl:template>
    
    <xsl:template match="estrela">
        <h1><xsl:value-of select="@nome" /></h1>
    </xsl:template>
    
    <xsl:template match="satelite">
        <li><xsl:value-of select="@nome" /></li>
    </xsl:template>

</xsl:stylesheet>

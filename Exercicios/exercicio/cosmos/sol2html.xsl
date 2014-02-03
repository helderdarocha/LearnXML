<?xml version="1.0" encoding="iso-8859-1" ?>

<!--
Este arquivo contém apenas o esqueleto de uma folha de transformação XSLT.
Substitua o conteúdo dos templates ou remova-os e faça da maneira que achar mais fácil.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="planeta">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="asteroide">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="estrela">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="satelite">
        <xsl:apply-templates />
    </xsl:template>

</xsl:stylesheet>

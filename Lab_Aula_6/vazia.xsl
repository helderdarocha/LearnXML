<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:template match="*[@*]">
        <xsl:value-of select="@*"/>
        <xsl:text>: </xsl:text>
        <xsl:value-of select="nome"/>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="text()">
    </xsl:template>
    
    <xsl:template match="comment() | processing-instruction()"></xsl:template>
    
    <xsl:template match="/">
        <html><xsl:apply-templates /></html>
    </xsl:template>
    
    <xsl:template match="biblioteca">
        <body><xsl:apply-templates /></body>
    </xsl:template>
    
    <xsl:template match="*">
        <z><xsl:apply-templates /></z>
    </xsl:template>
    
</xsl:stylesheet>
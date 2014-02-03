<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="biblioteca">
        <ul><xsl:apply-templates select="livros"/></ul>
        
        <ul><xsl:apply-templates select="pessoas/pessoa">
            <xsl:sort select="nome"/>
        </xsl:apply-templates></ul>
        
    </xsl:template>
    
    <xsl:template match="pessoa">
        <li><xsl:value-of select="nome"/></li>
    </xsl:template>
    
    <xsl:template match="livros">
        <xsl:for-each select="livro">
            <xsl:sort select="titulo" />
            <li><xsl:value-of select="titulo"/></li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="*" />

</xsl:stylesheet>
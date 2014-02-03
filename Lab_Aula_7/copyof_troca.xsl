<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="pessoas">
        <people>
            <xsl:apply-templates />
        </people>
    </xsl:template>
    
    <xsl:template match="pessoa">
        <person>
            <xsl:copy-of select="child::node()"/>
        </person>
    </xsl:template>
    
    <xsl:template match="livros">
        <books>
            <xsl:apply-templates />
        </books>
    </xsl:template>
    
    <xsl:template match="livro">
        <book>
            <xsl:copy-of select="child::node()"/>
        </book>
    </xsl:template>
    
    <xsl:template match="/">
        <library>
            <xsl:apply-templates select="biblioteca/pessoas"/>
            <xsl:apply-templates select="biblioteca/livros"/>
        </library>
    </xsl:template>
    
</xsl:stylesheet>
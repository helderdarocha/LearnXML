<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="biblioteca"/>
    
    <xsl:template match="/ | * | @* | processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text() | comment() | processing-instruction()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="pessoa">
        <person>
            <xsl:apply-templates />
        </person>
    </xsl:template>
    
    <xsl:template match="comment()">
        <comentario>
            <xsl:value-of select="." />
        </comentario>
    </xsl:template>
    
</xsl:stylesheet>
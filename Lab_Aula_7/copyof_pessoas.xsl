<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="pessoas">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:apply-templates select="biblioteca/pessoas"/>
    </xsl:template>
    
</xsl:stylesheet>
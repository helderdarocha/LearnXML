<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:decimal-format decimal-separator="," grouping-separator="." />
    
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="sistemaEstelar">
        <ol>
            <xsl:for-each select="//*[@diametrokm]">
                <xsl:sort select="@diametrokm" data-type="number" order="descending"/>
                <xsl:if test="position() &lt;= 30">
                    <li><b><xsl:value-of select="@nome"/></b> (diametro: <xsl:value-of select="@diametrokm"/>km)</li>
                </xsl:if>
            </xsl:for-each>
        </ol>
    </xsl:template>
    
 
    
</xsl:stylesheet>
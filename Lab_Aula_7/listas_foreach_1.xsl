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
    
    <xsl:template match="sistemaEstelar">
        <ul>
            <xsl:for-each select="orbita[planeta]">
                <xsl:sort select="planeta/@diametrokm" data-type="number"/>
                <li><xsl:value-of select="planeta/@nome"/> (diametro: <xsl:value-of select="planeta/@diametrokm"/>km)</li>
                <xsl:if test="planeta/satelite">
                    <ul>
                        <xsl:for-each select="planeta/satelite">
                            <xsl:sort select="@raioMedOrbitakm" data-type="number"/>
                            <li><xsl:value-of select="@nome"/> (raio da orbita: <xsl:value-of select="@raioMedOrbitakm"/>km)</li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
</xsl:stylesheet>
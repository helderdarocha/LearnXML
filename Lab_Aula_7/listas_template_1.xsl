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
            <xsl:apply-templates select="orbita[planeta]">
                <xsl:sort select="planeta/@diametrokm" data-type="number"/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>
    
    <xsl:template match="planeta">
        <li><xsl:value-of select="@nome"/> (diametro: <xsl:value-of select="@diametrokm"/>km)</li>
        <ul>
            <xsl:apply-templates select="satelite">
                <xsl:sort select="@raioMedOrbitakm" data-type="number"/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>
    
    <xsl:template match="satelite">
        <li><xsl:value-of select="@nome"/> (raio da orbita: <xsl:value-of select="@raioMedOrbitakm"/>km)</li>
    </xsl:template>

    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:import href="defaults.xsl"/>
    
    <xsl:template match="sistemaEstelar">
        <ul>
        <xsl:for-each select="orbita/planeta">
            <li><a href="#{generate-id(.)}"><xsl:value-of select="@nome"/></a></li>
        </xsl:for-each>
        </ul>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="orbita/planeta">
        <p></p><table border="1">
            <tr><th><a name="{generate-id(.)}"></a><xsl:value-of select="@nome" /></th></tr>
            <xsl:apply-templates />
        </table>
    </xsl:template>
    
    <xsl:template match="satelite">
        <tr><td><xsl:number value="position()" format="1. "/><xsl:value-of select="@nome"/></td></tr>
    </xsl:template>
    
</xsl:stylesheet>
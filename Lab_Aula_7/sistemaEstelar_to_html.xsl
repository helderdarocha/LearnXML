<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="sistemaEstelar">
        <xsl:for-each select="orbita">
            <xsl:number format="1" value="."/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="planeta/@nome"/>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
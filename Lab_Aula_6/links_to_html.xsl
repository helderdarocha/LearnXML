<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="html"
    indent="yes"></xsl:output>
    
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="links">
        <h1>Links</h1>
        <xsl:element name="{@elemento}">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="link">
        <li><a href="{@ref}">
            <xsl:value-of select="."/></a></li>
    </xsl:template>

</xsl:stylesheet>
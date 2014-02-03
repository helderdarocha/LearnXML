<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>
    
    <xsl:template match="/">
        <body>
            <table border='1'>
        <xsl:apply-templates select="/personnel/person"/>
            </table>
        </body>
    </xsl:template>
    
    <xsl:template match="person">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="email">
    </xsl:template>
    
    <xsl:template match="name">
        <tr><td>Pessoa: <xsl:value-of select="given"/>
            <xsl:text> </xsl:text>            
            <xsl:value-of select="family"/></td></tr>
    </xsl:template>
</xsl:stylesheet>

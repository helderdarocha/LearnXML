<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:import href="couthures_trig.xsl"/>
    <!-- To be applied on TestSin.xml -->
    
    <xsl:output method="html"/>
    
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <h1>sin, cos and tan test</h1>
                <table border="1">
                    <tr><th>x</th><th>deg</th><th>sin(x)</th><th>cos(x)</th></tr>
                    <xsl:apply-templates></xsl:apply-templates>
                </table>
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="x">
        <tr><td><xsl:value-of select="." /></td>
            <td><xsl:value-of select="90 * ." /></td>
            <td>
                <xsl:call-template name="sin">
                    <xsl:with-param name="x" select=".*$pi div 2"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="cos">
                    <xsl:with-param name="x" select=".*$pi div 2"/>
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
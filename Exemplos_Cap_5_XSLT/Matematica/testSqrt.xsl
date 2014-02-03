<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:import href="couthures_math.xsl"/>
    <!-- To be applied on TestSin.xml -->
    
    <xsl:output method="html"/>
    
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <h1>Sqrt test</h1>
                <table border="1">
                    <tr><th>x</th><th>x * x</th><th>sqrt(x)</th><th>sqrt(x*x)</th></tr>
                    <xsl:apply-templates />
                </table>
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="x">
        <tr><td><xsl:value-of select="(.) * 10" /></td>
            <td>
                <xsl:value-of select="(.) * 10 * (.) * 10"/>
            </td>
            <td>
                <xsl:call-template name="sqrt">
                    <xsl:with-param name="x" select="(.) * 10"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="sqrt">
                    <xsl:with-param name="x" select="(.) * 10 * (.) * 10"/>
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
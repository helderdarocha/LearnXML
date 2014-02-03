<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/TR/xhtml1/strict">
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Expense Report Summary</title>
            </head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="report">
        <div><xsl:apply-templates /></div>
    </xsl:template>
    
    <xsl:template match="total">
        <p>Total Amount: <xsl:value-of select="."/></p>
    </xsl:template>
    
</xsl:stylesheet>
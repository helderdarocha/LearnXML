<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:import href="timeformat.xsl"/>
    
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="intervalos">
        <ul><xsl:apply-templates /></ul>
    </xsl:template>
    
    <xsl:template match="intervalo[@segundos]">
        <li><xsl:value-of select="@segundos"/>s = 
            <xsl:call-template name="formatTime">
                <xsl:with-param name="seconds"><xsl:value-of select="@segundos"/></xsl:with-param>
            </xsl:call-template>
        </li>
    </xsl:template>
    
    <xsl:template match="intervalo[@horario]">
        <li><xsl:value-of select="@horario"/> = 
            <xsl:call-template name="normalizeTime">
                <xsl:with-param name="timeString"><xsl:value-of select="@horario"/></xsl:with-param>
            </xsl:call-template>s
        </li>
    </xsl:template>
    
</xsl:stylesheet>
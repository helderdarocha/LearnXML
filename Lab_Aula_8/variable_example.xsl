<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:template match="sistemaEstelar">
        <xsl:variable name="raio">
            <xsl:for-each select="orbita">
                <xsl:if test="@raio &gt;= $raio">
                    <xsl:value-of select="@raio"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <p>O maior raio: <xsl:value-of select="$raio"/></p>
        
        <xsl:variable name="mensagem">
            <xsl:if test="@xml:lang['pt']">
                <xsl:value-of select="/mensagens/portugues"/>
            </xsl:if>
            <xsl:if test="@xml:lang['en']">
                <xsl:value-of select="/mensagens/ingles"/>
            </xsl:if>
        </xsl:variable>
    </xsl:template>

</xsl:stylesheet>
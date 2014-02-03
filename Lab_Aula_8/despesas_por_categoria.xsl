<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="defaults.xsl"/>
    <xsl:key name="despesas_por_tipo" match="despesa" use="@tipo"/>
    
    <xsl:template match="despesas">
        <xsl:variable name="key_taxi" select="key('despesas_por_tipo', periodo/despesa/@tipo[. = 'taxi'])" />
        <xsl:variable name="key_alim" select="key('despesas_por_tipo', periodo/despesa/@tipo[. = 'alimentacao'])" />
        
        <h1>Despesas com taxi</h1>
        <ul>
            <xsl:for-each select="$key_taxi">
                <xsl:sort select="." data-type="number" order="descending"/>
                <li><xsl:value-of select="format-number(../@dia, '00')"/>/<xsl:value-of select="format-number(../../../@mes, '00')"/>/<xsl:value-of select="format-number(../../../@ano, '0000')"/>: 
                    R$ <xsl:value-of select="format-number(., '###,00')"/></li>
            </xsl:for-each>
        </ul>
        <p>Total: R$ <xsl:value-of select="format-number(sum($key_taxi), '###,00')"/></p>

        <h1>Despesas com alimentacao</h1>
        <ul>
            <xsl:for-each select="$key_alim">
                <xsl:sort select="." data-type="number" order="descending"/>
                <li>R$ <xsl:value-of select="format-number(., '###,00')"/></li>
            </xsl:for-each>
        </ul>
        <p>Total: R$ <xsl:value-of select="format-number(sum($key_alim), '###,00')"/></p>
    </xsl:template>
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="defaults.xsl"/>
    <xsl:key name="despesas_por_tipo" match="despesa" use="@tipo"/>
    
    <xsl:template match="despesas">
        <xsl:for-each select="periodo/despesa[generate-id(.) = generate-id(key('despesas_por_tipo', @tipo)[1])]">
            <xsl:sort select="@tipo"/>
            <h1>Despesas com <xsl:value-of select="@tipo"/></h1>
            <ul>
                <xsl:for-each select="key('despesas_por_tipo', @tipo)">
                    <xsl:sort select="." data-type="number" order="descending"/>
                    <li>R$ <xsl:value-of select="format-number(., '###,00')"/></li>
                </xsl:for-each>
            </ul>
            <p>Total: R$ <xsl:value-of select="format-number(sum(key('despesas_por_tipo', @tipo)), '###,00')"/></p>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
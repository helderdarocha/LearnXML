<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="text"/>

    <xsl:template match="aeronave">
        <xsl:text></xsl:text><![CDATA[<body><div>]]>
<xsl:text>A aeronave de prefixo </xsl:text>
            <xsl:value-of select="@id" /> decolou<xsl:text>
</xsl:text>de <xsl:value-of select="origem" />
        <xsl:text> às </xsl:text>            
        <xsl:value-of select="origem/@partida" />
<xsl:text> tendo como 
destino o aeroporto de </xsl:text>
        <xsl:value-of select="destino" /><xsl:text>.</xsl:text>
        <xsl:text>
<![CDATA[</div></body>]]></xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
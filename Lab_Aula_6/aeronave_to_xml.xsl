<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="xml"
                encoding="iso-8859-1"
                doctype-system="aeronave.dtd" 
                indent="yes" />

    <xsl:template match="aeronave">
        <body><div>
        <p><xsl:text>A aeronave de prefixo </xsl:text>
        <xsl:value-of select="@id" /> decolou 
        de <xsl:value-of select="origem" />
        <xsl:text> às </xsl:text>            
        <xsl:value-of select="origem/@partida" />
        tendo como destino o aeroporto de
        <xsl:value-of select="destino" />.</p>
        </div></body>
    </xsl:template>
    
</xsl:stylesheet>
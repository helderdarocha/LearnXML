<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="intervalo">
        <xsl:variable name="segundos" select="@millis div 1000"  />
        
        <xsl:variable name="formatado">
            <xsl:variable name="tmpHora" select="$segundos div 3600" />
            <xsl:variable name="hora"    select="floor($tmpHora)" />
            <xsl:variable name="tmpMin"  select="($tmpHora - $hora) * 60" />
            <xsl:variable name="minuto"  select="floor($tmpMin)" />
            <xsl:variable name="segundo" select="floor( ($tmpMin - $minuto) * 60)" />
            <xsl:value-of select="concat(format-number($hora, '00'), 
                                        ':',
                                        format-number($minuto, '00'), 
                                        ':', 
                                        format-number($segundo, '00'))" />
        </xsl:variable>
        
        <p>Duração: <xsl:value-of select="$formatado" /></p>
    </xsl:template>
    
    
</xsl:stylesheet>
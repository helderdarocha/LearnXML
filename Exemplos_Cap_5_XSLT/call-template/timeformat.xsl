<?xml version="1.0" encoding="iso-8859-1" ?>

<!-- Simple time formatting utilities. helder@argonavis.com.br -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <!-- *
         * Recebe tempo no formato hh:mm:ss e retorna tempo em segundos 
         * -->  
    <xsl:template name="normalizeTime">
        <xsl:param name="timeString" /> <!-- hh:mm:ss -->

        <!-- hh -->
        <xsl:variable name="hora" select="substring-before($timeString, ':')" />
        <!-- mm:ss -->
        <xsl:variable name="tmpMinSec" select="substring-after($timeString, ':')" />
        <!-- mm -->
        <xsl:variable name="minuto" select="substring-before($tmpMinSec, ':')" />
        <!-- ss -->
        <xsl:variable name="segundo" select="substring-after($tmpMinSec, ':')" />
        
        <!-- Normaliza tudo em segundos - este é o valor retornado -->
        <xsl:value-of select="$hora * 3600 + $minuto * 60 + $segundo" />
    </xsl:template>
    
    <!-- *
         * Recebe tempo em segundos e retorna tempo em formato hh:mm:ss 
         * -->  
    <xsl:template name="formatTime">
        <xsl:param name="seconds" />
        
        <!-- Esta variável transforma tempo em segundos em tempo formatado hh:mm:ss -->
        <xsl:variable name="formattedTime">
            <xsl:variable name="tmpHora" select="$seconds div 3600" />
            <xsl:variable name="hora" select="floor($tmpHora)" />
            <xsl:variable name="tmpMin" select="($tmpHora - $hora) * 60" />
            <xsl:variable name="minuto" select="floor($tmpMin)" />
            <xsl:variable name="segundo" select="floor( ($tmpMin - $minuto) * 60)" />
            <xsl:value-of select="concat(format-number($hora, '00'), ':', 
                                         format-number($minuto, '00'), ':', 
                                         format-number($segundo, '00'))" />
        </xsl:variable>
        
        <!-- Este é o valor retornado -->
        <xsl:value-of select="$formattedTime" />
    </xsl:template>
</xsl:stylesheet>

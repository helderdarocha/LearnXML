<?xml version="1.0" encoding="iso-8859-1" ?>

<!-- Templates para operacoes de data e hora. helder@argonavis.com.br -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="calcula-minutos">
        <xsl:param name="total" select="0" />
        <xsl:param name="position" select="1" />
        <xsl:message>
            <xsl:value-of select="$total" />
        </xsl:message>
        <xsl:variable name="result">
            <xsl:choose>
                <xsl:when test="$position &lt;= count(//servicos/periodo)">
                    <xsl:call-template name="calcula-minutos">
                        <xsl:with-param name="total" select="$total + (((//servicos/periodo[$position]/fim/@hora * 60) + //servicos/periodo[$position]/fim/@minuto) - ((//servicos/periodo[$position]/inicio/@hora * 60) + //servicos/periodo[$position]/inicio/@minuto))" />
                        <xsl:with-param name="position" select="$position + 1" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$total" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$result" />
    </xsl:template>
    
    <xsl:template name="calcula-subtotal">
        <xsl:param name="inicio"/> <!-- tempo em minutos -->
        <xsl:param name="fim"/>
        <xsl:variable name="total" select="$fim - $inicio" />
        <xsl:variable name="horas" select="floor($total div 60)" />
        <xsl:variable name="minutos" select="$total - ($horas * 60)" />
        <xsl:value-of select="concat(format-number($horas, '00'), ':', format-number($minutos, '00'))" />
    </xsl:template>
</xsl:stylesheet>

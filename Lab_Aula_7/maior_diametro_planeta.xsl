<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="sistemaEstelar">
        <xsl:variable name="planetaMaiorDiametro">
            <xsl:call-template name="calcularMaiorDiametro">
                <xsl:with-param name="planeta" select="orbita/planeta" />
                <xsl:with-param name="maiorDiametro" select="0" />
                <xsl:with-param name="posicao" select="1" />
            </xsl:call-template>
        </xsl:variable>
        
        <p>Planeta de maior diametro: <xsl:value-of select="$planetaMaiorDiametro"/></p>
    </xsl:template>
    
    <xsl:template name="calcularMaiorDiametro">
        <xsl:param name="planeta" />
        <xsl:param name="maiorDiametro" />
        <xsl:param name="posicao" />
        <xsl:param name="posicaoMaiorDiametro" select="0" />
        <xsl:choose>
            <xsl:when test="$posicao > count($planeta)">
                <xsl:value-of select="$planeta[$posicaoMaiorDiametro]/@nome"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$planeta[$posicao]/@diametrokm > $maiorDiametro">
                        <xsl:call-template name="calcularMaiorDiametro">
                            <xsl:with-param name="planeta" select="$planeta" />
                            <xsl:with-param name="maiorDiametro" select="$planeta[$posicao]/@diametrokm" />
                            <xsl:with-param name="posicaoMaiorDiametro" select="$posicao" />
                            <xsl:with-param name="posicao" select="$posicao + 1" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="calcularMaiorDiametro">
                            <xsl:with-param name="planeta" select="$planeta" />
                            <xsl:with-param name="maiorDiametro" select="$maiorDiametro" />
                            <xsl:with-param name="posicaoMaiorDiametro" select="$posicaoMaiorDiametro" />
                            <xsl:with-param name="posicao" select="$posicao + 1" />
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
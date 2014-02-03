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
        
        <xsl:variable name="sateliteMaiorDiametro">
            <xsl:call-template name="calcularMaiorDiametro">
                <xsl:with-param name="satelite" select="orbita/planeta/satelite" />
            </xsl:call-template>
        </xsl:variable>
        
        <p>Satelite de maior diametro: <xsl:value-of select="$sateliteMaiorDiametro"/></p>
    </xsl:template>
    
    <xsl:template name="calcularMaiorDiametro">
        <xsl:param name="satelite" />
        <xsl:param name="maiorDiametro" select="0" />
        <xsl:param name="posicao" select="1" />
        <xsl:param name="posicaoMaiorDiametro" select="0" />
        <xsl:choose>
            <xsl:when test="$posicao > count($satelite)">
                <xsl:value-of select="$satelite[$posicaoMaiorDiametro]/@nome"/> (satelite de <xsl:value-of select="$satelite[$posicaoMaiorDiametro]/../@nome"/>)
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$satelite[$posicao]/@diametrokm > $maiorDiametro">
                        <xsl:call-template name="calcularMaiorDiametro">
                            <xsl:with-param name="satelite" select="$satelite" />
                            <xsl:with-param name="maiorDiametro" select="$satelite[$posicao]/@diametrokm" />
                            <xsl:with-param name="posicaoMaiorDiametro" select="$posicao" />
                            <xsl:with-param name="posicao" select="$posicao + 1" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="calcularMaiorDiametro">
                            <xsl:with-param name="satelite" select="$satelite" />
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
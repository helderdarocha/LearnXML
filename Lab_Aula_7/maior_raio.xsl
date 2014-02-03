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
        <xsl:variable name="planetaMaiorOrbita">
            <xsl:call-template name="calcularMaiorOrbita">
                <xsl:with-param name="orbita" select="orbita[planeta]" />
                <xsl:with-param name="maiorOrbita" select="0" />
                <xsl:with-param name="posicao" select="1" />
            </xsl:call-template>
        </xsl:variable>
        
        <p>Planeta de maior orbita: <xsl:value-of select="$planetaMaiorOrbita"/></p>
    </xsl:template>
    
    <xsl:template name="calcularMaiorOrbita">
        <xsl:param name="orbita" />
        <xsl:param name="maiorOrbita" />
        <xsl:param name="posicao" />
        <xsl:param name="posicaoMaiorOrbita" select="0" />
        <xsl:choose>
            <xsl:when test="$posicao > count($orbita)">
                <xsl:value-of select="$orbita[$posicaoMaiorOrbita]/planeta/@nome"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$orbita[$posicao]/@raioMedUA > $maiorOrbita">
                        <xsl:call-template name="calcularMaiorOrbita">
                            <xsl:with-param name="orbita" select="$orbita" />
                            <xsl:with-param name="maiorOrbita" select="$orbita[$posicao]/@raioMedUA" />
                            <xsl:with-param name="posicaoMaiorOrbita" select="$posicao" />
                            <xsl:with-param name="posicao" select="$posicao + 1" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="calcularMaiorOrbita">
                            <xsl:with-param name="orbita" select="$orbita" />
                            <xsl:with-param name="maiorOrbita" select="$maiorOrbita" />
                            <xsl:with-param name="posicaoMaiorOrbita" select="$posicaoMaiorOrbita" />
                            <xsl:with-param name="posicao" select="$posicao + 1" />
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
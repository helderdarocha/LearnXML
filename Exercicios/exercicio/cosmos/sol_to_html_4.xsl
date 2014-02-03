<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="iso-8859-1" method="html" />
    <xsl:template match="/">
        <ul>
        <xsl:for-each select="//orbita/planeta">
            <li><a href="#{@id}"><xsl:value-of select="@nome"/></a></li>
        </xsl:for-each>
        </ul>
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="asteroide" >
        <p style="margin: 0px">
        <xsl:value-of select="@nome" /></p>
    </xsl:template>
    <xsl:template match="satelite" >
        <li><xsl:value-of select="@nome" /></li>
    </xsl:template>
    
    <xsl:template match="planeta" >
        <a name="{@id}"></a>
        <xsl:call-template name="imagem">
            <xsl:with-param name="url" select="imagem/@href" />
        </xsl:call-template>
        <p><b><xsl:value-of select="@nome" /></b></p>
        <ol><xsl:apply-templates select="satelite" /></ol>
    </xsl:template>
    
    <xsl:template name="imagem">
        <xsl:param name="url" />
        <img src="{$url}" />
    </xsl:template>
    
    <xsl:template match="orbita">
        <h3 style="border-top: solid black 1px">
        <xsl:value-of select="raioMedUA" /> UA</h3>
        <xsl:apply-templates />
    </xsl:template>
</xsl:stylesheet>

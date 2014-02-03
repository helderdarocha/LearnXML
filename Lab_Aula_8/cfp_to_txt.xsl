<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:strip-space elements="*" />

    <xsl:variable name="newline">
        <xsl:text>
</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="hr">
        <xsl:value-of select="$newline" />
        <xsl:text>-------------------------------------</xsl:text>
        <xsl:value-of select="$newline" />
    </xsl:variable>

    <xsl:output method="text" encoding="iso-8859-1" />

    <xsl:template match="/">
        <xsl:value-of select="$hr" />
        Inclua cabeçalho opcional aqui - esta página foi gerada a partir de XML. Faça as alterações
        no documento cfp_to_txt.xsl ou xpbrasil_cfp.xml.
        <xsl:value-of select="$hr" />
        
        <xsl:apply-templates />
        
        <xsl:value-of select="$hr" />
        Inclua rodapé opcional aqui
        <xsl:value-of select="$hr" />
     </xsl:template>
    
    <!-- Comentarios serão ignorados -->
    <xsl:template match="comment" />
    
    <xsl:template match="document">
        <xsl:apply-templates select="head" />
        <xsl:apply-templates select="section" />
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:value-of select="title-line[1]" />
        <xsl:value-of select="$newline" />
        <xsl:value-of select="$newline" />
        <xsl:value-of select="title-line[2]" />
        <xsl:value-of select="$newline" />
    </xsl:template>
    
    <xsl:template match="section">
        <xsl:if test="position() != 1">
            <xsl:text>### </xsl:text>
        </xsl:if>
        <xsl:value-of select="@title" />
        <xsl:value-of select="$newline" />
        <xsl:apply-templates />
        <xsl:value-of select="$newline" />
        <xsl:value-of select="$newline" />
    </xsl:template>
    
    <xsl:template match="list">
        <xsl:value-of select="$newline" />
        <xsl:apply-templates />
        <xsl:value-of select="$newline" />
    </xsl:template>
    
    <xsl:template match="deadline | item | topic">
        <xsl:value-of select="$newline" />
        <xsl:text>   * </xsl:text><xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:value-of select="$newline" />
        <xsl:apply-templates />
        <xsl:value-of select="$newline" />
    </xsl:template>
    
    <xsl:template match="a | b | i">
        <xsl:text> </xsl:text><xsl:value-of select="." /><xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="date">
        <xsl:text>: </xsl:text><xsl:value-of select="." />
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)" />
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Para imprimir comentários passe o parametro draft=any para o processador -->
    <xsl:param name="draft" />
    
    <xsl:output method="html" encoding="iso-8859-1" doctype-public="-//W3C//DTD HTML 4.0 Transitional//EN" />

    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="/document/head/title-line[2]" />
                <xsl:text> - </xsl:text>
                <xsl:value-of select="/document/head/title-line[1]" /></title>
                <link href="cfp.css" rel="stylesheet" type="text/css" />
            </head>
        
            <body><div class="all">
                <hr/>Inclua cabeçalho aqui - esta página foi gerada a partir de XML. Faça as alterações
                no documento cfp_to_html.xsl ou xpbrasil_cfp.xml. Altere o estilo em cfp.css.<hr/>
                <xsl:apply-templates />
                <hr/>Inclua rodapé aqui<hr/>
            </div></body>
        </html>

    </xsl:template>
    
    <!-- Se for passado parametro "draft" para processador XSLT, comentarios serão impressos -->
    <xsl:template match="comment">
        <xsl:if test="$draft">
            <b style="color: red"><xsl:value-of select="." /></b>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="document">
        <xsl:apply-templates select="head" />
        <xsl:apply-templates select="section" />
    </xsl:template>
    
    <xsl:template match="head">
        <h1><xsl:value-of select="title-line[1]" /></h1>
        <h2><xsl:value-of select="title-line[2]" /></h2>
        <ul>
        <xsl:for-each select="/document/section">
            <xsl:if test="position() != 1">
                <li><a href="#{@name}"><xsl:value-of select="@title" /></a></li>
            </xsl:if>
        </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="section">
        <div id="{@name}">
        <a name="{@name}"></a>
        <h3><xsl:value-of select="@title" /></h3>
        <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="list">
        <ul>
            <xsl:apply-templates />
        </ul>
    </xsl:template>
    
    <xsl:template match="deadline | item | topic">
        <li><xsl:apply-templates /></li>
    </xsl:template>
    
    <xsl:template match="p">
        <p><xsl:apply-templates /></p>
    </xsl:template>
    
    <xsl:template match="date">
        <xsl:text>: </xsl:text><xsl:value-of select="." />
    </xsl:template>
    
    <xsl:template match="a | b | i">
        <xsl:copy-of select="." />
    </xsl:template>

</xsl:stylesheet>

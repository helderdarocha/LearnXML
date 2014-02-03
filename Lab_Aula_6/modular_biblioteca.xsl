<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="pessoa">
        <tr><td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="nome"/></td></tr>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="livro[position() mod 2 = 0]">
        <tr class='par'><td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="titulo"/></td></tr>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="livro[position() mod 2 != 0]">
        <tr class='impar'><td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="titulo"/></td></tr>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="text()"></xsl:template>
    
    <xsl:template match="comment() | processing-instruction()"></xsl:template>
    
    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css">
                    .par   {background-color: rgb(100%,90%,90%)}
                    .impar {background-color: rgb(90%,90%,100%)}
                </style>
            </head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="biblioteca">
        <body><xsl:apply-templates /></body>
    </xsl:template>
    
    <xsl:template match="livros">
        <h1>Livros</h1>
        <table border="1"><xsl:apply-templates /></table>
    </xsl:template>
    
    <xsl:template match="pessoas">
        <h1>Autores</h1>
        <table border="1"><xsl:apply-templates /></table>
    </xsl:template>
    
    <xsl:template match="*"></xsl:template>
    
</xsl:stylesheet>
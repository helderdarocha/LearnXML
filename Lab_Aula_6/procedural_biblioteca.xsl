<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css">
                    .par   {background-color: rgb(100%,90%,90%)}
                    .impar {background-color: rgb(90%,90%,100%)}
                </style>
            </head>
            <body>
                    <h1>Autores</h1>
                    <table border="1">
                        <xsl:for-each select="biblioteca/pessoas/pessoa">
                            <tr><td><xsl:value-of select="@id"/></td>
                                <td><xsl:value-of select="nome"/></td></tr>
                        </xsl:for-each>
                    </table>
                    <h1>Livros</h1>
                <table border="1">
                    <xsl:for-each select="biblioteca/livros/livro">
                        <xsl:if test="livro[position() mod 2 = 0]">
                            <tr class="par">
                                <td>
                                    <xsl:value-of select="@id"/>
                                </td>
                                <td>
                                    <xsl:value-of select="titulo"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="livro[position() mod 2 != 0]">
                            <tr class="impar">
                                <td>
                                    <xsl:value-of select="@id"/>
                                </td>
                                <td>
                                    <xsl:value-of select="titulo"/>
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
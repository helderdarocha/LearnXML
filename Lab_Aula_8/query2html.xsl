<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Templates para fazer calculos com data e hora -->
    <xsl:import href="timecalc.xsl" />
    
    <!-- Templates de formatação de hora segundo para hh:mm:ss e vice-versa -->
    <xsl:import href="timeformat.xsl" />
    
    <xsl:output encoding="iso-8859-1" method="html" indent="yes" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <html>
          <head><title>Tabela</title>
          </head>
          <body>
            <h1>Extrato de uso de servicos de streaming</h1>
            <xsl:apply-templates />
          </body>
        </html>
    </xsl:template>
    
    <xsl:template match="query">
        <table border="1">
            <xsl:apply-templates />
        </table>
        
        <!-- Variável que contem a duração total -->
        <xsl:variable name="duracaoTotal">
            <!-- Esta variável contém a duração total convertida em em segundos -->
            <xsl:variable name="totalDuracao">
                <!-- Chama template local que calcula a duração total em segundos -->
                <xsl:call-template name="calcularTotal">
                    <xsl:with-param name="camposDuracao" select="row/value[@field='duracao']" />
                </xsl:call-template>
            </xsl:variable>
            <!-- Chama template importado para formatar o total de segundos para hh:mm:ss -->
            <xsl:call-template name="formatTime">
                <xsl:with-param name="seconds" select="$totalDuracao" />
            </xsl:call-template>
        </xsl:variable>
        
        <p>Duração total: <xsl:value-of select="$duracaoTotal" /><xsl:text> h
</xsl:text>
        <br/>Valor total: <xsl:value-of select="sum(row/value[@field='valor'])" /></p>
    </xsl:template>
    
    <xsl:template match="row">
        <tr><xsl:apply-templates /></tr>
    </xsl:template>
    
    <xsl:template match="value">
        <td><xsl:apply-templates /></td>
    </xsl:template>


   
</xsl:stylesheet>

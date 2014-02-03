<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Coloquei as fun��es de formata��o de hora segundo para hh:mm:ss e vice-versa
         em arquivo separado para melhor reutiliza��o -->
    <xsl:import href="timeformat.xsl" />
    
    <xsl:output encoding="iso-8859-1" method="html" indent="yes" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <html>
          <head><title>Tabela</title>
          </head>
          <body>
            <h1>Tabela</h1>
            <xsl:apply-templates />
          </body>
        </html>
    </xsl:template>
    
    <xsl:template match="query">
        <table border="1">
            <xsl:apply-templates />
        </table>
        
        <!-- Vari�vel que contem a dura��o total -->
        <xsl:variable name="duracaoTotal">
            <!-- Esta vari�vel cont�m a dura��o total convertida em em segundos -->
            <xsl:variable name="totalDuracao">
                <!-- Chama template local que calcula a dura��o total em segundos -->
                <xsl:call-template name="calcularTotal">
                    <xsl:with-param name="camposDuracao" select="row/value[@field='duracao']" />
                </xsl:call-template>
            </xsl:variable>
            <!-- Chama template importado para formatar o total de segundos para hh:mm:ss -->
            <xsl:call-template name="formatTime">
                <xsl:with-param name="seconds" select="$totalDuracao" />
            </xsl:call-template>
        </xsl:variable>
        
        <p>Dura��o total: <xsl:value-of select="$duracaoTotal" /><xsl:text> h
</xsl:text>
        <br/>Valor total: <xsl:value-of select="sum(row/value[@field='valor'])" /></p>
    </xsl:template>
    
    <xsl:template match="row">
        <tr><xsl:apply-templates /></tr>
    </xsl:template>
    
    <xsl:template match="value">
        <td><xsl:apply-templates /></td>
    </xsl:template>

    <!-- ********************** Templates reutiliz�veis ******************* -->
    <!-- *
         * Recebe um node-set contendo horas no formato hh:mm:ss e produz soma
         * em segundos
         * -->
    <xsl:template name="calcularTotal">
        <xsl:param name="campos" /> 
        <xsl:param name="valorInicial" select="0" />
        <xsl:param name="contador" select="1" />
        
        <!-- Debugging: imprime o valor do n� processado nesta recurs�o -->
        <xsl:message><xsl:value-of select="$valores[$contador]"/></xsl:message>
        
        <!-- Esta vari�vel cont�m o valor em segundos do per�odo a ser adicionado -->
        <xsl:variable name="segundos">
            <!-- Chama template importado do arquivo timeformat.xsl para
                 transformar valor hh:mm:ss em segundos -->
            <xsl:call-template name="normalizeTime">
                <xsl:with-param name="timeString" select="$valores[$contador]" />
            </xsl:call-template>
        </xsl:variable>
        
        <!-- Esta vari�vel cont�m o valor total acumulado at� o momento -->
        <xsl:variable name="totalSegundos">
            <xsl:choose>
                <!-- Se este for o �ltimo, devolva a soma do valor inicial + segundos -->
                <xsl:when test="$campos[$contador = last()]">
                    <xsl:value-of select="$valorInicial + $segundos" />
                </xsl:when>
                <!-- Caso contr�rio, passe o total como valor inicial, incremente o
                     contador e chame este template novamente com novos parametros -->
                <xsl:otherwise>
                    <xsl:call-template name="calcularTotal">
                        <xsl:with-param name="campos" select="$campos" />
                        <xsl:with-param name="contador" select="$contador + 1" />
                        <xsl:with-param name="valorInicial" select="$valorInicial + $segundos" />
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- A dura��o total em segundos � retornada aqui -->
        <xsl:value-of select="$totalSegundos"/>
    </xsl:template>
   
</xsl:stylesheet>

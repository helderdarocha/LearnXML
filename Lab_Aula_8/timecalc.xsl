<?xml version="1.0" encoding="iso-8859-1" ?>

<!-- Simple time formatting utilities. helder@argonavis.com.br -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Templates de formatação de hora segundo para hh:mm:ss e vice-versa -->
    <xsl:import href="timeformat.xsl" />
    
    <!-- *
        * Recebe um node-set contendo horas no formato hh:mm:ss e produz soma
        * em segundos
        * -->
    <xsl:template name="calcularTotal">
        <xsl:param name="camposDuracao" /> 
        <xsl:param name="valorInicial" select="0" />
        <xsl:param name="contador" select="1" />
        
        <!-- Debugging: imprime o valor do nó processado nesta recursão -->
        <xsl:message><xsl:value-of select="$camposDuracao[$contador]"/></xsl:message>
        
        <!-- Esta variável contém o valor em segundos do período a ser adicionado -->
        <xsl:variable name="segundos">
            <!-- Chama template importado do arquivo timeformat.xsl para
                transformar valor hh:mm:ss em segundos -->
            <xsl:call-template name="normalizeTime">
                <xsl:with-param name="timeString" select="$camposDuracao[$contador]" />
            </xsl:call-template>
        </xsl:variable>
        
        <!-- Esta variável contém o valor total acumulado até o momento -->
        <xsl:variable name="totalSegundos">
            <xsl:choose>
                <!-- Se este for o último, devolva a soma do valor inicial + segundos -->
                <xsl:when test="$camposDuracao[$contador = last()]">
                    <xsl:value-of select="$valorInicial + $segundos" />
                </xsl:when>
                <!-- Caso contrário, passe o total como valor inicial, incremente o
                    contador e chame este template novamente com novos parametros -->
                <xsl:otherwise>
                    <xsl:call-template name="calcularTotal">
                        <xsl:with-param name="camposDuracao" select="$camposDuracao" />
                        <xsl:with-param name="contador" select="$contador + 1" />
                        <xsl:with-param name="valorInicial" select="$valorInicial + $segundos" />
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- A duração total em segundos é retornada aqui -->
        <xsl:value-of select="$totalSegundos"/>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Templates para fazer calculos com data e hora -->
    <xsl:import href="utildatahora.xsl" />

    <xsl:output encoding="iso-8859-1" method="html" indent="yes"/>
    <xsl:strip-space elements="*" />
    <xsl:preserve-space elements="style script pre code" />
    
    <xsl:decimal-format decimal-separator="," grouping-separator="." />
    
    <xsl:param name="consultor">[Inclua nome do consultor]</xsl:param>
    <xsl:param name="valorhora">151.00</xsl:param>
    
    <xsl:variable name="titulo">Relatório de serviços prestados</xsl:variable>
    <xsl:variable name="logotipo">argologo.gif</xsl:variable>
    <xsl:variable name="css">relatorio2_css.xml</xsl:variable>

    <xsl:template match="/">
        <html>
            <head><title>Argo Navis - <xsl:value-of select="$titulo"/></title>
                <xsl:copy-of select="document($css)"/>
            </head>
            <body>
                <img src="{$logotipo}" />
                <h2><xsl:value-of select="$titulo"/></h2>
                <p>Referente à nota fiscal: <b>00<xsl:value-of select="/servico-de-consultoria/referente/@nota" /></b>
                de <b><xsl:value-of select="/servico-de-consultoria/referente/@data" /></b>
                </p>
                <p><b>Contratante: </b>
                <xsl:value-of select="/servico-de-consultoria/contratante" /><br/>
                <b>Descrição dos serviços:</b> <xsl:value-of select="/servico-de-consultoria/descricao" /></p>
                <xsl:apply-templates />
                <p>* Notas-fiscais e recibos em anexo</p>
                <p style="margin-top: 48pt">São Paulo, <xsl:value-of select="/servico-de-consultoria/referente/@data" /></p>
                <p style="margin-top: 24pt"><xsl:value-of select="$consultor" /></p>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="despesa">
        <xsl:variable name="color">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 0">
                    rgb(200,200,255)
                </xsl:when>
                <xsl:otherwise>
                    rgb(230,230,255)
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tr style="background-color: {$color}">
            <td><xsl:value-of select="ancestor::periodo/@dia" />-<xsl:value-of select="ancestor::periodo/@mes" />-<xsl:value-of select="ancestor::periodo/@ano" /></td>
            <td><xsl:value-of select="@tipo" /></td>
            <td><xsl:value-of select="@numero" /></td>
            <td style="text-align: right"><xsl:value-of select="." /></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="despesas">
        <h3>2. Despesas reembolsáveis conforme contrato</h3>
        <table border="0" width="450" cellpadding="0" cellspacing="0">
          <tr><th>Data</th><th>Descrição</th><th>No. doct.</th><th style="text-align: right">Valor (R$)</th></tr>
          <xsl:apply-templates select="periodo/despesa" />
          <tr><th><xsl:value-of select="/servico-de-consultoria/referente/@data" /></th><th>Valor total</th><th></th><th style="text-align: right">R$ <xsl:value-of select="format-number(sum(periodo/despesa), '#,00')" /></th></tr>
        </table>
    </xsl:template>
    
    <xsl:template match="servicos/periodo">
        <xsl:variable name="color">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 0">
                    rgb(200,200,255)
                </xsl:when>
                <xsl:otherwise>
                    rgb(230,230,255)
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tr style="background-color: {$color}">
            <td><xsl:value-of select="ancestor-or-self::periodo/@dia" />-<xsl:value-of select="ancestor-or-self::periodo/@mes" />-<xsl:value-of select="ancestor-or-self::periodo/@ano" /></td>
            <td><xsl:value-of select="format-number(inicio/@hora, '00')" />:<xsl:value-of select="format-number(inicio/@minuto, '00')" /></td>
            <td><xsl:value-of select="format-number(fim/@hora, '00')" />:<xsl:value-of select="format-number(fim/@minuto, '00')" /></td>
            <xsl:variable name="total">
                <xsl:call-template name="calcula-subtotal">
                    <xsl:with-param name="inicio" select="(inicio/@hora * 60) + inicio/@minuto" />
                    <xsl:with-param name="fim" select="(fim/@hora * 60) + fim/@minuto" />
                </xsl:call-template>
            </xsl:variable>
            <td style="text-align: right"><xsl:value-of select="$total" /></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="servicos">
        <h3>1. Descrição dos serviços prestados</h3>
        <table border="0" width="450" cellpadding="0" cellspacing="0">
          <tr><th>Data</th><th>Início</th><th>Fim</th><th>Horas</th></tr>
          <xsl:apply-templates select="periodo" />
          <xsl:variable name="total">
            <xsl:call-template name="calcula-minutos" />
          </xsl:variable>
          <xsl:variable name="horas" select="floor($total div 60)" />
          <xsl:variable name="minutos" select="$total - ($horas * 60)" />
          <tr><th><xsl:value-of select="/servico-de-consultoria/referente/@data" /></th><th>Total de horas</th><th></th><th style="text-align: right"><xsl:value-of select="concat(format-number($horas, '00'), ':', format-number($minutos, '00'))" /> h</th></tr>
          <tr><th> </th><th>Valor total (horas cheias) </th><th></th><th style="text-align: right">R$ <xsl:value-of select="format-number( ($horas * $valorhora), '####,00')" /></th></tr>
        </table>
    </xsl:template>
     
    <xsl:template match="descricao | contratante" />
    
    <xsl:template match="periodo">
        <xsl:apply-templates />
    </xsl:template>
    


</xsl:stylesheet>

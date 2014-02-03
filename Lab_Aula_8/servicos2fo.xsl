<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:output encoding="iso-8859-1" method="xml"/>
    <xsl:decimal-format decimal-separator="," grouping-separator="." />
    
    <xsl:attribute-set name="p">
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="space-before">0.5mm</xsl:attribute>
        <xsl:attribute name="space-after">0.2mm</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="table">
        <xsl:attribute name="border">solid 1px rgb(200,200,200)</xsl:attribute>
        <xsl:attribute name="padding">1px</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h1">
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">18pt</xsl:attribute>
        <xsl:attribute name="space-after">24pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="h3">
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">18pt</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template match="/">
            
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="p1"
                       margin-top="1.5cm" margin-bottom="2cm"
                       margin-left="2.5cm" margin-right="1.5cm"
                       page-width="21cm" page-height="29.7cm">
                    <fo:region-body margin-top="1.7cm"
                                    margin-bottom="1.7cm"/>
                    <fo:region-before extent="1.5cm" />
                    <fo:region-after extent="1.5cm" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-name="p1">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="7pt" text-align="end"
                              border-bottom-width="1px"
                              border-bottom-style="solid"
                              border-bottom-color="rgb(0,0,80)">
                              <fo:external-graphic src="argologo.gif" width="77.2mm" height="11.8mm" />
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-size="7pt" text-align="end"
                              border-top-width="1px"
                              border-top-style="solid"
                              border-top-color="rgb(0,0,80)">
                        Página <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="servico-de-consultoria">
        <fo:block xsl:use-attribute-sets="p" space-before="48pt">
            <fo:block xsl:use-attribute-sets="h1">Relatório de serviços prestados (ref. à nota fiscal: <fo:inline font-weight="bold">00<xsl:value-of select="/servico-de-consultoria/referente/@nota" /></fo:inline>)
            de <fo:inline><xsl:value-of select="/servico-de-consultoria/referente/@data" /></fo:inline>
            </fo:block>
            <fo:block><fo:inline font-weight="bold">Contratante: </fo:inline>
            <xsl:value-of select="/servico-de-consultoria/contratante" /></fo:block>
            <fo:block><fo:inline font-weight="bold">Descrição dos serviços:</fo:inline> <xsl:value-of select="/servico-de-consultoria/descricao" /></fo:block>
            <xsl:apply-templates />
            <fo:block space-before="10pt">* Notas-fiscais e recibos em anexo</fo:block>
            <fo:block space-before="48pt">São Paulo, <xsl:value-of select="/servico-de-consultoria/referente/@data" /></fo:block>
            <fo:block space-before="24pt">Helder L. S. da Rocha</fo:block>
        </fo:block>
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
        <fo:table-row background-color="{$color}">
            <fo:table-cell><fo:block><xsl:value-of select="ancestor::periodo/@dia" />-<xsl:value-of select="ancestor::periodo/@mes" />-<xsl:value-of select="ancestor::periodo/@ano" /></fo:block></fo:table-cell>
            <fo:table-cell><fo:block><xsl:value-of select="@tipo" /></fo:block></fo:table-cell>
            <fo:table-cell><fo:block><xsl:value-of select="@numero" /></fo:block></fo:table-cell>
            <fo:table-cell text-align="end"><fo:block><xsl:value-of select="." /></fo:block></fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="despesas">
        <fo:block xsl:use-attribute-sets="h3">2. Despesas reembolsáveis conforme contrato</fo:block>
        <fo:table xsl:use-attribute-sets="p" border-width="1px" border-style="solid" border-color="rgb(220,220,220)" padding="1mm">
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="40mm"/>
          <fo:table-header font-weight="bold">
          <fo:table-row><fo:table-cell><fo:block>Data</fo:block></fo:table-cell><fo:table-cell><fo:block>Descrição</fo:block></fo:table-cell>
          <fo:table-cell><fo:block>No. doct.</fo:block></fo:table-cell>
          <fo:table-cell text-align="end"><fo:block>Valor (R$)</fo:block></fo:table-cell></fo:table-row>
          </fo:table-header>
          <fo:table-body>
          <xsl:apply-templates select="periodo/despesa" />
          <fo:table-row font-weight="bold"><fo:table-cell><fo:block><xsl:value-of select="/servico-de-consultoria/referente/@data" /></fo:block></fo:table-cell>
          <fo:table-cell><fo:block>Valor total</fo:block></fo:table-cell><fo:table-cell><fo:block></fo:block></fo:table-cell>
          <fo:table-cell text-align="end"><fo:block>R$ <xsl:value-of select="format-number(sum(periodo/despesa), '#,00')" /></fo:block></fo:table-cell></fo:table-row>
          </fo:table-body>
        </fo:table>
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
        <fo:table-row background-color="{$color}">
            <fo:table-cell><fo:block><xsl:value-of select="ancestor-or-self::periodo/@dia" />-<xsl:value-of select="ancestor-or-self::periodo/@mes" />-<xsl:value-of select="ancestor-or-self::periodo/@ano" /></fo:block></fo:table-cell>
            <fo:table-cell><fo:block><xsl:value-of select="format-number(inicio/@hora, '00')" />:<xsl:value-of select="format-number(inicio/@minuto, '00')" /></fo:block></fo:table-cell>
            <fo:table-cell><fo:block><xsl:value-of select="format-number(fim/@hora, '00')" />:<xsl:value-of select="format-number(fim/@minuto, '00')" /></fo:block></fo:table-cell>
            <xsl:variable name="total">
                <xsl:call-template name="calcula-subtotal">
                    <xsl:with-param name="inicio" select="(inicio/@hora * 60) + inicio/@minuto" />
                    <xsl:with-param name="fim" select="(fim/@hora * 60) + fim/@minuto" />
                </xsl:call-template>
            </xsl:variable>
            <fo:table-cell text-align="end"><fo:block><xsl:value-of select="$total" /></fo:block></fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="servicos">
        <fo:block xsl:use-attribute-sets="h3">1. Descrição dos serviços prestados</fo:block>
        <fo:table xsl:use-attribute-sets="p" border-width="1px" border-style="solid" border-color="rgb(220,220,220)" padding="1mm">
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="40mm"/>

          <fo:table-header font-weight="bold">
          <fo:table-row><fo:table-cell><fo:block>Data</fo:block></fo:table-cell><fo:table-cell><fo:block>Início</fo:block></fo:table-cell><fo:table-cell><fo:block>Fim</fo:block></fo:table-cell><fo:table-cell text-align="end"><fo:block>Horas</fo:block></fo:table-cell></fo:table-row>
          </fo:table-header>
          <fo:table-body>
          <xsl:apply-templates select="periodo" />
          <xsl:variable name="total">
            <xsl:call-template name="calcula-minutos" />
          </xsl:variable>
          <xsl:variable name="horas" select="floor($total div 60)" />
          <xsl:variable name="minutos" select="$total - ($horas * 60)" />
          <fo:table-row><fo:table-cell><fo:block><xsl:value-of select="/servico-de-consultoria/referente/@data" /></fo:block></fo:table-cell><fo:table-cell><fo:block>Total de horas</fo:block></fo:table-cell><fo:table-cell><fo:block></fo:block></fo:table-cell>
          <fo:table-cell text-align="end"><fo:block><xsl:value-of select="concat(format-number($horas, '00'), ':', format-number($minutos, '00'))" /> h</fo:block></fo:table-cell></fo:table-row>
          <fo:table-row font-weight="bold"><fo:table-cell><fo:block> </fo:block></fo:table-cell><fo:table-cell><fo:block>Valor total (horas cheias) </fo:block></fo:table-cell><fo:table-cell><fo:block></fo:block></fo:table-cell>
          <fo:table-cell text-align="end"><fo:block>R$ <xsl:value-of select="format-number( ($horas * 100), '####,00')" /></fo:block></fo:table-cell></fo:table-row>
          </fo:table-body>
        </fo:table>
    </xsl:template>
     
    <xsl:template match="descricao | contratante" />
    
    <xsl:template match="periodo">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template name="calcula-minutos">
        <xsl:param name="total" select="0" />
        <xsl:param name="position" select="1" />
        <xsl:message>
            <xsl:value-of select="$total" />
        </xsl:message>
        <xsl:variable name="result">
            <xsl:choose>
                <xsl:when test="$position &lt;= count(//servicos/periodo)">
                    <xsl:call-template name="calcula-minutos">
                        <xsl:with-param name="total" select="$total + (((//servicos/periodo[$position]/fim/@hora * 60) + //servicos/periodo[$position]/fim/@minuto) - ((//servicos/periodo[$position]/inicio/@hora * 60) + //servicos/periodo[$position]/inicio/@minuto))" />
                        <xsl:with-param name="position" select="$position + 1" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$total" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$result" />
    </xsl:template>
    
    <xsl:template name="calcula-subtotal">
        <xsl:param name="inicio"/> <!-- tempo em minutos -->
        <xsl:param name="fim"/>
        <xsl:variable name="total" select="$fim - $inicio" />
        <xsl:variable name="horas" select="floor($total div 60)" />
        <xsl:variable name="minutos" select="$total - ($horas * 60)" />
        <xsl:value-of select="concat(format-number($horas, '00'), ':', format-number($minutos, '00'))" />
    </xsl:template>

</xsl:stylesheet>

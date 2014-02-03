<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:svg="http://www.w3.org/2000/svg">
    
    <!-- Creditos para este exemplo:
        - Codigo do grafico de barras: http://blog.trivadis.com/blogs/andreasmengel/archive/2008/03/14/generating-svg-pie-charts-in-pdf-documents.aspx
        - Bibliotecas de seno e cosseno: Alain Couthures (membro da lista xsl-dev)
        
        O outro exemplo usa bibliotecas do Xalan. Usar bibliotecas (extensoes) nao eh necessariamente ruim,
        mas limita o uso da folha de estilos a ambientes onde as extensoes podem ser usadas, e voce necessariamente
        precisa usar o processador (Xalan, Saxon. etc.) que fornece as extensoes que voce esta usando.
        Extensoes nao funcionam em browsers e de forma *nativa* nos ambientes Windows, Linux e Mac. Se voce usa
        o Saxon ou o Xalan via linha de comando ou via Java/C#/PHP, em servidores Web, etc. pode usar XSLT 2.0 ou extensoes. Existem
        extensoes de matematica tanto para o Xalan (nativo do Java) como para o Saxon. Veja o outro exemplo
        que usa extensoes do Xalan.
        
        Extensoes sao importantes tambem quando se necessita de mais precisao ou performance, mas nem sempre as funcoes das extensoes 
        sao mais rapidas ou mais precisas. Extensoes do Xalan e Saxon para seno e cosseno podem ser mais lentas que estas.
        
        Em XSLT 1.1 em diante, e processadores Java pode-se usar xlmns:math="java.lang.Math" e acessar qualquer funcao do pacote Math do
        Java atraves do prefixo. Ex: math:sin() ou math:random()
        
        -->
    
    <xsl:import href="../Matematica/couthures_trig.xsl"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:output method="xml"/>
    <xsl:template match="/">
        <svg:svg viewBox="0 0 800 500">
            <xsl:call-template name="pie_chart"/>
        </svg:svg>
    </xsl:template>
    
    <xsl:template name="pie_chart">
        <!-- draw the pie for every company-->
        <xsl:for-each select="/ROWSET/ROW[preceding-sibling::ROW[1]/P2/text() != P2/text() or position() = 1]">
            <xsl:variable name="company_name" select="P2/text()"/>
            <xsl:variable name="no_products" select="count(//ROW[P2/text()=$company_name])"/>
            <svg:g id="pie{position()}" transform="translate({(position() - 1) * 350},0)">
                        <xsl:attribute name="width"><xsl:value-of select="300"/></xsl:attribute>
                        <xsl:attribute name="height"><xsl:value-of select="300"/></xsl:attribute>
                        <xsl:attribute name="viewBox"><xsl:value-of select="'0 0 500 500'"/></xsl:attribute>
                        <!--call the template starting at the last slice-->
                        <xsl:call-template name="pie_chart_slice">
                            <xsl:with-param name="company_name" select="$company_name"/>
                            <xsl:with-param name="sum" select="sum(//ROW[P2/text()=$company_name]/P14/text())"/>
                            <xsl:with-param name="position" select="$no_products"/>
                            <xsl:with-param name="no_products" select="$no_products"/>
                            <xsl:with-param name="middle_x" select="200"/>
                            <xsl:with-param name="middle_y" select="200"/>
                            <xsl:with-param name="move_x" select="0"/>
                            <xsl:with-param name="radius" select="150"/>
                        </xsl:call-template>
                    </svg:g>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="pie_chart_slice">
        <xsl:param name="company_name"/>
        <xsl:param name="sum"/>
        <xsl:param name="position"/>
        <xsl:param name="no_products"/>
        <xsl:param name="middle_x"/>
        <xsl:param name="middle_y"/>
        <xsl:param name="move_x"/>
        <xsl:param name="radius"/>
        
        <!--prepare the middle part of the arc command-->
        <xsl:variable name="middle" select="concat('M',' ',$middle_x,',',$middle_y)"/>
        <xsl:variable name="part" select="sum(//ROW[P2/text()=$company_name][position() &lt;= $position]/P14/text())"/>
        <xsl:variable name="angle" select="($part div $sum) * 360"/>
        
        <!-- usando chamadas em template XSLT - para nao usar extensoes -->
        <xsl:variable name="x">
            <xsl:variable name="sin_x">
                <xsl:call-template name="sin">
                    <xsl:with-param name="x" select="$pi * $angle div 180.0" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$sin_x * $radius" />
        </xsl:variable>
        
        <xsl:variable name="y">
            <xsl:variable name="cos_y">
                <xsl:call-template name="cos">
                    <xsl:with-param name="x" select="$pi * $angle div 180.0" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$cos_y * $radius" />
        </xsl:variable>

        <xsl:variable name="move_y" select="-$radius"/>
        <xsl:variable name="first_line" select="concat('l',' ',$move_x,',',$move_y)"/>
        <xsl:variable name="arc_move1" select="'0'"/>
        <xsl:variable name="arc_move2">
            <xsl:choose>
                <!--check the direction of the arc: inward or outward-->
                <xsl:when test="$angle &lt;=180">0</xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="arc_move3" select="'1'"/>
        <xsl:variable name="arc_move" select="concat($arc_move1,' ',$arc_move2,',',$arc_move3)"/>
        <xsl:variable name="d" select="concat($middle,' ',$first_line,' ','a150,150',' ',$arc_move,' ',$x,',',$radius - $y,' ','z')"/>
        <!--put it all together-->
        <svg:path stroke="black" stroke-width="1" stroke-linejoin="round">
            <xsl:attribute name="fill"><xsl:call-template name="giveColor"><xsl:with-param name="i"><xsl:value-of select="$position"/></xsl:with-param></xsl:call-template></xsl:attribute>
            <xsl:attribute name="d"><xsl:value-of select="$d"/></xsl:attribute>
        </svg:path>
        <!--now the percentage-->
        <xsl:variable name="percentage" select="format-number(( //ROW[P2/text()=$company_name][position() = $position]/P14/text() div sum(//ROW[P2/text()=$company_name]/P14/text()) ) * 100,'###,###0.00')"/>
        <xsl:variable name="part_half" select="format-number(( //ROW[P2/text()=$company_name][position() = $position]/P14/text() div sum(//ROW[P2/text()=$company_name]/P14/text()) ) div 2 * 360,'###,###0.00')"/>
        
        <!-- usando chamadas em template XSLT - para nao usar extensoes -->
        <xsl:variable name="text_x">
            <xsl:variable name="sin_x">
                <xsl:call-template name="sin">
                    <xsl:with-param name="x" select="$pi * (($angle - $part_half ) div 180.0)" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$sin_x * ($radius * 0.8)" />
        </xsl:variable>
        
        <xsl:variable name="text_y">
            <xsl:variable name="cos_y">
                <xsl:call-template name="cos">
                    <xsl:with-param name="x" select="$pi * (($angle - $part_half ) div 180.0)" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$cos_y * ($radius * 0.8)" />
        </xsl:variable>
        
        <xsl:variable name="text_line_x">
            <xsl:variable name="sin_x">
                <xsl:call-template name="sin">
                    <xsl:with-param name="x" select="$pi * (($angle - $part_half ) div 180.0)" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$sin_x * ($radius * 1.1)" />
        </xsl:variable>
        
        <xsl:variable name="text_line_y">
            <xsl:variable name="cos_y">
                <xsl:call-template name="cos">
                    <xsl:with-param name="x" select="$pi * (($angle - $part_half ) div 180.0)" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$cos_y * ($radius * 1.1)" />
        </xsl:variable>

        <!--we either put it on the cream or have a line pointing into the slice-->
        <xsl:choose>
            <xsl:when test="$percentage >= 3">
                <!--on the cream-->
                <svg:text text-anchor="middle" font-size="8">
                    <xsl:attribute name="x"><xsl:value-of select="$middle_x + $text_x"/></xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="$middle_y - $text_y"/></xsl:attribute>
                    <xsl:value-of select="$percentage"/>
                </svg:text>
            </xsl:when>
            <xsl:otherwise>
                <!--extra line pointing into the slice-->
                <svg:path stroke="black" stroke-width="1" stroke-linejoin="round">
                    <xsl:attribute name="fill">none</xsl:attribute>
                    <xsl:attribute name="d"><xsl:value-of select="concat('M',' ', $middle_x + $text_x,',',$middle_y - $text_y,' ','L',' ',$middle_x + $text_line_x,',',$middle_y - $text_line_y,' ','H',' ',$middle_x + $text_line_x - 10)"/></xsl:attribute>
                </svg:path>
                <svg:text text-anchor="end" font-size="8">
                    <xsl:attribute name="x"><xsl:value-of select="$middle_x + $text_line_x - 11 "/></xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="$middle_y - $text_line_y + 1"/></xsl:attribute>
                    <xsl:value-of select="$percentage"/>
                </svg:text>
            </xsl:otherwise>
        </xsl:choose>
        
        <!--loop until we reach the first part-->
        <xsl:if test="$position > 1">
            <xsl:call-template name="pie_chart_slice">
                <xsl:with-param name="company_name" select="$company_name"/>
                <xsl:with-param name="sum" select="$sum"/>
                <xsl:with-param name="position" select="$position - 1"/>
                <xsl:with-param name="no_products" select="$no_products"/>
                <xsl:with-param name="middle_x" select="$middle_x"/>
                <xsl:with-param name="middle_y" select="$middle_y"/>
                <xsl:with-param name="move_x" select="$move_x"/>
                <xsl:with-param name="radius" select="$radius"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="giveColor">
        <xsl:param name="i"/>
        <xsl:choose>
            <xsl:when test="$i=1">orangered</xsl:when>
            <xsl:when test="$i=2">cornflowerblue</xsl:when>
            <xsl:when test="$i=3">yellow</xsl:when>
            <xsl:when test="$i=4">lightgreen</xsl:when>
            <xsl:when test="$i=5">blueviolet</xsl:when>
            <xsl:when test="$i=6">chartreuse</xsl:when>
            <xsl:when test="$i=7">deepskyblue</xsl:when>
            <xsl:when test="$i=8">lightbrown</xsl:when>
            <xsl:when test="$i=9">aquamarine</xsl:when>
            <xsl:when test="$i=10">pink</xsl:when>
            <xsl:when test="$i=11">cornflowerblue</xsl:when>
            <xsl:when test="$i=12">lightyellow</xsl:when>
            <xsl:when test="$i=13">burlywood</xsl:when>
            <xsl:when test="$i=14">cornflowerblue</xsl:when>
            <xsl:when test="$i=15">cornsilk</xsl:when>
            <xsl:otherwise>black</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
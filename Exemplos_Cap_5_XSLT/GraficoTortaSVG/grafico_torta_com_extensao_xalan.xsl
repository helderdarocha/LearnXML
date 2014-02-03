<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns:math="xalan://java.lang.Math" 
    extension-element-prefixes="math">
    <xsl:output method="xml"/>
    <xsl:template match="/">
        <xsl:call-template name="pie_chart"/>
    </xsl:template>
    <xsl:template name="pie_chart">
        <!-- draw the pie for every company-->
        <xsl:for-each select="/ROWSET/ROW[preceding-sibling::ROW[1]/P2/text() != P2/text() or position() = 1]">
            <xsl:variable name="company_name" select="P2/text()"/>
            <xsl:variable name="no_products" select="count(//ROW[P2/text()=$company_name])"/>
                    <svg:svg>
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
                    </svg:svg>
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
        <xsl:variable name="x" select="math:sin(3.1415292 * $angle div 180.0) * $radius"/>
        <xsl:variable name="y" select="math:cos(3.1415292 * $angle div 180.0) * $radius"/>
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
        <xsl:variable name="text_x" select="math:sin(3.1415292 * (($angle - $part_half ) div 180.0)) * ($radius * 0.8)"/>
        <xsl:variable name="text_y" select="math:cos(3.1415292 * (($angle - $part_half ) div 180.0)) * ($radius * 0.8)"/>
        <xsl:variable name="text_line_x" select="math:sin(3.1415292 * (($angle - $part_half ) div 180.0)) * ($radius * 1.1)"/>
        <xsl:variable name="text_line_y" select="math:cos(3.1415292 * (($angle - $part_half ) div 180.0)) * ($radius * 1.1)"/>
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
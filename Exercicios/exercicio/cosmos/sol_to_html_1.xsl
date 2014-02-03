<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="iso-8859-1" method="html" />
    <xsl:template match="asteroide" >
        <p style="margin: 0px">
        <xsl:value-of select="@nome" /></p>
    </xsl:template>
    <xsl:template match="satelite" >
        <li><xsl:value-of select="@nome" /></li>
    </xsl:template>
    <xsl:template match="planeta" >
        <p><b><xsl:value-of select="@nome" /></b></p>
        <ol><xsl:apply-templates select="satelite" /></ol>
    </xsl:template>
    <xsl:template match="orbita">
        <h3 style="border-top: solid black 1px">
        <xsl:value-of select="raioMedUA" /> UA</h3>
        <xsl:apply-templates />
    </xsl:template>
</xsl:stylesheet>

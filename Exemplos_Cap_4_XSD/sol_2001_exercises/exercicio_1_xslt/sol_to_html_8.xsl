<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
	
	<xsl:template match="text()" />
	
	<xsl:template match="/">
		<html><head></head><body>
			<h3>Planetas, asteroides ou satelites maiores que Plutão 
   e menores que a Terra.</h3>
			<ol><xsl:apply-templates>
				<xsl:sort select="@diametrokm" />
			</xsl:apply-templates></ol>
		</body></html>
	</xsl:template>
	
	<xsl:template match="*[(name() = 'satelite' or name() = 'asteroide' or name() = 'planeta') and @diametrokm &gt;= //planeta[@nome='Plutão']/@diametrokm and @diametrokm &lt;= //planeta[@nome='Terra']/@diametrokm]">
		<li><xsl:value-of select="@nome" />
		<xsl:text> (diâmetro: </xsl:text>
		<xsl:value-of select="@diametrokm" />
		<xsl:text> km) </xsl:text>
		<xsl:if test="name() = 'satelite'">
			<xsl:text> satélite de </xsl:text><xsl:value-of select="../@nome" />
		</xsl:if></li>
	</xsl:template>

</xsl:stylesheet>

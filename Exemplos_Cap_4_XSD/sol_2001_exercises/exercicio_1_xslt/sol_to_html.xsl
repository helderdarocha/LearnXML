<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
	
	<xsl:template match="text()" />
	
	<xsl:template match="/">
		<html><head></head><body>
			<h3>Nome de todos os satélites cujo diametrokm é maior que a Lua.</h3>
			<p><xsl:text>(diâmetro da Lua: </xsl:text>
			<xsl:value-of select="//satelite[@nome='Lua']/@diametrokm" />
			<xsl:text> km)</xsl:text></p>
			<ol><xsl:apply-templates /></ol>
		</body></html>
	</xsl:template>
	
	<xsl:template match="satelite[@diametrokm &gt; //satelite[@nome='Lua']/@diametrokm]">
		<li><xsl:value-of select="@nome" />
		<xsl:text> (diâmetro: </xsl:text>
		<xsl:value-of select="@diametrokm" />
		<xsl:text> km) Satelite de </xsl:text>
		<xsl:value-of select="../@nome" /></li>
	</xsl:template>

</xsl:stylesheet>

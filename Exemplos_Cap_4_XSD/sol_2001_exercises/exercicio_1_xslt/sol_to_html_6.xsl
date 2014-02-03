<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
	
	<xsl:template match="text()" />
	
	<xsl:template match="/">
		<html><head></head><body>
			<h3>Maior satélite do sistema solar</h3>
			<ol><xsl:apply-templates /></ol>
		</body></html>
	</xsl:template>
	
	<xsl:template match="satelite[not(@diametrokm &lt; //satelite/@diametrokm)]">
		<li><xsl:value-of select="@nome" />
		<xsl:text> (id: </xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text>) </xsl:text></li>
	</xsl:template>

</xsl:stylesheet>

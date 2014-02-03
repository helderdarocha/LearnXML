<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
	
	<xsl:template match="text()" />
	
	<xsl:template match="/">
		<html><head></head><body>
			<h3>Id de todos os sat�lites de Netuno.</h3>
			<ol><xsl:apply-templates>
				<xsl:sort select="@diametrokm" />
			</xsl:apply-templates></ol>
		</body></html>
	</xsl:template>
	
	<xsl:template match="//*[@nome='Netuno']//satelite">
		<li><xsl:value-of select="@nome" />
		<xsl:text> (id: </xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text>) </xsl:text></li>
	</xsl:template>

</xsl:stylesheet>

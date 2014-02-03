<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
	
	<xsl:template match="text()" />
	
	<xsl:template match="/">
		<html><head></head><body>
			<h3>Astros cujo nome começa com "D"</h3>
			<ol><xsl:apply-templates /></ol>
		</body></html>
	</xsl:template>
	
	<xsl:template match="*[(name() = 'satelite' or name() = 'asteroide') and substring(@nome,1,1) = 'D']">
		<li><xsl:value-of select="@nome" />
		<xsl:text> (id: </xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text>) </xsl:text></li>
	</xsl:template>

</xsl:stylesheet>

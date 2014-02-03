<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output encoding="iso-8859-1" method="xml"/>
	
	<xsl:template match="/">
		<xsl:copy><xsl:apply-templates /></xsl:copy>
	</xsl:template>
	
	<xsl:template match="*">
	    <xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
		
	<xsl:template match="email">
		<e-mail>
			<xsl:value-of select="." />
		</e-mail>
	</xsl:template>


</xsl:stylesheet>

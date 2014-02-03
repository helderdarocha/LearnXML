<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output encoding="iso-8859-1" method="xml" indent="yes"/>
	
	<xsl:template match="pessoa">
	    <xsl:copy-of select="." />
	</xsl:template>
	
	<xsl:template match="pessoas">
		<convidados>
			<xsl:apply-templates />
		</convidados>
	</xsl:template>


</xsl:stylesheet>

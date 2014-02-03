<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="iso-8859-1" method="xml" indent="yes"/>
	
	<xsl:variable name="nomedocs" select="/page/folder" />
	<xsl:variable name="docs" select="document($nomedocs)" />
	
	<xsl:template match="/">
		<arquivos><xsl:for-each select="$docs">
			<xsl:copy-of select="." />
		</xsl:for-each></arquivos>
	</xsl:template>
	
</xsl:stylesheet>

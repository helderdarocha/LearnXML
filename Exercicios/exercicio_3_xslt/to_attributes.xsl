<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="*">
		<xsl:copy>
			<xsl:for-each select="*">
				<xsl:attribute name="{name()}">
					<xsl:value-of select="normalize-space(.)" />
				</xsl:attribute>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>

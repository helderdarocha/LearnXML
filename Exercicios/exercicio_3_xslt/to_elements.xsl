<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="*">
		<xsl:copy>
			<xsl:for-each select="@*">
				<xsl:element name="{name()}">
					<xsl:value-of select="." />
				</xsl:element>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>

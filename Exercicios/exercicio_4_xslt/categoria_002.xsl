<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
	<xsl:strip-space elements="*" />	
	<xsl:key name="cat" match="item" use="@category" />
	
	<xsl:template match="catalogue">
		<xsl:for-each select="item[count(.|key('cat', @category)[1])=1]">
			<dt><xsl:value-of select="@category" /></dt>
			<xsl:for-each select="key('cat', @category)">
				<dd><xsl:value-of select="." /></dd>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>

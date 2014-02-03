<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="iso-8859-1" method="html" indent="yes"/>
    <xsl:key name="cat_key" match="item" use="@category" />    
    <xsl:template match="catalogue">
        <dl><xsl:for-each select="item">
			<id><xsl:value-of select="generate-id(.)" /></id>
			<key><xsl:value-of select="generate-id(key('cat_key', @category))" /></key>
            <!--<xsl:for-each select="key('cat_key', @category)">
                <xsl:if test="position() = 1">
                    <dt><xsl:value-of select="@category" /></dt>
                </xsl:if>
                <dd><xsl:value-of select="." /></dd>
            </xsl:for-each> -->
        </xsl:for-each>
        </dl>
    </xsl:template>

</xsl:stylesheet>

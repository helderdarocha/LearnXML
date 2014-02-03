<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="iso-8859-1" method="xml" indent="yes" />
	<xsl:key name="categoria" match="item" use="@category" />
	
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="catalogue">
		<dl>
			<xsl:for-each select="item[count(. | key('categoria', @category)[1]) = 1]">
				<xsl:sort select="@category" />
				<xsl:for-each select="key('categoria', @category)">
					<xsl:sort select="." />
					<xsl:if test="position() = 1">
						<dt>
							<xsl:value-of select="@category" />
						</dt>
					</xsl:if>
					<dd>
						<xsl:value-of select="." />
					</dd>
				</xsl:for-each>
			</xsl:for-each>
		</dl>
	</xsl:template>

</xsl:stylesheet>

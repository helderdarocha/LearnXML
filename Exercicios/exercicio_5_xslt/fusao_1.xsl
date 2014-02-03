<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="iso-8859-1" method="html"/>
	
	<xsl:variable name="nomedocs" select="/page/folder" />
	<xsl:variable name="docs" select="document($nomedocs)" />
	
	<xsl:template match="/">
		<table border="1">
		<xsl:for-each select="$docs">
			<xsl:apply-templates />
		</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="news">
		<xsl:choose>
			<xsl:when test="@show='true'">
			   <xsl:document href="file:z:/curso_xsl/exercicio_5_xslt/publicados.html" method="html">
		          <tr><td><xsl:value-of select="." /></td></tr>
		       </xsl:document>
			</xsl:when>
			<xsl:otherwise>
				<xsl:document href="file:z:/curso_xsl/exercicio_5_xslt/arquivados.html" method="html">
		          <tr><td><xsl:value-of select="." /></td></tr>
		        </xsl:document>
			</xsl:otherwise>
		</xsl:choose>
		<status>Arquivos gerados</status>
	</xsl:template>
	
</xsl:stylesheet>

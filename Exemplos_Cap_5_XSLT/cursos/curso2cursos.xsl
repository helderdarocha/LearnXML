<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<xsl:apply-templates />
</xsl:template>		

<xsl:template match="doc">
	<xsl:variable name="documento" select="document(concat('file:', .))" />	
	<xsl:apply-templates select="$documento" />
</xsl:template>

<xsl:template match="*">
    <xsl:element name="{name(.)}">
		<xsl:if test="name(.) = 'titulo'">
			<xsl:attribute name="id">
               <xsl:value-of select="generate-id(.)"/>
            </xsl:attribute>
			<xsl:attribute name="codigo">
               	<xsl:value-of select="../@grupo"/>
	  			<xsl:value-of select="../@assunto"/>
	  			<xsl:value-of select="../@subgrupo"/>
	  			<xsl:value-of select="../@fragmento"/>
            </xsl:attribute>
		</xsl:if>
        <xsl:for-each select="@*">
            <xsl:attribute name="{name(.)}">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </xsl:for-each>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>


</xsl:stylesheet>
<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<xsl:output method="xml" encoding="iso-8859-1"/>
	<xsl:variable name="page-master">p1</xsl:variable>
	
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="$page-master">
					<fo:region-before extent="2cm"/>
					<fo:region-end extent="1cm"/>
					<fo:region-after extent="1.9cm"/>
					<fo:region-start extent="2.5cm"/>
					<fo:region-body margin-left="2.7cm"
							margin-right="1.2cm"
							margin-bottom="2.1cm"
							margin-top="2.2cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-name="$page-master">
				<xsl:apply-templates />
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	
	<xsl:template match="sistemaEstelar">
		<fo:flow flow-name="xsl-region-body">
			<fo:block>
				<xsl:apply-templates />.
            </fo:block>
		</fo:flow>
	</xsl:template>
	
	<xsl:template match="centro">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="orbita">
		<fo:leader leader-pattern="rule" leader-length="16cm" />
		<fo:block>
			<xsl:value-of select="@raioMedUA" />
			<xsl:text> UA</xsl:text>
		</fo:block>
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="planeta">
		<fo:block>
			<fo:inline font-weight="bold">
				<xsl:value-of select="@nome" />
			</fo:inline>
		</fo:block>
		<fo:list-block color="red">
			<xsl:apply-templates select="satelite"/>
		</fo:list-block>
	</xsl:template>
	
	<xsl:template match="asteroide">
		<fo:block>
			<xsl:value-of select="@nome" />
        (asteróide)</fo:block>
	</xsl:template>
	
	<xsl:template match="estrela">
		<fo:block font-weight="bold" font-size="24pt">
			<xsl:value-of select="@nome" />
		</fo:block>
	</xsl:template>
	
	<xsl:template match="satelite">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block>
					<xsl:value-of select="position()" /><xsl:text>.</xsl:text>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="20px">
				<fo:block>
					<xsl:value-of select="@nome" />
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>

</xsl:stylesheet>

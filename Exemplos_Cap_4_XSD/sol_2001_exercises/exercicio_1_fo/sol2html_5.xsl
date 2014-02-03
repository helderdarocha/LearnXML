<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
	<xsl:strip-space elements="*" />
    <xsl:template match="/">
	 <html>
       <head>
       <style>
       * {font-family: tahoma, sans-serif; font-size: 10pt}
       td {border: solid gray 1px}
       </style>
       <title>Sistema Estelar</title>
     </head>
     <body>
        <xsl:apply-templates />
	 </body>
	 </html>
    </xsl:template>
    
    <xsl:template match="sistemaEstelar">
	<h1>Sistema Estelar</h1>
	    <ul>
			<xsl:for-each select="//planeta">
				<li><xsl:value-of select="position()"/>. <a href="#{@id}">
				<xsl:value-of select="@nome" /></a></li>
			</xsl:for-each>
		</ul>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="centro">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="orbita">
        <div style="width: 600px; padding: 5mm; margin: 5mm; background: rgb(90%,95%,95%); border: solid gray 1px">
        <a name="{*/@id}"></a>
		<h3 style="border-top: solid black 1px">
        <xsl:value-of select="@raioMedUA" /><xsl:text> UA</xsl:text>
        </h3>
        <xsl:apply-templates />
		</div>
    </xsl:template>
    
    <xsl:template match="planeta">
		<p style="color: navy; align: center">
		<b><xsl:value-of select="@nome" /></b></p>
		<img src="{imagem/@href}"></img>
		<xsl:if test="satelite">
			<p>Satélite(s)
			<table>
			<tr>
			<td></td><td>Nome</td><td>Diâmetro médio</td><td>Raio da órbita</td>
			</tr>
			<xsl:apply-templates select="satelite"/>
			</table></p>
		</xsl:if>
    </xsl:template>
    
    <xsl:template match="asteroide">
        <p style="margin: 0px">
        <xsl:value-of select="@nome" />
        (asteróide)</p>
    </xsl:template>
    
    <xsl:template match="estrela">
	    <a name="{@nome}"></a>
        <h1><xsl:value-of select="@nome" /></h1>
		<img src="{../imagem/@href}"></img>
    </xsl:template>
    
    <xsl:template match="satelite">
        <tr style="text-align: center">
		<td><b><xsl:value-of select="position()" /></b></td>
		<td><b><xsl:value-of select="@nome" /></b></td>
		<td><b><xsl:value-of select="@diametrokm" /></b></td>
		<td><b><xsl:value-of select="@raioMedOrbitakm" /></b></td>
		</tr>
    </xsl:template>

</xsl:stylesheet>

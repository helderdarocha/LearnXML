<?xml version="1.0" encoding="iso-8859-1" ?>

<banana:stylesheet version="1.0" 
        xmlns:banana="http://www.w3.org/1999/XSL/Transform"
		xmlns:laranja="http://www.w3.org/1999/xhtml">

    <banana:output method="xml" />
	
	<banana:strip-space elements="*" />
    <banana:template match="/">
	 <laranja:html>
       <laranja:head>
       <laranja:style>
       * {font-family: tahoma, sans-serif; font-size: 10pt}
       td {border: solid gray 1px}
       </laranja:style>
       <laranja:title>Sistema Estelar</laranja:title>
     </laranja:head>
     <laranja:body>
        <banana:apply-templates />
	 </laranja:body>
	 </laranja:html>
    </banana:template>
    
    <banana:template match="sistemaEstelar">
        <banana:apply-templates />
    </banana:template>
    
    <banana:template match="centro">
        <banana:apply-templates />
    </banana:template>
    
    <banana:template match="orbita">
        <laranja:div style="width: 600px; padding: 5mm; margin: 5mm; background: rgb(90%,95%,95%); border: solid gray 1px">
        <laranja:h3 style="border-top: solid black 1px">
        <banana:value-of select="@raioMedUA" /><banana:text> UA</banana:text>
        </laranja:h3>
        <banana:apply-templates />
		</laranja:div>
    </banana:template>
    
    <banana:template match="planeta">
		<laranja:p style="color: navy; align: center">
		<laranja:b><banana:value-of select="@nome" /></laranja:b></laranja:p>
		<banana:if test="satelite">
			<laranja:p>Satélite(s)
			<laranja:table>
			<laranja:tr>
			<laranja:td></laranja:td><laranja:td>Nome</laranja:td><laranja:td>Diâmetro médio</laranja:td><laranja:td>Raio da órbita</laranja:td>
			</laranja:tr>
			<banana:apply-templates select="satelite"/>
			</laranja:table></laranja:p>
		</banana:if>
    </banana:template>
    
    <banana:template match="asteroide">
        <laranja:p style="margin: 0px">
        <banana:value-of select="@nome" />
        (asteróide)</laranja:p>
    </banana:template>
    
    <banana:template match="estrela">
        <laranja:h1><banana:value-of select="@nome" /></laranja:h1>
    </banana:template>
    
    <banana:template match="satelite">
        <laranja:tr style="text-align: center">
		<laranja:td><laranja:b><banana:value-of select="position()" /></laranja:b></laranja:td>
		<laranja:td><laranja:b><banana:value-of select="@nome" /></laranja:b></laranja:td>
		<laranja:td><laranja:b><banana:value-of select="@diametrokm" /></laranja:b></laranja:td>
		<laranja:td><laranja:b><banana:value-of select="@raioMedOrbitakm" /></laranja:b></laranja:td>
		</laranja:tr>
    </banana:template>

</banana:stylesheet>

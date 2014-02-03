<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/TR/REC-html40">

<!-- Tudo o que está na raiz do documento XML original -->
<xsl:template match="/">
	<html xmlns="http://www.w3.org/TR/REC-html40">
	 <head>
		<style>
		 * {font-size: 11pt}
		 body {background-color: rgb(80%,80%,80%); position: absolute; top: 0px; left: 0px;}
		 .curso {width: 630px; background-color: white; padding: 15px;
		         position: absolute; top: 20px; left: 20px; }
		 .header {color: navy; margin-bottom: 30px;
					 border-bottom: solid navy 1px; width: 600px}
		 .footer {text-align: right; width: 600px}
		 .body {font-family: serif; font-size: 11pt; line-height: 18pt; width: 600px}
		 td {font-size: 18pt; color: rgb(50%,50%,100%)}
		 td.codigo {font-size: 20pt; color: navy; font-family: tahoma, sans-serif}
	   </style>
	 </head>
	 <body>
	  <div class="curso">
      <div class="header">www.argonavis.com.br - Novos Cursos</div>
	   <div class="body"><xsl:apply-templates select="curso" /></div>
	   <div class="footer">Esta página foi gerada a partir de documentos XML.</div>
	  </div>
	 </body>
	</html>
</xsl:template>		
		
	
<!-- Aplica-se a tudo o que estiver dentro
     de curso no documento-fonte -->	
<xsl:template match="curso">
   <table><tr>
	<td class="codigo" valign="top"><xsl:value-of select="@grupo"/>
	    <xsl:value-of select="@assunto"/>
	    <xsl:value-of select="@subgrupo"/>
	    <xsl:value-of select="@fragmento"/></td>
		 <td valign="bottom"><xsl:value-of select="titulo" /></td></tr></table>
		
	<!-- Carga-horaria -->
	<p><b>Carga horária:</b> <xsl:value-of select="carga-horaria" /> h</p>
	
	<!-- Pré-requisitos -->
	<p>
	  <b>Pré-requisitos: 
	  </b> 
	  <xsl:for-each select="pre-requisito">
	  		<xsl:if test="contains(@tipo, 'desejavel')">
				<i>Recomendado para melhor aproveitamento: </i>
			</xsl:if>
			<xsl:value-of select="."/>
			<xsl:text>. </xsl:text>
	  </xsl:for-each>
	</p>
	
	<!-- Descrição -->
	<p>
	  <b>Descrição: </b> 
	   <xsl:value-of select="descricao" />
	</p>
	
	<!-- Objetivo -->
	<p><b>Objetivo:</b> 
	   <xsl:value-of select="objetivo" />
	</p>	
	
	<xsl:apply-templates select="observacao"/>
	
	<!-- Tópicos -->
	<p><b>Tópicos: </b></p> 
	<!-- Lista de tópicos -->
	<ul>
	  <xsl:for-each select="topicos/item" >
	  	 <li><xsl:value-of select="."/></li>
	  </xsl:for-each>
	</ul>
</xsl:template>		

<!-- Elemento /curso/observacao -->
<xsl:template match="observacao">
	<p>
	  	<b>
			Observação: 
	  	</b> 
	    <xsl:apply-templates />
	</p>
</xsl:template>

<!-- Elemento link -->
<xsl:template match="link">
  <a>
	  <xsl:if test="@tipo = 'http'">
		 <xsl:attribute name="href">
		 	<xsl:text>http://</xsl:text><xsl:value-of select="." />
		 </xsl:attribute>
	  </xsl:if>
	  <xsl:if test="@tipo = 'email'">
		 <xsl:attribute name="href">
		 	<xsl:text>mailto:</xsl:text><xsl:value-of select="." />
		 </xsl:attribute>
	  </xsl:if>
	  <xsl:if test="@tipo = 'id'">
	  	 <xsl:attribute name="href">
		 	<xsl:text>#</xsl:text><xsl:value-of select="target" />
		 </xsl:attribute>
	  </xsl:if>
		<xsl:value-of select="." /> 
  </a>    
</xsl:template>

			
</xsl:stylesheet>
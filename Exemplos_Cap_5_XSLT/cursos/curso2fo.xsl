<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- Tudo o que est� na raiz do documento XML original -->
<xsl:template match="/">
	<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
		<!-- Layout da p�gina -->
    	<fo:layout-master-set>
			<fo:simple-page-master master-name="pagina-de-curso" 
			                       margin-top="0.5cm"
								        margin-bottom="0.5cm"
								        margin-left="2.5cm"
								        margin-right="2.5cm"
								        page-height="27.9cm" 
								        page-width="21.0cm">
    			<fo:region-body margin-top="1.5cm" 
				                margin-bottom="2cm"/>
    			<fo:region-before extent="2cm"/>
    			<fo:region-after extent="2cm"/>

			</fo:simple-page-master>
		</fo:layout-master-set>

		<!-- P�ginas seguintes -->
		<fo:page-sequence master-name="pagina-de-curso"
		                  font-size="8pt">
		
			<!-- Conte�do est�tico para cabe�alho -->
		    <fo:static-content flow-name="xsl-region-before" 
			                   color="navy">
          		<fo:block>
					www.argonavis.com.br - Novos Cursos
				</fo:block>
				<fo:block>
					<fo:leader leader-pattern="rule" 
					           color="navy"
                               leader-length="16cm" />
          		</fo:block>
        	</fo:static-content>
			
			<!-- Conte�do est�tico para rodap� -->
			<fo:static-content flow-name="xsl-region-after">
				<fo:block>
					<fo:block text-align="start" 
					          font-family="serif">
						Esta p�gina foi gerada a partir de documentos XML.
					</fo:block>
					<fo:leader leader-pattern="rule" 
					           color="navy"
                               leader-length="16cm" />
          			</fo:block>
	          		<fo:block text-align="end">
						p�gina <fo:page-number/>
					</fo:block>
        	</fo:static-content>
			
			<!-- Conte�do de fluxo para corpo da p�gina -->
			<fo:flow flow-name="xsl-region-body">
		  	  <fo:block font-family="serif" 
			            font-size="11pt" 
					      line-height="18pt">
	  			<!-- Esta � a parte recursiva: aplique aqui 
				     tudo o que estiver dentro de cursos e use
					 apenas templates rotulados com mode="normal" -->
				<xsl:apply-templates select="curso" />
		  	  </fo:block>
			</fo:flow>
			
		</fo:page-sequence>
		<!-- Fim do template das p�ginas restantes -->
		
	</fo:root>
</xsl:template>		
		
	
<!-- Aplica-se a tudo o que estiver dentro
     de curso no documento-fonte -->	
<xsl:template match="curso">
	<!-- Titulo do curso -->
	<fo:block font-size="18pt" 
	          color="rgb(50%,50%,100%)"> 
			  
			  <!-- Acrescenta um atributo break-before em fo:block se este n�o for um
			       dos dois primeiros n�s -->
			  <xsl:if test="position() &gt; 2">
			  	<xsl:attribute name="break-before">page</xsl:attribute>
			  </xsl:if>
			  
			  <!-- Acrescenta um atributo id em fo:block com o valor de titulo id="" -->
			  <xsl:attribute name="id">
			    <xsl:value-of select="titulo[.]/@id" />
			  </xsl:attribute>


		<fo:list-block>
	  	   <fo:list-item start-indent="0pt">
	   		<fo:list-item-label end-indent="60pt">
					<fo:block font-size="20pt" 
	            	       color="navy" 
				   	       font-family="sans-serif">
				  		<xsl:value-of select="@grupo"/>
	    				<xsl:value-of select="@assunto"/>
	    				<xsl:value-of select="@subgrupo"/>
	    				<xsl:value-of select="@fragmento"/>
					</fo:block>
	  			</fo:list-item-label>
			
	  			<fo:list-item-body start-indent="70pt">
	   		   <fo:block>
	     				<xsl:value-of select="titulo" />
	    			</fo:block>
	  			</fo:list-item-body>
			
			</fo:list-item>
		</fo:list-block>
	  
	</fo:block>
	
	<!-- Carga-horaria -->
	<fo:block padding-top="12pt">
	  <fo:inline font-weight="bold">Carga hor�ria: 
	  </fo:inline> 
	   <xsl:value-of select="carga-horaria" /> h
	</fo:block>
	
	<!-- Pr�-requisitos -->
	<fo:block padding-top="12pt">
	  <fo:inline font-weight="bold">Pr�-requisitos: 
	  </fo:inline> 
	  <xsl:for-each select="pre-requisito">
	 	<fo:inline>
	  		<xsl:if test="contains(@tipo, 'desejavel')">
				<fo:inline font-style="italic">Recomendado para melhor aproveitamento: </fo:inline>
			</xsl:if>
			<xsl:value-of select="."/>
			<xsl:text>. </xsl:text>
		</fo:inline>
	  </xsl:for-each>
	</fo:block>
	
	<!-- Descri��o -->
	<fo:block padding-top="12pt">
	  <fo:inline font-weight="bold">Descri��o: 
	  </fo:inline> 
	   <xsl:value-of select="descricao" />
	</fo:block>
	
	<!-- Objetivo -->
	<fo:block padding-top="12pt">
	  <fo:inline font-weight="bold">Objetivo: 
	  </fo:inline> 
	   <xsl:value-of select="objetivo" />
	</fo:block>	
	
	<xsl:apply-templates select="observacao"/>
	
	<!-- T�picos -->
	<fo:block font-weight="bold" 
	          padding-top="12pt">
		T�picos: 
	</fo:block> 
	<!-- Lista de t�picos -->
	<fo:list-block>
	  <xsl:for-each select="topicos/item" >
	  
	  	<fo:list-item start-indent="10pt">
		
	   		<fo:list-item-label end-indent="label-end()">
				<fo:block color="blue">&#x2022;</fo:block>
	  		</fo:list-item-label>
			
	  		<fo:list-item-body start-indent="body-start()">
	   		    <fo:block>
	     			<xsl:value-of select="."/>
	    		</fo:block>
	  		</fo:list-item-body>
			
		</fo:list-item>
		
	  </xsl:for-each>
	</fo:list-block>
</xsl:template>		

<!-- Elemento /curso/observacao -->
<xsl:template match="observacao">
	<fo:block padding-top="12pt">
	  	<fo:inline font-weight="bold">
			Observa��o: 
	  	</fo:inline> 
	    <xsl:apply-templates />
	</fo:block>
</xsl:template>

<!-- Elemento link -->
<xsl:template match="link">
  <fo:basic-link>
	  <xsl:if test="@tipo = 'http'">
		 <xsl:attribute name="external-destination">
		 	<xsl:text>http://</xsl:text><xsl:value-of select="." />
		 </xsl:attribute>
	  </xsl:if>
	  <xsl:if test="@tipo = 'email'">
		 <xsl:attribute name="external-destination">
		 	<xsl:text>mailto:</xsl:text><xsl:value-of select="." />
		 </xsl:attribute>
	  </xsl:if>
	  <xsl:if test="@tipo = 'id'">
	  	 <xsl:attribute name="internal-destination">
		 	<xsl:value-of select="target" />
		 </xsl:attribute>
	  </xsl:if>
	<fo:inline text-decoration="underline" 
	           color="blue">
		<xsl:value-of select="." /> 
	</fo:inline> 
  </fo:basic-link>    
</xsl:template>

			
</xsl:stylesheet>
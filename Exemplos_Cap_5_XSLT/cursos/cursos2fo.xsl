<?xml version="1.0" encoding="iso-8859-1" ?>

<!-- xsl: prefixo do XSL de transformação (não aparece na página destino - é processada)
     fo:  prefixo do XSL de formatação (aparece na página destino - não é processada agora) -->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- Tudo o que está na raiz do documento XML original -->
<xsl:template match="/">
	<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
		<!-- Layout da página -->
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
			
			<fo:simple-page-master master-name="pagina-indice" 
			                       margin-top="0.5cm"
								   margin-bottom="0.5cm"
								   margin-left="3cm"
								   margin-right="3cm"
								   page-height="27.9cm" 
								   page-width="21.0cm">

    			<fo:region-body margin-top="2cm" 
				                margin-bottom="2cm" />
    			<fo:region-before extent="2cm"/>
				<fo:region-after extent="2cm"/>

			</fo:simple-page-master>
			
			<fo:page-sequence-master master-name="contents">
  				<fo:repeatable-page-master-reference
      				master-name="pagina-indice"
					maximum-repeats="1"/>
    			<fo:repeatable-page-master-reference 
      				master-name="pagina-de-curso"/>
			</fo:page-sequence-master>

			
		</fo:layout-master-set>
		
		
		<!-- Primeira pagina-->
		<fo:page-sequence master-name="pagina-indice"
		                  font-size="8pt">
			
			<!-- Conteúdo estático para rodapé -->			  
			<fo:static-content flow-name="xsl-region-after">
				<fo:block text-align="right" 
				          font-family="serif">
					<!-- atualmente vazio -->
				</fo:block>
        	</fo:static-content>
			
			<!-- Conteúdo de fluxo para corpo da página -->
			<fo:flow flow-name="xsl-region-body">
		  	    <fo:block font-family="serif" 
				           font-size="11pt" 
						     line-height="18pt" >
					<!-- Esta é a parte recursiva: aplique aqui 
					     tudo o que estiver dentro de cursos e use
						 apenas templates rotulados com mode="toc" -->
					<xsl:apply-templates select="cursos" 
					                     mode="toc" />
		  	    </fo:block>
			</fo:flow>
			
			
		</fo:page-sequence>
		<!-- Fim do template da primeira página -->
		
		<!-- Páginas seguintes -->
		<fo:page-sequence master-name="pagina-de-curso"
		                  font-size="8pt">
		
			<!-- Conteúdo estático para cabeçalho -->
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
			
			<!-- Conteúdo estático para rodapé -->
			<fo:static-content flow-name="xsl-region-after">
				<fo:block>
					<fo:block text-align="start" 
					          font-family="serif">
						Esta página foi gerada a partir de documentos XML.
					</fo:block>
					<fo:leader leader-pattern="rule" 
					           color="navy"
                               leader-length="16cm" />
          			</fo:block>
	          		<fo:block text-align="end">
						página <fo:page-number/>
					</fo:block>
        	</fo:static-content>
			
			<!-- Conteúdo de fluxo para corpo da página -->
			<fo:flow flow-name="xsl-region-body">
		  	  <fo:block font-family="serif" 
			            font-size="11pt" 
					      line-height="18pt">
	  			<!-- Esta é a parte recursiva: aplique aqui 
				     tudo o que estiver dentro de cursos e use
					 apenas templates rotulados com mode="normal" -->
				<xsl:apply-templates select="cursos" 
				                     mode="normal"/>
		  	  </fo:block>
			</fo:flow>
			
		</fo:page-sequence>
		<!-- Fim do template das páginas restantes -->
		
	</fo:root>
</xsl:template>		

<!-- Aplica-se a tudo o que estiver dentro de /cursos
     no XML fonte, mas este bloco só será chamado por
	 instruções <xsl:apply-templates /> rotuladas com
	 mode="toc" (para a página índice) -->
<xsl:template match="/cursos" 
              mode="toc">
			  
	<fo:block space-after="1.5cm" 
	          text-align="center">
		<!-- Parte recursiva: aplicar aqui todos os
		     templates rotulados match="empresa"
			 (que contem empresa ou qualquer um
			 dos nós filho de empresa) -->
		<xsl:apply-templates select="empresa" />
	</fo:block>
	
	<fo:block margin-left="2.5cm">
		<fo:leader leader-pattern="rule" color="navy"
                   leader-length="13cm"
				   rule-thickness="3pt" />
    </fo:block>	  
	
	<fo:block margin-left="2.5cm">
	  <fo:block font-size="15pt" 
	          line-height="30pt">
	   Cursos Selecionados
	  </fo:block>
	  
	  <!-- Lista de cursos -->
	  <fo:list-block space-before="0.5cm">
	    <xsl:for-each select="arquivos/curso/titulo" >
		
	  	  <fo:list-item start-indent="3cm">
		  
	   		 <fo:list-item-label text-align="start">
				<fo:block color="navy">
				  <fo:basic-link internal-destination="{@id}">
					<xsl:value-of select="@codigo"/>
				  </fo:basic-link>
				</fo:block>
	  		 </fo:list-item-label>
			
	  		 <fo:list-item-body start-indent="4.5cm">
	   		    <fo:block color="blue">
					<fo:basic-link text-decoration="underline" 
					               internal-destination="{@id}">
 						<xsl:value-of select="."/>
						<xsl:text> (</xsl:text>
						<xsl:value-of select="../carga-horaria"/>
						<xsl:text>h)</xsl:text>
   					</fo:basic-link>
	    		</fo:block>
	  		 </fo:list-item-body>
			
		  </fo:list-item>
		  
	    </xsl:for-each>
	  </fo:list-block>
	  
	</fo:block>
	
	<fo:block margin-left="2.5cm">
		<fo:leader leader-pattern="rule" color="navy"
                   leader-length="12cm" />
    </fo:block>
	
	
	<fo:block line-height="15pt"
	          space-before="1.5cm" 
			  text-align="justify">
		<fo:inline font-weight="bold">
			Observações: 
		</fo:inline>
		<!-- Chamar templates que tratam de
		     observacoes ou seus filhos -->
		<xsl:apply-templates select="observacoes" />
	</fo:block>
	
	<fo:block space-before="1.5cm">
	    <xsl:text>Contato: </xsl:text><xsl:value-of select="empresa/contato"/>
	    <xsl:text> (</xsl:text><xsl:value-of select="empresa/contato/@telefone"/>
		<xsl:text> ou </xsl:text><xsl:value-of select="empresa/contato/@email"/>
		<xsl:text>)</xsl:text>
	</fo:block>
	
</xsl:template>

<!-- Aplica-se a tudo o que estiver dentro
     de //empresa no documento-fonte -->
<xsl:template match="empresa">
	<fo:block font-size="28pt" 
	          font-family="serif" 
	          color="rgb(50%,50%,100%)" 
			  text-shadow="navy">
		<xsl:value-of select="nome"/>
	</fo:block>
	
	<fo:block>
		<xsl:value-of select="website"/>
	</fo:block>
	
</xsl:template>

<!-- Aplica-se a tudo o que estiver dentro
     de //obs no documento-fonte -->
<xsl:template match="obs">

	<fo:block text-indent="1cm">
		<!-- Incluir tudo o que estiver
		     dentro de //obs aqui -->
		<xsl:apply-templates />
	</fo:block>
	
</xsl:template>

<!-- ////////////////////////////////////////////////// -->

<!-- Aplica-se a tudo o que estiver dentro de /cursos
     no XML fonte, mas este bloco só será chamado por
	 instruções <xsl:apply-templates /> rotuladas com
	 mode="normal" (para páginas normais) -->
<xsl:template match="/cursos" mode="normal">
	<!-- Tudo o que estiver dentro de /cursos/arquivos -->
	<xsl:apply-templates select="arquivos" />
</xsl:template>
	
	
<!-- Aplica-se a tudo o que estiver dentro
     de /cursos/arquivos/curso no documento-fonte -->	
<xsl:template match="/cursos/arquivos/curso">
	<!-- Titulo do curso -->
	<fo:block font-size="18pt" 
	          color="rgb(50%,50%,100%)"> 
			  
			  <!-- Acrescenta um atributo break-before em fo:block se este não for um
			       dos dois primeiros nós -->
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
	  <fo:inline font-weight="bold">Carga horária: 
	  </fo:inline> 
	   <xsl:value-of select="carga-horaria" /> h
	</fo:block>
	
	<!-- Pré-requisitos -->
	<fo:block padding-top="12pt">
	  <fo:inline font-weight="bold">Pré-requisitos: 
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
	
	<!-- Descrição -->
	<fo:block padding-top="12pt">
	  <fo:inline font-weight="bold">Descrição: 
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
	
	<!-- Tópicos -->
	<fo:block font-weight="bold" 
	          padding-top="12pt">
		Tópicos: 
	</fo:block> 
	<!-- Lista de tópicos -->
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

<!-- Elemento /cursos/arquivos/curso/observacao -->
<xsl:template match="observacao">
	<fo:block padding-top="12pt">
	  	<fo:inline font-weight="bold">
			Observação: 
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
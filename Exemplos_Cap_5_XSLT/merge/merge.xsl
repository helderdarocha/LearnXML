<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

    <xsl:output encoding="iso-8859-1" />
    
    <!-- 1. Esta é a raiz do arquivo-fonte (arquivos.xml) -->
    <xsl:template match="/">
       <documentos>
       <xsl:apply-templates />
       </documentos>
    </xsl:template>

    <!-- 2. Seleciona cada nome em <arquivo> e passa para a função
         document("uri") que carrega o seu conteúdo, que por
         sua vez fica guardado na variável $documento.
         Depois, faz um apply-templates começando na raiz
         do documento importado -->

    <xsl:template match="arquivo">
         <xsl:variable name="documento" select="document(.)" />
         <xsl:apply-templates select="$documento" mode="unidade"/>
    </xsl:template>

    <!-- 3. Esta é a raiz de cada arquivo importado -->
    <xsl:template match="/" mode="unidade">
       <xsl:apply-templates />
    </xsl:template>

    <!-- 4. O elemento aluno e todo o seu conteúdo
         é copiado para o documento resultado -->
    <xsl:template match="aluno">
       <xsl:copy-of select="." />
    </xsl:template>

</xsl:stylesheet>


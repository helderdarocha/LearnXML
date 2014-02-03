<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:template match="/">
   <ul><xsl:apply-templates select="document(/page/folder)/news[@show='true']" /></ul>
</xsl:template>

<xsl:template match="news">
  <li>
  <xsl:value-of select="position()" />. <xsl:value-of select="normalize-space(.)" /></li>
</xsl:template>

</xsl:stylesheet>

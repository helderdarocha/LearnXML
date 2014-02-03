<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:import href="defaults.xsl"/>
    
    <xsl:key name="astros" match="planeta|asteroide|satelite" use="@nome"/>
    
    <xsl:template match="sistemaEstelar">
        <p>Diametro de Europa: <xsl:number grouping-separator="." 
                                            grouping-size="3" 
                                            value="key('astros', 'Europa')[2]/@diametrokm" /> km</p>
        <p>Europa eh um: <xsl:value-of select="name(key('astros', 'Europa')[2])" /></p>
    </xsl:template>
    
</xsl:stylesheet>
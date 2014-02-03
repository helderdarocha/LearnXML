<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:output method="text"
    indent="yes"></xsl:output>
    
    <xsl:template match="/">
        <![CDATA[<html>
            <head></head>
            <body>
                ]]><xsl:apply-templates /><![CDATA[
            </body>
        </html>]]>
    </xsl:template>
    
    <xsl:template match="links">
        <![CDATA[<h1>Links</h1>
        <ul>]]><xsl:apply-templates /><![CDATA[</ul>]]>
    </xsl:template>
    
    <xsl:template match="link">
        <![CDATA[<li>]]><![CDATA[<a href="]]><xsl:value-of select="@ref"/><![CDATA[">]]><xsl:value-of select="."/><![CDATA[</a>]]> (<xsl:value-of select="@ref"/>)<![CDATA[</li>]]>
    </xsl:template>

</xsl:stylesheet>
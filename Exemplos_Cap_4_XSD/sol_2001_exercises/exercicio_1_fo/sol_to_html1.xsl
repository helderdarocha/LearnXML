<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" />
	
	<xsl:template match="/">
		<html>
		<head>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8"></META>
		<title>Sistema Estelar</title>
		</head>
		<body>
			<xsl:apply-templates />
		</body>
		</html>
	</xsl:template>	

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"
        omit-xml-declaration = "yes"
        version="1.0"
        encoding = "UTF-8"
/>


<xsl:template match="/">
  <xsl:text>dbconfig={}

</xsl:text>
  <xsl:for-each select="//datasource[@id='yodnsconf_read']/*">
    <xsl:text>dbconfig["</xsl:text>
    <xsl:value-of select="local-name()"/>"] = "<xsl:value-of select="."/>
    <xsl:text>"
</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>

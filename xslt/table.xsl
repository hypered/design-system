<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="machines">
    <table><xsl:apply-templates select="machine"/></table>
  </xsl:template>

  <xsl:template match="machine[1]">
    <tr><xsl:apply-templates select="*" mode="header"/></tr>
    <xsl:call-template name="body"/>
  </xsl:template>

  <xsl:template match="machine" name="body">
    <tr><xsl:apply-templates select="*"/></tr>
  </xsl:template>

  <xsl:template match="machine/*" mode="header">
    <th><xsl:value-of select="name()"/></th>
  </xsl:template>

  <xsl:template match="machine/*">
    <td><xsl:apply-templates select="node()"/></td>
  </xsl:template>
</xsl:stylesheet>

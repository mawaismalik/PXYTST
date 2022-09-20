<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://webservice.stc.comarch.com/" version="1.0">

  <xsl:output encoding="utf-8" indent="yes" method="xml" omit-xml-declaration="yes"/>

  <!-- Stylesheet to inject namespaces into a document in specific places -->

  <xsl:template match="node()">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- template to copy attributes -->
  <xsl:template match="@*">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

    <xsl:template match="/soapenv:Envelope/soapenv:Body/tns:simIds/tns:item">
    <xsl:element name="ns:{local-name()}">
      
      <xsl:namespace name="ns" select="'http://jaxb.dev.java.net/array'"/>

      <xsl:apply-templates select="node()|@*"/>
    </xsl:element>
  </xsl:template>


  <xsl:template match="/soapenv:Envelope/soapenv:Body/tns:simIds/tns:item">
    <xsl:element name="ns:{local-name()}">
      
      <xsl:apply-templates select="node()|@*"/>
    </xsl:element>
  </xsl:template>


  <xsl:template match="/soapenv:Envelope/soapenv:Body/tns:domain/tns:item">
    <xsl:element name="ns:{local-name()}">
      
      <xsl:apply-templates select="node()|@*"/>
    </xsl:element>
  </xsl:template>




  <!-- template to copy the rest of the nodes -->
  <xsl:template match="comment() | processing-instruction()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>

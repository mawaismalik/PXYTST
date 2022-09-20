<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tns="http://webservice.stc.comarch.com/" version="1.0">

	<xsl:output encoding="utf-8" indent="yes" method="xml" omit-xml-declaration="yes"/>

	<!-- Stylesheet to inject namespaces into a document in specific places -->
	<xsl:template match="/">
		<soapenv:Envelope>
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:choose>
					<!-- Handle 'Root' wrapper added by JSON to XML policy -->
					<xsl:when test="normalize-space(/Root)">
						<tns:activateSIMs>
							<xsl:apply-templates select="node()|@*"/>
						</tns:activateSIMs>
					</xsl:when>
					<!-- Handle 'Array' wrapper added by JSON to XML policy -->
					<xsl:when test="normalize-space(/Array)">
						<tns:activateSIMs>
							<xsl:apply-templates select="node()|@*"/>
						</tns:activateSIMs>
					</xsl:when>
					<!-- If the root element is not what was in the schema, add it -->
					<xsl:when test="not(normalize-space(/activateSIMs))">
						<tns:activateSIMs>
							<xsl:apply-templates select="node()|@*"/>
						</tns:activateSIMs>
					</xsl:when>
					<!-- everything checks out,  just copy the xml-->
					<xsl:otherwise>
						<xsl:apply-templates select="node()|@*"/>
					</xsl:otherwise>
				</xsl:choose>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>

	<xsl:template match="/activateSIMs" name="copy-root">
		<xsl:element name="tns:{local-name()}">
			<xsl:copy-of select="namespace::*"/>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="/Array/*" name="copy-array">
		<xsl:element name="tns:{local-name()}">
			<xsl:copy-of select="namespace::*"/>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="*[not(local-name()='activateSIMs') and not(local-name()='Array')]" name="copy-all">
		<xsl:element name="{local-name()}">
			<xsl:copy-of select="namespace::*"/>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:element>
	</xsl:template>
	

	<!-- template to copy the rest of the nodes -->
	<xsl:template match="comment() | processing-instruction()">
		<xsl:copy/>
	</xsl:template>
</xsl:stylesheet>

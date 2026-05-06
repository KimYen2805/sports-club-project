<?xml version="1.0" encoding="UTF-8"?>
<!-- SS10 - Members and Memberships Export to JSON
     Exports all members with their membership details if available.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">
        {
            "members": [
                <xsl:apply-templates select="SportsClub/Members/Member">
                    <xsl:sort select="lastName" order="ascending"/>
                </xsl:apply-templates>
            ]
        }
    </xsl:template>

    <xsl:template match="Member">
        <xsl:variable name="mid" select="id"/>
        <xsl:variable name="membership" select="/SportsClub/Memberships/Membership[memberId = $mid]"/>
        {
            "id": <xsl:value-of select="id"/>,
            "firstName": "<xsl:value-of select="firstName"/>",
            "lastName": "<xsl:value-of select="lastName"/>",
            "email": "<xsl:value-of select="email"/>",
            "sport": "<xsl:value-of select="sport"/>",
            "level": "<xsl:value-of select="level"/>",
            "membership": <xsl:apply-templates select="$membership"/>
            <xsl:if test="not($membership)">null</xsl:if>
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="Membership">
        {
            "plan": "<xsl:value-of select="plan"/>",
            "fee": <xsl:value-of select="fee"/>,
            "status": "<xsl:value-of select="status"/>",
            "startDate": "<xsl:value-of select="startDate"/>",
            "endDate": "<xsl:value-of select="endDate"/>"
        }
    </xsl:template>

</xsl:stylesheet>
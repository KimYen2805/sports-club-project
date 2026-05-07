<?xml version="1.0" encoding="UTF-8"?>
<!-- SS7 - Competition Calendar Export
     Produces a calendar-style XML with competitions, venues and participants.
     Cross-references: CompetitionBookings, Facilities, CompetitionParticipations, Teams.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <CompetitionCalendar>
            <xsl:apply-templates select="SportsClub/Competitions/Competition">
                <xsl:sort select="startDate" order="ascending"/>
            </xsl:apply-templates>
        </CompetitionCalendar>
    </xsl:template>

    <xsl:template match="Competition">
        <xsl:variable name="compId" select="id"/>
        <Event>
            <name><xsl:value-of select="name"/></name>
            <format><xsl:value-of select="format"/></format>
            <startDate><xsl:value-of select="startDate"/></startDate>
            <endDate><xsl:value-of select="endDate"/></endDate>
            <prize><xsl:value-of select="prize"/></prize>
            <xsl:apply-templates select="/SportsClub/CompetitionBookings/CompetitionBooking[competitionId = $compId]"/>
            <participants>
                <xsl:apply-templates select="/SportsClub/CompetitionParticipations/CompetitionParticipation[competitionId = $compId]"/>
            </participants>
        </Event>
    </xsl:template>

    <xsl:template match="CompetitionBooking">
        <xsl:variable name="facId" select="facilityId"/>
        <venue>
            <facilityName><xsl:value-of select="/SportsClub/Facilities/Facility[id = $facId]/name"/></facilityName>
            <date><xsl:value-of select="date"/></date>
            <startTime><xsl:value-of select="startTime"/></startTime>
            <endTime><xsl:value-of select="endTime"/></endTime>
        </venue>
    </xsl:template>

    <xsl:template match="CompetitionParticipation">
        <xsl:variable name="tid" select="teamId"/>
        <team>
            <teamName><xsl:value-of select="/SportsClub/Teams/Team[id = $tid]/name"/></teamName>
            <result><xsl:value-of select="result"/></result>
        </team>
    </xsl:template>

</xsl:stylesheet>
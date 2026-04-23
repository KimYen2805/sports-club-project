<?xml version="1.0" encoding="UTF-8"?>
<!-- SS9 - Bookings Export to JSON
     Exports all TrainingBookings and CompetitionBookings with facility and session details.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">
        {
            "trainingBookings": [
                <xsl:apply-templates select="SportsClub/TrainingBookings/TrainingBooking"/>
            ],
            "competitionBookings": [
                <xsl:apply-templates select="SportsClub/CompetitionBookings/CompetitionBooking"/>
            ]
        }
    </xsl:template>

    <xsl:template match="TrainingBooking">
        <xsl:variable name="fid" select="facilityId"/>
        {
            "id": <xsl:value-of select="id"/>,
            "facility": "<xsl:value-of select="/SportsClub/Facilities/Facility[id = $fid]/name"/>",
            "trainingSessionId": <xsl:value-of select="trainingSessionId"/>,
            "date": "<xsl:value-of select="date"/>",
            "startTime": "<xsl:value-of select="startTime"/>",
            "endTime": "<xsl:value-of select="endTime"/>"
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="CompetitionBooking">
        <xsl:variable name="fid" select="facilityId"/>
        <xsl:variable name="cid" select="competitionId"/>
        {
            "id": <xsl:value-of select="id"/>,
            "facility": "<xsl:value-of select="/SportsClub/Facilities/Facility[id = $fid]/name"/>",
            "competition": "<xsl:value-of select="/SportsClub/Competitions/Competition[id = $cid]/name"/>",
            "date": "<xsl:value-of select="date"/>",
            "startTime": "<xsl:value-of select="startTime"/>",
            "endTime": "<xsl:value-of select="endTime"/>"
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

</xsl:stylesheet>
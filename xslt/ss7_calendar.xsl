<?xml version="1.0" encoding="UTF-8"?>
<!--
  SS7 - Competition Calendar Export
  Scenario: Transform the sports club XML database into a calendar-style XML format.
  For each competition, we output: name, format, dates, prize,
  the facility booked (via CompetitionBooking and Facility),
  and the list of participating teams with their results.
  
  This format could be used for federation exchange or external calendar systems.
  
  XPath used extensively to cross-reference:
    CompetitionBookings by competitionId
    Facilities by facilityId
    CompetitionParticipations by competitionId
    Teams by teamId
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <!-- ROOT TEMPLATE
       Matches the root of the document and creates the
       CompetitionCalendar wrapper element.
  -->
  <xsl:template match="/">
    <CompetitionCalendar>
      <xsl:apply-templates select="SportsClub/Competitions/Competition">
        <xsl:sort select="startDate" order="ascending"/>
      </xsl:apply-templates>
    </CompetitionCalendar>
  </xsl:template>

  <!-- COMPETITION TEMPLATE
       For each Competition, build an Event element with:
         - metadata (name, format, dates, prize)
         - venue info (looked up via CompetitionBooking and Facility)
         - participants (looked up via CompetitionParticipation and Team)
  -->
  <xsl:template match="Competition">
    <!-- Store the current competition id for use in XPath predicates -->
    <xsl:variable name="compId" select="id"/>

    <Event>
      <name><xsl:value-of select="name"/></name>
      <format><xsl:value-of select="format"/></format>
      <startDate><xsl:value-of select="startDate"/></startDate>
      <endDate><xsl:value-of select="endDate"/></endDate>
      <prize><xsl:value-of select="prize"/></prize>

      <!-- VENUE LOOKUP
           Find the CompetitionBooking whose competitionId matches
           the current competition id, then look up the Facility.
      -->
      <xsl:variable name="booking"
        select="/SportsClub/CompetitionBookings/CompetitionBooking[competitionId = $compId]"/>

      <xsl:if test="$booking">
        <venue>
          <xsl:variable name="facId" select="$booking/facilityId"/>
          <facilityName>
            <xsl:value-of select="/SportsClub/Facilities/Facility[id = $facId]/name"/>
          </facilityName>
          <date><xsl:value-of select="$booking/date"/></date>
          <startTime><xsl:value-of select="$booking/startTime"/></startTime>
          <endTime><xsl:value-of select="$booking/endTime"/></endTime>
        </venue>
      </xsl:if>

      <!-- PARTICIPANTS LOOKUP
           Find all CompetitionParticipation entries for this competition,
           then look up each team name.
      -->
      <participants>
        <xsl:for-each select="/SportsClub/CompetitionParticipations/CompetitionParticipation[competitionId = $compId]">
          <xsl:variable name="tid" select="teamId"/>
          <team>
            <teamName>
              <xsl:value-of select="/SportsClub/Teams/Team[id = $tid]/name"/>
            </teamName>
            <result><xsl:value-of select="result"/></result>
          </team>
        </xsl:for-each>
      </participants>

    </Event>
  </xsl:template>

</xsl:stylesheet>
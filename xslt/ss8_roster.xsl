<?xml version="1.0" encoding="UTF-8"?>
<!-- SS8 - Member Roster Export
     Produces an XML roster per team with member details and their role.
     Cross-references: TeamMemberships, Members, CoachingAssignments, Coaches.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <MemberRoster>
            <xsl:apply-templates select="SportsClub/Teams/Team">
                <xsl:sort select="name" order="ascending"/>
            </xsl:apply-templates>
        </MemberRoster>
    </xsl:template>

    <xsl:template match="Team">
        <xsl:variable name="tid" select="id"/>
        <Team>
            <name><xsl:value-of select="name"/></name>
            <sport><xsl:value-of select="sport"/></sport>
            <season><xsl:value-of select="season"/></season>

            <!-- Coach(es) for this team -->
            <coaches>
                <xsl:for-each select="/SportsClub/CoachingAssignments/CoachingAssignment[teamId = $tid]">
                    <xsl:variable name="cid" select="coachId"/>
                    <xsl:variable name="coach" select="/SportsClub/Coaches/Coach[id = $cid]"/>
                    <coach>
                        <name><xsl:value-of select="concat($coach/firstName, ' ', $coach/lastName)"/></name>
                        <role><xsl:value-of select="role"/></role>
                    </coach>
                </xsl:for-each>
            </coaches>

            <!-- Players for this team -->
            <players>
                <xsl:for-each select="/SportsClub/TeamMemberships/TeamMembership[teamId = $tid]">
                    <xsl:variable name="mid" select="memberId"/>
                    <xsl:variable name="member" select="/SportsClub/Members/Member[id = $mid]"/>
                    <player>
                        <name><xsl:value-of select="concat($member/firstName, ' ', $member/lastName)"/></name>
                        <sport><xsl:value-of select="$member/sport"/></sport>
                        <level><xsl:value-of select="$member/level"/></level>
                        <joinDate><xsl:value-of select="joinDate"/></joinDate>
                    </player>
                </xsl:for-each>
            </players>

        </Team>
    </xsl:template>

</xsl:stylesheet>
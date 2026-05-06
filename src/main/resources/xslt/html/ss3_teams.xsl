<?xml version="1.0" encoding="UTF-8"?>
<!--
SS3 - Team Information Page
This stylesheet creates an HTML page showing each team with its sport,
level, season, maximum players, assigned coach, and team members.
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Teams and Coaches</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f4f4f4;
                        padding: 30px;
                    }
                    h1 {
                        text-align: center;
                        color: #333;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        background-color: white;
                    }
                    th {
                        background-color: #2c3e50;
                        color: white;
                        padding: 12px;
                    }
                    td {
                        padding: 10px;
                        border: 1px solid #ddd;
                        text-align: center;
                    }
                    tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }
                </style>
            </head>
            <body>
                <h1>Teams, Coaches and Rosters</h1>

                <table>
                    <tr>
                        <th>Team ID</th>
                        <th>Team Name</th>
                        <th>Sport</th>
                        <th>Level</th>
                        <th>Season</th>
                        <th>Max Players</th>
                        <th>Coach</th>
                        <th>Team Members</th>
                    </tr>

                    <xsl:for-each select="SportsClub/Teams/Team">
                        <xsl:sort select="sport"/>
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="sport"/></td>
                            <td><xsl:value-of select="level"/></td>
                            <td><xsl:value-of select="season"/></td>
                            <td><xsl:value-of select="maxPlayers"/></td>

                            <td>
                                <xsl:variable name="teamId" select="id"/>
                                <xsl:variable name="coachId" select="/SportsClub/CoachingAssignments/CoachingAssignment[teamId=$teamId]/coachId"/>
                                <xsl:value-of select="/SportsClub/Coaches/Coach[id=$coachId]/firstName"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="/SportsClub/Coaches/Coach[id=$coachId]/lastName"/>
                            </td>

                            <td>
                                <xsl:variable name="currentTeamId" select="id"/>
                                <xsl:for-each select="/SportsClub/TeamMemberships/TeamMembership[teamId=$currentTeamId]">
                                    <xsl:variable name="memberId" select="memberId"/>
                                    <xsl:value-of select="/SportsClub/Members/Member[id=$memberId]/firstName"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="/SportsClub/Members/Member[id=$memberId]/lastName"/>
                                    <xsl:if test="position() != last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
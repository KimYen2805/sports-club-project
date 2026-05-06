<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>Training Schedule</title>
    <style>
        body{
            font-family: Arial;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h1{
            text-align:center;
            color:#333;
        }
        table{
            width:100%;
            border-collapse:collapse;
            background:white;
        }
        th{
            background:#2c3e50;
            color:white;
            padding:10px;
        }
        td{
            border:1px solid #ddd;
            padding:8px;
            text-align:center;
        }
        tr:nth-child(even){
            background:#f2f2f2;
        }
    </style>
</head>

<body>

<h1>Training Schedule</h1>

<table>
    <tr>
        <th>ID</th>
        <th>Team</th>
        <th>Coach</th>
        <th>Date</th>
        <th>Start Time</th>
        <th>Duration</th>
        <th>Location</th>
    </tr>

    <xsl:for-each select="SportsClub/TrainingSessions/TrainingSession">
        <xsl:sort select="date"/>

        <tr>
            <td><xsl:value-of select="id"/></td>

            <td>
                <xsl:value-of select="/SportsClub/Teams/Team[id=current()/teamId]/name"/>
            </td>

            <td>
                <xsl:value-of select="/SportsClub/Coaches/Coach[id=current()/coachId]/firstName"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="/SportsClub/Coaches/Coach[id=current()/coachId]/lastName"/>
            </td>

            <td><xsl:value-of select="date"/></td>
            <td><xsl:value-of select="startTime"/></td>
            <td><xsl:value-of select="duration"/> min</td>
            <td><xsl:value-of select="location"/></td>
        </tr>
    </xsl:for-each>

</table>

</body>
</html>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>Facility Bookings</title>
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

<h1>Facility Booking Report</h1>

<table>
    <tr>
        <th>Booking Type</th>
        <th>Booking ID</th>
        <th>Facility</th>
        <th>Related Session / Competition</th>
        <th>Date</th>
        <th>Start Time</th>
        <th>End Time</th>
    </tr>

    <xsl:for-each select="SportsClub/TrainingBookings/TrainingBooking">
        <tr>
            <td>Training</td>
            <td><xsl:value-of select="id"/></td>

            <td>
                <xsl:value-of select="/SportsClub/Facilities/Facility[id=current()/facilityId]/name"/>
            </td>

            <td>
                Training Session <xsl:value-of select="trainingSessionId"/>
            </td>

            <td><xsl:value-of select="date"/></td>
            <td><xsl:value-of select="startTime"/></td>
            <td><xsl:value-of select="endTime"/></td>
        </tr>
    </xsl:for-each>

    <xsl:for-each select="SportsClub/CompetitionBookings/CompetitionBooking">
        <tr>
            <td>Competition</td>
            <td><xsl:value-of select="id"/></td>

            <td>
                <xsl:value-of select="/SportsClub/Facilities/Facility[id=current()/facilityId]/name"/>
            </td>

            <td>
                <xsl:value-of select="/SportsClub/Competitions/Competition[id=current()/competitionId]/name"/>
            </td>

            <td><xsl:value-of select="date"/></td>
            <td><xsl:value-of select="startTime"/></td>
            <td><xsl:value-of select="endTime"/></td>
        </tr>
    </xsl:for-each>

</table>

</body>
</html>
</xsl:template>

</xsl:stylesheet>
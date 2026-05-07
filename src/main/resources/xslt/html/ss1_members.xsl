<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>Member List</title>

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

        .active{
            color:green;
            font-weight:bold;
        }

        .inactive{
            color:red;
            font-weight:bold;
        }
    </style>
</head>

<body>

<h1>Member Information</h1>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Sport</th>
        <th>Level</th>
        <th>Plan</th>
        <th>Fee</th>
        <th>Status</th>
    </tr>

    <xsl:for-each select="SportsClub/Members/Member">
    <tr>

        <td><xsl:value-of select="id"/></td>

        <td>
            <xsl:value-of select="firstName"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="lastName"/>
        </td>

        <td><xsl:value-of select="email"/></td>
        <td><xsl:value-of select="sport"/></td>
        <td><xsl:value-of select="level"/></td>

        <td>
            <xsl:value-of select="/SportsClub/Memberships/Membership[memberId=current()/id]/plan"/>
        </td>

        <td>
            <xsl:value-of select="/SportsClub/Memberships/Membership[memberId=current()/id]/fee"/>
        </td>

        <td>
            <xsl:choose>
                <xsl:when test="/SportsClub/Memberships/Membership[memberId=current()/id]/status='Active'">
                    <span class="active">Active</span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="inactive">No Membership</span>
                </xsl:otherwise>
            </xsl:choose>
        </td>

    </tr>
    </xsl:for-each>

</table>

</body>
</html>
</xsl:template>

</xsl:stylesheet>   
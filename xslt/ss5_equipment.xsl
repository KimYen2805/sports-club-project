<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>Equipment</title>
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

<h1>Equipment Inventory</h1>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Type</th>
        <th>Condition</th>
        <th>Quantity</th>
        <th>Facility</th>
    </tr>

    <xsl:for-each select="SportsClub/Equipments/Equipment">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="type"/></td>
            <td><xsl:value-of select="condition"/></td>
            <td><xsl:value-of select="quantity"/></td>
            <td>
                <xsl:value-of select="/SportsClub/Facilities/Facility[id=current()/facilityId]/name"/>
            </td>
        </tr>
    </xsl:for-each>

</table>

</body>
</html>
</xsl:template>

</xsl:stylesheet>
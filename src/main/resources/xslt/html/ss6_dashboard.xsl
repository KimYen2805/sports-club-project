<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
<head>
<title>Club Dashboard</title>
<style>
body{
    font-family:Arial;
    background:#f4f4f4;
    text-align:center;
}
h1{
    margin-top:30px;
}
.container{
    display:flex;
    flex-wrap:wrap;
    justify-content:center;
}
.card{
    background:white;
    margin:20px;
    padding:30px;
    width:220px;
    border-radius:10px;
    box-shadow:0 4px 8px rgba(0,0,0,0.2);
}
.number{
    font-size:40px;
    font-weight:bold;
    color:#2c3e50;
}
.label{
    font-size:20px;
}
</style>
</head>

<body>
<h1>Sports Club Dashboard</h1>

<div class="container">

<div class="card">
<div class="number"><xsl:value-of select="count(SportsClub/Members/Member)"/></div>
<div class="label">Members</div>
</div>

<div class="card">
<div class="number"><xsl:value-of select="count(SportsClub/Coaches/Coach)"/></div>
<div class="label">Coaches</div>
</div>

<div class="card">
<div class="number"><xsl:value-of select="count(SportsClub/Teams/Team)"/></div>
<div class="label">Teams</div>
</div>

<div class="card">
<div class="number"><xsl:value-of select="count(SportsClub/Facilities/Facility)"/></div>
<div class="label">Facilities</div>
</div>

<div class="card">
<div class="number"><xsl:value-of select="count(SportsClub/Equipments/Equipment)"/></div>
<div class="label">Equipment</div>
</div>

<div class="card">
<div class="number"><xsl:value-of select="count(SportsClub/Memberships/Membership[status='Active'])"/></div>
<div class="label">Active Memberships</div>
</div>

</div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>
  <xsl:key name="membership-by-member" match="Membership" use="memberId"/>

  <xsl:template match="/SportsClub">
    <html>
      <head>
        <title>Sports Club Members Report</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 24px; }
          table { border-collapse: collapse; width: 100%; }
          th, td { border: 1px solid #cccccc; padding: 8px; text-align: left; }
          th { background-color: #f3f3f3; }
        </style>
      </head>
      <body>
        <h1>Sports Club Members Report</h1>
        <p>Example test stylesheet for M4 local integration only.</p>
        <table>
          <tr>
            <th>ID</th><th>Name</th><th>Sport</th><th>Level</th><th>Email</th><th>Plan</th><th>Status</th>
          </tr>
          <xsl:for-each select="Members/Member">
            <xsl:sort select="lastName"/>
            <xsl:variable name="mid" select="id"/>
            <xsl:variable name="membership" select="key('membership-by-member', $mid)[1]"/>
            <tr>
              <td><xsl:value-of select="id"/></td>
              <td><xsl:value-of select="concat(firstName, ' ', lastName)"/></td>
              <td><xsl:value-of select="sport"/></td>
              <td><xsl:value-of select="level"/></td>
              <td><xsl:value-of select="email"/></td>
              <td><xsl:value-of select="$membership/plan"/></td>
              <td><xsl:value-of select="$membership/status"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

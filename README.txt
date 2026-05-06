SportsClubJavaProject_M2_M3_Combined
===================================

This is the Java-only version of the Sports Club project after merging both M2 HTML work and M3 XML/JSON transformation work.

What is integrated:
- M2 HTML XSLT files under src/main/resources/xslt/html
- M2 generated HTML outputs under outputs/html
- M2 integration notes under docs/m2/integration-notes.md
- M3 XML and XSD under src/main/resources/data
- M3 XSLT files for XML and JSON scenarios under src/main/resources/xslt/xml and xslt/json
- M3 generated outputs under outputs/xml and outputs/json
- M3 notes under docs/m3/rapport_m3.md
- M4 Java pipeline as src/main/java/Main.java

Folder highlights:
- src/main/resources/data/SportsClub.xml
- src/main/resources/data/SportsClub.xsd
- src/main/resources/xslt/html/ss1_members.xsl ... ss6_dashboard.xsl
- src/main/resources/xslt/xml/ss7_calendar.xsl
- src/main/resources/xslt/xml/ss8_roster.xsl
- src/main/resources/xslt/json/ss9_bookings.xsl
- src/main/resources/xslt/json/ss10_members.xsl
- outputs/html/ss1.html ... ss6_dashboard.html
- outputs/xml/ss7.xml, ss8.xml, ss7_main_output.xml
- outputs/json/ss9.json, ss10.json, ss9_schema.json

Default run:
  mvn compile exec:java

That default run uses:
- XML: src/main/resources/data/SportsClub.xml
- XSD: src/main/resources/data/SportsClub.xsd
- XSL: src/main/resources/xslt/xml/ss7_calendar.xsl
- Output: outputs/xml/ss7_main_output.xml

Example runs:
1) Run an M2 HTML scenario with default XML/XSD
   mvn compile exec:java -Dexec.args="src/main/resources/xslt/html/ss1_members.xsl outputs/html/ss1_from_java.html"

2) Run M2 training schedule HTML
   mvn compile exec:java -Dexec.args="src/main/resources/xslt/html/ss2_training.xsl outputs/html/ss2_training_from_java.html"

3) Run M3 SS8 roster export with default XML/XSD
   mvn compile exec:java -Dexec.args="src/main/resources/xslt/xml/ss8_roster.xsl outputs/xml/ss8_from_java.xml"

4) Run M3 SS9 JSON export with default XML/XSD
   mvn compile exec:java -Dexec.args="src/main/resources/xslt/json/ss9_bookings.xsl outputs/json/ss9_from_java.json"

5) Run SS10 JSON export with explicit XML/XSD/XSL/output
   mvn compile exec:java -Dexec.args="src/main/resources/data/SportsClub.xml src/main/resources/data/SportsClub.xsd src/main/resources/xslt/json/ss10_members.xsl outputs/json/ss10_from_java.json"

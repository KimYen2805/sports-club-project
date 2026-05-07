from lxml import etree

xml_file = "SportsClub.xml"
xsl_file = "xslt/ss3_teams.xsl"
output_file = "outputs/ss3.html"

xml = etree.parse(xml_file)
xsl = etree.parse(xsl_file)

transform = etree.XSLT(xsl)
result = transform(xml)

with open(output_file, "w", encoding="utf-8") as file:
    file.write(str(result))

print("done")
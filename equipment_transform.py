from lxml import etree

xml_file = "SportsClub.xml"
xsl_file = "xslt/ss5_equipment.xsl"
output_file = "outputs/ss5_equipment.html"

xml = etree.parse(xml_file)
xsl = etree.parse(xsl_file)

transform = etree.XSLT(xsl)
result = transform(xml)

with open(output_file, "w", encoding="utf-8") as file:
    file.write(str(result))

print("done")
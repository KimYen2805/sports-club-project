from lxml import etree

xml_file = "SportsClub.xml"
xsl_file = "xslt/ss4_bookings.xsl"
output_file = "outputs/ss4_bookings.html"

xml = etree.parse(xml_file)
xsl = etree.parse(xsl_file)

transform = etree.XSLT(xsl)
result = transform(xml)

with open(output_file, "w", encoding="utf-8") as file:
    file.write(str(result))

print("done")
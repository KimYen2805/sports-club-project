# main.py - Load, parse, validate and transform SportsClub XML
# Uses lxml library for XML processing

from lxml import etree
import os

# File paths
XML_FILE  = "SportsClub.xml"
XSD_FILE  = "SportsClub.xsd"
XSL_FILE  = "xslt/ss7_calendar.xsl"
OUT_FILE  = "outputs/ss7_main_output.xml"

# 1. Load and parse XML
xml_tree = etree.parse(XML_FILE)
print("XML loaded and parsed successfully.")

# 2. Load and parse XSD, then validate
xsd_tree   = etree.parse(XSD_FILE)
xsd_schema = etree.XMLSchema(xsd_tree)

if xsd_schema.validate(xml_tree):
    print("XML is valid against the schema.")
else:
    print("XML is NOT valid:")
    for error in xsd_schema.error_log:
        print(" -", error.message)

# 3. Load and apply XSLT stylesheet
xsl_tree   = etree.parse(XSL_FILE)
transform  = etree.XSLT(xsl_tree)
result     = transform(xml_tree)

# 4. Save output
with open(OUT_FILE, "wb") as f:
    f.write(bytes(result))
print(f"Transformation done. Output saved to {OUT_FILE}")
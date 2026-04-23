# main.py - Load, parse, validate and transform SportsClub XML
# Uses lxml library for XML processing

from lxml import etree
import sys
import os

# File paths
XML_FILE = "SportsClub.xml"
XSD_FILE = "SportsClub.xsd"
XSL_FILE = "xslt/ss7_calendar.xsl"
OUT_FILE = "outputs/ss7_main_output.xml"

# 1. Load and parse XML
try:
    xml_tree = etree.parse(XML_FILE)
    print("XML loaded and parsed successfully.")
except etree.XMLSyntaxError as e:
    print(f"Error parsing XML: {e}")
    sys.exit(1)

# 2. Load and parse XSD, then validate
try:
    xsd_tree   = etree.parse(XSD_FILE)
    xsd_schema = etree.XMLSchema(xsd_tree)
except etree.XMLSchemaParseError as e:
    print(f"Error parsing XSD: {e}")
    sys.exit(1)

if xsd_schema.validate(xml_tree):
    print("XML is valid against the schema.")
else:
    print("XML is NOT valid:")
    for error in xsd_schema.error_log:
        print(" -", error.message)
    sys.exit(1)

# 3. Load and apply XSLT stylesheet
try:
    xsl_tree  = etree.parse(XSL_FILE)
    transform = etree.XSLT(xsl_tree)
    result    = transform(xml_tree)
except etree.XSLTParseError as e:
    print(f"Error parsing XSL: {e}")
    sys.exit(1)

# 4. Save output
try:
    with open(OUT_FILE, "wb") as f:
        f.write(bytes(result))
    print(f"Transformation done. Output saved to {OUT_FILE}")
except IOError as e:
    print(f"Error writing output: {e}")
    sys.exit(1)
#!/usr/bin/env python3
"""Shared helper for M2 HTML transformation scripts in the Maven-style project."""
from __future__ import annotations

from pathlib import Path
from lxml import etree

SCRIPT_FILE = Path(__file__).resolve()
PROJECT_ROOT = SCRIPT_FILE.parents[4]
DEFAULT_XML_FILE = PROJECT_ROOT / "src" / "main" / "resources" / "data" / "SportsClub.xml"
DEFAULT_XSL_DIR = PROJECT_ROOT / "src" / "main" / "resources" / "xslt" / "html"
DEFAULT_OUTPUT_DIR = PROJECT_ROOT / "outputs" / "html"


def run_transform(xsl_name: str, output_name: str) -> int:
    xml_file = DEFAULT_XML_FILE
    xsl_file = DEFAULT_XSL_DIR / xsl_name
    output_file = DEFAULT_OUTPUT_DIR / output_name

    if not xml_file.exists():
        print(f"XML file not found: {xml_file}")
        return 2
    if not xsl_file.exists():
        print(f"XSL file not found: {xsl_file}")
        return 3

    try:
        xml = etree.parse(str(xml_file))
        xsl = etree.parse(str(xsl_file))
        transform = etree.XSLT(xsl)
        result = transform(xml)
        output_file.parent.mkdir(parents=True, exist_ok=True)
        with open(output_file, "w", encoding="utf-8") as file:
            file.write(str(result))
        print(f"Done. Output written to {output_file}")
        return 0
    except Exception as error:
        print(f"Transformation failed: {error}")
        return 99

#!/usr/bin/env python3
"""
Combined Python pipeline for the Sports Club project.

This file is based on M3's updated Python code and adapted to the same
project structure used by the Java version.

Default behavior:
- XML: src/main/resources/data/SportsClub.xml
- XSD: src/main/resources/data/SportsClub.xsd
- XSL: src/main/resources/xslt/xml/ss7_calendar.xsl
- Output: outputs/xml/ss7_main_output.xml

Supported modes:
- No arguments: run the default M3 SS7 scenario.
- Two arguments: <xsl_file> <output_file> using default XML/XSD.
- Four arguments: <xml_file> <xsd_file> <xsl_file> <output_file>.
"""

from __future__ import annotations

import sys
from pathlib import Path
from lxml import etree


SCRIPT_FILE = Path(__file__).resolve()
PROJECT_ROOT = SCRIPT_FILE.parents[3]
DEFAULT_XML_FILE = PROJECT_ROOT / "src" / "main" / "resources" / "data" / "SportsClub.xml"
DEFAULT_XSD_FILE = PROJECT_ROOT / "src" / "main" / "resources" / "data" / "SportsClub.xsd"
DEFAULT_XSL_FILE = PROJECT_ROOT / "src" / "main" / "resources" / "xslt" / "xml" / "ss7_calendar.xsl"
DEFAULT_OUT_FILE = PROJECT_ROOT / "outputs" / "xml" / "ss7_main_output.xml"


def resolve_paths() -> tuple[Path, Path, Path, Path]:
    args = sys.argv[1:]
    if len(args) == 0:
        return DEFAULT_XML_FILE, DEFAULT_XSD_FILE, DEFAULT_XSL_FILE, DEFAULT_OUT_FILE
    if len(args) == 2:
        return DEFAULT_XML_FILE, DEFAULT_XSD_FILE, Path(args[0]).resolve(), Path(args[1]).resolve()
    if len(args) == 4:
        return tuple(Path(arg).resolve() for arg in args)

    print("Usage:")
    print("  python src/main/python/main.py")
    print("  python src/main/python/main.py <xsl_file> <output_file>")
    print("  python src/main/python/main.py <xml_file> <xsd_file> <xsl_file> <output_file>")
    raise SystemExit(1)


def ensure_file_exists(file_path: Path, label: str) -> None:
    if not file_path.exists() or not file_path.is_file():
        raise FileNotFoundError(f"{label} file not found: {file_path}")


def load_xml(xml_path: Path) -> etree._ElementTree:
    parser = etree.XMLParser(remove_blank_text=True)
    return etree.parse(str(xml_path), parser)


def load_schema(xsd_path: Path) -> etree.XMLSchema:
    xsd_tree = etree.parse(str(xsd_path))
    return etree.XMLSchema(xsd_tree)


def validate_xml(xml_tree: etree._ElementTree, schema: etree.XMLSchema) -> None:
    if schema.validate(xml_tree):
        print("XML is valid against the schema.")
        return

    print("XML is NOT valid:")
    for error in schema.error_log:
        print(f" - Line {error.line}: {error.message}")
    raise SystemExit(2)


def transform_xml(xml_tree: etree._ElementTree, xsl_path: Path) -> etree._XSLTResultTree:
    xsl_tree = etree.parse(str(xsl_path))
    transform = etree.XSLT(xsl_tree)
    return transform(xml_tree)


def write_output(result: etree._XSLTResultTree, out_path: Path) -> None:
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with open(out_path, "wb") as handle:
        handle.write(bytes(result))


def main() -> int:
    xml_file, xsd_file, xsl_file, out_file = resolve_paths()

    try:
        ensure_file_exists(xml_file, "XML")
        ensure_file_exists(xsd_file, "XSD")
        ensure_file_exists(xsl_file, "XSL")

        print(f"Project root: {PROJECT_ROOT}")
        print(f"XML path: {xml_file}")
        print(f"XSD path: {xsd_file}")
        print(f"XSL path: {xsl_file}")
        print(f"Output path: {out_file}")
        print()

        xml_tree = load_xml(xml_file)
        print("XML loaded and parsed successfully.")

        schema = load_schema(xsd_file)
        validate_xml(xml_tree, schema)

        result = transform_xml(xml_tree, xsl_file)
        write_output(result, out_file)
        print(f"Transformation done. Output saved to {out_file}")
        return 0

    except FileNotFoundError as error:
        print(error)
        return 3
    except etree.XMLSyntaxError as error:
        print(f"XML syntax error: {error}")
        return 4
    except etree.XMLSchemaParseError as error:
        print(f"XSD schema parse error: {error}")
        return 5
    except etree.XSLTParseError as error:
        print(f"XSLT parse error: {error}")
        return 6
    except Exception as error:
        print(f"Unexpected error: {error}")
        return 99


if __name__ == "__main__":
    raise SystemExit(main())

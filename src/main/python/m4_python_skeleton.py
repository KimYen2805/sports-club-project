#!/usr/bin/env python3
"""
M4 early Python skeleton for the A25 Data Pipeline project.

Purpose:
- Load an XML file.
- Parse it with lxml.
- Load the XSD schema.
- Validate the XML against the XSD.

Important project scope note:
This file is intentionally limited to XML loading + parsing + XSD validation.
It does NOT apply XSLT because the full Python transform pipeline belongs to M3
in the project plan.

Default behavior:
- If you run this script with no arguments, it automatically uses the Maven-style
  project paths:
    src/main/resources/data/SportsClub.xml
    src/main/resources/data/SportsClub.xsd
- If you provide two arguments, those paths are used instead.
"""

from __future__ import annotations

import sys
from pathlib import Path
from lxml import etree


SCRIPT_FILE = Path(__file__).resolve()
PROJECT_ROOT = SCRIPT_FILE.parent.parent
DEFAULT_XML_PATH = PROJECT_ROOT / "src" / "main" / "resources" / "data" / "SportsClub.xml"
DEFAULT_XSD_PATH = PROJECT_ROOT / "src" / "main" / "resources" / "data" / "SportsClub.xsd"


def check_file_exists(file_path: Path) -> None:
    """Stop the program early if a required file is missing."""
    if not file_path.exists():
        raise FileNotFoundError(f"File not found: {file_path}")
    if not file_path.is_file():
        raise FileNotFoundError(f"Path is not a file: {file_path}")



def load_xml_tree(xml_path: Path) -> etree._ElementTree:
    """
    Parse the XML file and return an lxml ElementTree.

    We remove blank text to make the parsed tree a little cleaner.
    """
    parser = etree.XMLParser(remove_blank_text=True)
    return etree.parse(str(xml_path), parser)



def load_xsd_schema(xsd_path: Path) -> etree.XMLSchema:
    """Parse the XSD file and build an XMLSchema validator object."""
    xsd_tree = etree.parse(str(xsd_path))
    return etree.XMLSchema(xsd_tree)



def validate_xml(xml_tree: etree._ElementTree, schema: etree.XMLSchema) -> bool:
    """
    Validate the XML tree against the schema.

    Returns:
        True if valid, False if invalid.
    """
    return schema.validate(xml_tree)



def print_schema_errors(schema: etree.XMLSchema) -> None:
    """Print validation errors in a beginner-friendly format."""
    if not schema.error_log:
        print("No schema validation errors were recorded.")
        return

    print("Validation errors found:")
    for error in schema.error_log:
        print(
            f"- Line {error.line}, column {error.column}: "
            f"{error.message}"
        )



def resolve_input_paths() -> tuple[Path, Path]:
    """
    Resolve input paths from command-line arguments or Maven-style defaults.

    Supported modes:
    - No arguments: use the default Maven-style resource paths.
    - Two arguments: use <xml_file> <xsd_file> provided by the user.
    """
    args = sys.argv[1:]

    if len(args) == 0:
        return DEFAULT_XML_PATH, DEFAULT_XSD_PATH

    if len(args) == 2:
        return Path(args[0]).resolve(), Path(args[1]).resolve()

    print("Usage: python python/m4_python_skeleton.py [<xml_file> <xsd_file>]")
    print("- Run with no arguments to use Maven-style default paths automatically.")
    print("- Or pass both XML and XSD paths manually.")
    raise SystemExit(1)



def main() -> int:
    """Program entry point."""
    xml_path, xsd_path = resolve_input_paths()

    try:
        # Step 1: basic file checks.
        check_file_exists(xml_path)
        check_file_exists(xsd_path)

        # Step 2: load and parse XML + XSD.
        xml_tree = load_xml_tree(xml_path)
        schema = load_xsd_schema(xsd_path)

        # Step 3: show some basic information so the user knows parsing worked.
        root = xml_tree.getroot()
        print(f"Project root: {PROJECT_ROOT}")
        print(f"XML loaded successfully: {xml_path}")
        print(f"Root element: {root.tag}")
        print(f"XSD loaded successfully: {xsd_path}")

        # Step 4: validate the XML file against the schema.
        is_valid = validate_xml(xml_tree, schema)
        if is_valid:
            print("Validation result: XML is valid against the XSD schema.")
            return 0

        print("Validation result: XML is NOT valid against the XSD schema.")
        print_schema_errors(schema)
        return 2

    except etree.XMLSyntaxError as error:
        print(f"XML syntax error: {error}")
        return 3
    except etree.XMLSchemaParseError as error:
        print(f"XSD schema parse error: {error}")
        return 4
    except etree.DocumentInvalid as error:
        print(f"Document validation error: {error}")
        return 5
    except FileNotFoundError as error:
        print(error)
        return 6
    except Exception as error:
        print(f"Unexpected error: {error}")
        return 99


if __name__ == "__main__":
    raise SystemExit(main())

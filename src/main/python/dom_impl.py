#!/usr/bin/env python3
"""
Python-only DOM implementation for one project scenario.

Scenario chosen:
- Generate a simple HTML member report with membership information.

Default behavior:
- If you run this script with no arguments, it automatically uses:
    src/main/resources/data/SportsClub.xml
    outputs/test/dom_members_report.html
- If you provide two arguments, those paths are used instead.
"""

from __future__ import annotations

import html
import sys
from pathlib import Path
from xml.dom import minidom


SCRIPT_FILE = Path(__file__).resolve()
PROJECT_ROOT = SCRIPT_FILE.parents[3]
DEFAULT_XML_PATH = PROJECT_ROOT / "src" / "main" / "resources" / "data" / "SportsClub.xml"
DEFAULT_OUTPUT_PATH = PROJECT_ROOT / "outputs" / "test" / "dom_members_report.html"


def get_text_from_child(parent_node, child_tag: str, default_value: str = "") -> str:
    child_nodes = parent_node.getElementsByTagName(child_tag)
    if not child_nodes:
        return default_value
    child = child_nodes[0]
    if child.firstChild is None:
        return default_value
    return child.firstChild.nodeValue.strip()


def build_membership_map(document: minidom.Document) -> dict[str, dict[str, str]]:
    membership_map: dict[str, dict[str, str]] = {}
    for membership in document.getElementsByTagName("Membership"):
        member_id = get_text_from_child(membership, "memberId")
        membership_map[member_id] = {
            "plan": get_text_from_child(membership, "plan", "N/A"),
            "status": get_text_from_child(membership, "status", "N/A"),
            "startDate": get_text_from_child(membership, "startDate", "N/A"),
            "endDate": get_text_from_child(membership, "endDate", "N/A"),
            "fee": get_text_from_child(membership, "fee", "N/A"),
        }
    return membership_map


def build_html_report(document: minidom.Document) -> str:
    membership_map = build_membership_map(document)
    rows: list[str] = []
    for member in document.getElementsByTagName("Member"):
        member_id = get_text_from_child(member, "id", "N/A")
        first_name = get_text_from_child(member, "firstName", "")
        last_name = get_text_from_child(member, "lastName", "")
        full_name = f"{first_name} {last_name}".strip()
        sport = get_text_from_child(member, "sport", "N/A")
        level = get_text_from_child(member, "level", "N/A")
        email = get_text_from_child(member, "email", "N/A")
        membership_info = membership_map.get(
            member_id,
            {"plan": "No membership", "status": "N/A", "startDate": "N/A", "endDate": "N/A", "fee": "N/A"},
        )
        rows.append(
            "<tr>"
            f"<td>{html.escape(member_id)}</td>"
            f"<td>{html.escape(full_name)}</td>"
            f"<td>{html.escape(sport)}</td>"
            f"<td>{html.escape(level)}</td>"
            f"<td>{html.escape(email)}</td>"
            f"<td>{html.escape(membership_info['plan'])}</td>"
            f"<td>{html.escape(membership_info['status'])}</td>"
            f"<td>{html.escape(membership_info['startDate'])}</td>"
            f"<td>{html.escape(membership_info['endDate'])}</td>"
            f"<td>{html.escape(membership_info['fee'])}</td>"
            "</tr>"
        )
    table_rows = "\n".join(rows)
    return f"""<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <title>Sports Club Members Report</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 24px; }}
        table {{ border-collapse: collapse; width: 100%; margin-top: 16px; }}
        th, td {{ border: 1px solid #cccccc; padding: 8px; text-align: left; }}
        th {{ background-color: #f3f3f3; }}
        tr:nth-child(even) {{ background-color: #fafafa; }}
    </style>
</head>
<body>
    <h1>Sports Club Members Report</h1>
    <p>Optional Python DOM implementation. This report combines member and membership data without using XSLT.</p>
    <table>
        <thead>
            <tr>
                <th>Member ID</th>
                <th>Full Name</th>
                <th>Sport</th>
                <th>Level</th>
                <th>Email</th>
                <th>Plan</th>
                <th>Status</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Fee</th>
            </tr>
        </thead>
        <tbody>
            {table_rows}
        </tbody>
    </table>
</body>
</html>
"""


def resolve_input_paths() -> tuple[Path, Path]:
    args = sys.argv[1:]
    if len(args) == 0:
        return DEFAULT_XML_PATH, DEFAULT_OUTPUT_PATH
    if len(args) == 2:
        return Path(args[0]).resolve(), Path(args[1]).resolve()
    print("Usage: python src/main/python/dom_impl.py [<xml_file> <output_html_file>]")
    print("- Run with no arguments to use project default paths automatically.")
    print("- Or pass both XML and output HTML paths manually.")
    raise SystemExit(1)


def main() -> int:
    xml_path, output_path = resolve_input_paths()
    try:
        if not xml_path.exists() or not xml_path.is_file():
            raise FileNotFoundError(f"XML file not found: {xml_path}")
        document = minidom.parse(str(xml_path))
        html_output = build_html_report(document)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(html_output, encoding="utf-8")
        print(f"Project root: {PROJECT_ROOT}")
        print(f"XML loaded successfully: {xml_path}")
        print(f"DOM report created successfully: {output_path}")
        return 0
    except FileNotFoundError as error:
        print(error)
        return 2
    except Exception as error:
        print(f"Unexpected error: {error}")
        return 99


if __name__ == "__main__":
    raise SystemExit(main())

SportsClubPythonProject_M2_M3_Combined
======================================

This is the Python-only version of the Sports Club project after merging both M2 HTML work and M3 XML/JSON transformation work.
It keeps the same overall structure as the Java project: docs, outputs, src/main/resources, and src/test/resources.
The main language-specific difference is that Python code lives in src/main/python.

What is integrated:
- M2 HTML XSLT files under src/main/resources/xslt/html
- M2 generated HTML outputs under outputs/html
- M2 Maven-style helper scripts under src/main/python/m2_html
- M2 integration notes under docs/m2/integration-notes.md
- M3 XML and XSD under src/main/resources/data
- M3 XSLT files for XML and JSON scenarios under src/main/resources/xslt/xml and xslt/json
- M3 generated outputs under outputs/xml and outputs/json
- M3 report notes under docs/m3/rapport_m3.md
- M3 full Python pipeline as src/main/python/main.py
- M4 validation-only helper as src/main/python/m4_python_skeleton.py
- M4 optional DOM helper as src/main/python/dom_impl.py

Default paths used by main.py:
- XML: src/main/resources/data/SportsClub.xml
- XSD: src/main/resources/data/SportsClub.xsd
- XSL: src/main/resources/xslt/xml/ss7_calendar.xsl
- Output: outputs/xml/ss7_main_output.xml

Default paths used by m4_python_skeleton.py:
- XML: src/main/resources/data/SportsClub.xml
- XSD: src/main/resources/data/SportsClub.xsd

Default paths used by dom_impl.py:
- XML: src/main/resources/data/SportsClub.xml
- Output: outputs/test/dom_members_report.html

Install dependencies:
  pip install -r requirements.txt

Example runs:
1) Run M3 default pipeline (SS7)
   python src/main/python/main.py

2) Run M2 SS1 members HTML with the generic M3 pipeline
   python src/main/python/main.py src/main/resources/xslt/html/ss1_members.xsl outputs/html/ss1_from_python.html

3) Run M2 SS4 bookings HTML with the dedicated M2 wrapper
   python src/main/python/m2_html/ss4_bookings_transform.py

4) Run M3 SS9 JSON export with explicit XML/XSD/XSL/output
   python src/main/python/main.py src/main/resources/data/SportsClub.xml src/main/resources/data/SportsClub.xsd src/main/resources/xslt/json/ss9_bookings.xsl outputs/json/ss9_from_python.json

5) Run M4 validation-only helper
   python src/main/python/m4_python_skeleton.py

6) Run M4 DOM helper
   python src/main/python/dom_impl.py

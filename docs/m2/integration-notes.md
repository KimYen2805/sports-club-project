M2 integration notes
====================

Added HTML scenario assets from the uploaded M2 package.

Integrated XSLT files:
- ss1_members.xsl
- ss2_training.xsl
- ss3_teams.xsl
- ss4_bookings.xsl
- ss5_equipment.xsl
- ss6_dashboard.xsl

Integrated HTML outputs:
- ss1.html
- ss2_training.html
- ss3.html
- ss4_bookings.html
- ss5_equipment.html
- ss6_dashboard.html

Notes:
- The M2 stylesheets were validated against the current project XML and produced output successfully.
- M3 remains the default transformation path in Main.java and main.py.
- The Python project also contains Maven-style wrapper scripts under src/main/python/m2_html/ to run the six M2 HTML scenarios directly.

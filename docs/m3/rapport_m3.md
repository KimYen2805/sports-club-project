## M3 — Tools, Environment & Scenarios

### Working Environment & Tools

Development was carried out on macOS using Visual Studio Code as the main editor.
Saxon (installed via Homebrew) was used to run and test all XSLT transformations from the command line.
Python 3 with the lxml library was used for the programmatic pipeline.
Git and GitHub were used for version control and collaboration, with a dedicated branch `m3-transforms`.

### Scenarios Description

**SS7 — Competition Calendar (XML → XML)**
Transforms the club database into a calendar-style XML format. For each competition, the output includes its name, format, dates, prize, the booked facility (cross-referenced via CompetitionBookings and Facilities), and the list of participating teams with their results (cross-referenced via CompetitionParticipations and Teams). Results are sorted by start date. Implemented using recursive `xsl:apply-templates` with dedicated templates for CompetitionBooking and CompetitionParticipation.

**SS8 — Member Roster (XML → XML)**
Produces a structured XML roster organized by team, sorted alphabetically. For each team, the output lists the assigned coaches (cross-referenced via CoachingAssignments and Coaches) and all players (cross-referenced via TeamMemberships and Members) with their sport, level, and join date. Implemented using recursive `xsl:apply-templates` with dedicated templates for CoachingAssignment and TeamMembership.

**SS9 — Bookings Export (XML → JSON)**
Exports all facility bookings to JSON, split into two arrays: training bookings and competition bookings. Each training booking includes the facility name, session id, date and times. Each competition booking includes the facility name, competition name, date and times. Comma placement between array items is handled with `xsl:if test="position() != last()"`.

**SS10 — Members & Memberships Export (XML → JSON)**
Exports all members to JSON sorted by last name, each with their personal details and their membership information if it exists (plan, fee, status, dates). Members without a membership get a null value, handled via a dedicated Membership template and `xsl:if test="not($membership)"`.

### Complex Scenario: SS9

SS9 required handling two structurally different booking types (TrainingBookings and CompetitionBookings) in a single JSON output. Each booking type cross-references the Facilities table to resolve the facility name from its ID. CompetitionBookings additionally cross-reference the Competitions table to include the competition name. The challenge was producing valid JSON with correct comma placement between array items, and managing two separate template matches within the same stylesheet for structurally similar but semantically different entities.
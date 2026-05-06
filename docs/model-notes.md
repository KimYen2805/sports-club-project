# Model notes

This folder documents the gap between the ERD, the sample XML data, and the practical code layout.

## Main observations from the ERD review

1. The project should be organized by artifact type, not by entity.
   The ERD is a logical model for the sports club database. The repository should therefore be grouped into XML, XSD, XSLT, Java, Python, outputs, and docs.

2. The sample XML includes a `Member/email` element.
   The shared ERD image does not display `email` in the Member box, but the XML database does contain it, so the XSD in this package supports it.

3. `TeamMembership` should logically connect `Member` and `Team`.
   The visual arrowing in the ERD makes `Membership -> TeamMembership` look stronger than it should be. In the XML model, `TeamMembership` uses `memberId` and `teamId`, which is the cleaner implementation.

4. `TrainingSession` carries `coachId` directly.
   The ERD emphasizes `CoachingAssignment`, but the sample XML also stores the direct coach responsible for a training session. The XSD keeps that field because it exists in the data.

5. The XSLT folders are grouped by required output type.
   That matches the assignment requirement: HTML scenarios, XML scenarios, and JSON scenarios.

## M3 merge notes

- The data and schema in this combined package come from the uploaded M3 update so the XSLT files, Python pipeline, and saved outputs remain consistent with each other.
- XML and JSON transform scenarios currently available in this package are SS7, SS8, SS9, and SS10.
- The HTML scenario folders remain placeholders because M2 deliverables were not included in the uploaded M3 update package.

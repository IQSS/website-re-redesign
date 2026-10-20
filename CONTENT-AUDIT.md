# Content audit: copy that is not yours and not on the live site

Compiled 2026-10-20 against https://www.iq.harvard.edu. Everything below
was written by Claude. Nothing here came from you, and nothing here has a
verbatim source on the live site. Each item needs your approval, a
replacement, or a decision to delete.

Items marked DIVERGENT do have a live counterpart but the wording differs.

---

## 1. Interface strings on event pages

| String | Where | Note |
|---|---|---|
| About this series | series band eyebrow, every event page | live has no label on this block |
| Event Type | event page metadata label | DIVERGENT: live says "See also:" |
| Join the mailing list | fallback when a series sets no label | unused today; all three series set their own |
| Series page | fallback link label | same |

"Date and Time", "Location", "Speaker & Title" and "Abstract" all match
the live event pages verbatim and are not listed here.

## 2. Interface strings on list and term pages

| String | Where |
|---|---|
| Upcoming | term pages |
| Past Sessions | term pages |
| Ongoing & On-Demand | term pages and the Events landing page |
| TBA | date box for undated sessions |
| No upcoming sessions are currently scheduled. | term pages, empty state |
| No upcoming events are currently scheduled. Please check the calendar for the latest listings. | Events landing page, empty state |
| No upcoming events are currently scheduled. | homepage, empty state |
| All IQSS events -> | term page footer link |
| Recurring office hours and training sessions that run throughout the year. | Events landing, Ongoing section blurb |
| Events by Type | Events landing | DIVERGENT: live says "Upcoming Events by Type" |
| Past Events | Events landing | live's /events page has no past section at all |

The rest of the Events landing page is live copy verbatim: the intro
("Watch our calendar for year-round opportunities..."), "Upcoming
Events", "View all upcoming events", "Research Technology Training" and
its intro paragraph, the seven technology chips, and
"See research technology training events".

## 3. Structural inventions

**The `series` taxonomy is ours.** The live site has no series
vocabulary. It has four event vocabularies -- Event Type, Program,
Research Technology and Service (see TAXONOMIES.md). On live:

- the APRW and Applied Statistics Workshop boilerplate is repeated on
  each event page rather than drawn from a shared term;
- "Alesina Seminar on Political Economy" is a **Program** term;
- "Political Economy Seminar" is a **Service** term.

DECIDED 2026-10-20 (Liz): keep it. A series is a valid grouping for
Alesina, Applied Stats and APRW, and the boilerplate stays attached to
the series taxonomy rather than moving to Program. The /series/ URLs
having no live equivalent is accepted.

Liz also confirmed that the live Service term "Political Economy
Seminar" (51 events) and the Program term "Alesina Seminar on Political
Economy" (129) are the same seminar under its former name -- it was
renamed in Alberto Alesina's memory. So there is no second political
economy series to model, and the Service vocabulary needs no term of
its own here.

**"Ongoing & On-Demand" as a section** is also ours. Live has no
equivalent grouping; undated recurring sessions simply don't appear in
its upcoming list.

## 4. Series front matter

All of this is ours as *labels*, though the URLs it points at are real:

- short_name values: "APRW", "Applied Stats", "Alesina Seminar"
- "Sign up for the APRW mailing list" -- matches live verbatim
- "Join the Applied Stats mailing list" -- matches live verbatim
- "Subscribe to the Alesina Seminar mailing list" -- matches live verbatim
- "Alesina Seminar page" -- OURS, no live source
- course_number "Gov 3004" / "Gov 3009" -- from live boilerplate text

The APRW and Applied Statistics descriptions now match the live event
pages word for word, including the closing "All interested Harvard
affiliates are invited to attend. Lunch will be provided."

## 5. Awaiting your copy

RESOLVED 2026-10-20. The Alesina description is now migrated verbatim
from https://www.iq.harvard.edu/program-political-economy (its first two
paragraphs). My earlier note here was wrong: I had checked the Alesina
term listing, which is bare, and not the seminar page, which carries
full copy.

Still not migrated, by choice: that page's "About the Seminar" history
(two paragraphs on Alberto Alesina and the renaming) and the Seminar
Organizing Committee list. The series band prints on every event page,
so putting the history there would repeat it on all of them. It belongs
on the series page alone if you want it.

Open question for Liz: the seminar's own page is titled "Alberto Alesina
Seminar on Political Economy", but the Program taxonomy term on the same
site drops "Alberto". We follow the taxonomy term. Live is inconsistent
with itself here; tell me which spelling should win.

## 6. Tagging gaps, not copy

- 3 of 24 events carry no event type: Andrea Galeotti (live assigns it
  none), plus two with no live counterpart to check.
- No event carries a Research Technology or Service tag yet. Live tags
  its GIS and Dataverse events heavily. Both vocabularies are
  configured and will populate as soon as events are tagged.
- Our workshops term URL is /event-type/workshops-seminars--classes/
  (double hyphen). This is Hugo's own slugification of the ampersand.
  It is not a divergence from live -- live has no term URLs at all, only
  calendar filters keyed by numeric ID.
- The Alesina series page is missing its Faculty Sponsors grid. That
  section aggregates people, so it is blocked on the People section:
  all 1,075 files in content/people/ are raw scraped Drupal markup with
  only title, draft, date, source_url and section in front matter --
  no headshot, role, email or series link to select on. Details and the
  unblocking steps are in the series page's own front matter.

---

## 7. content/misc/ -- 83 scraped pages needing a decision

These are raw captures of live pages taken 2026-05-26, published as-is.
They build and are publicly reachable, but nothing on the site links to
them. Each one we rebuild properly leaves its snapshot behind as a stale
twin, so a change made on the real page can silently miss the copy --
which is exactly what happened with Jeffry Frieden, who stayed on the
scraped seminar page after being removed from the live one.

Three groups, needing different decisions:

### 7a. Not pages at all -- 15 files, safe to delete

URLs with query strings that were captured as though they were pages:

- 6 calendar event-type filters
  (`calendar?f[0]=event_hwp_c_event_type:115728` and five siblings).
  These are the Drupal facet links behind the live "Events by Type"
  list. We reproduce them as real taxonomy term pages.
- 3 `?admin_panel=1` URLs: dissertation-awards, research-grants,
  travel-grants. Checked -- these are ordinary anonymous page captures,
  no forms, no edit links, nothing sensitive. Still not pages.
- 6 `event/<slug>?occ_id=0` captures, the live calendar's per-occurrence
  event URLs.

### 7b. Duplicates of content we have already rebuilt -- delete or redirect

- `program_political_economy` -> our series page at /series/alesina-seminar/.
  This is the one that kept Frieden alive.
- `calendar` -> our events section and taxonomy term pages.
- `event_better_research_vi_data_sharing_harvard_dataverse_occ_id_0`
  -> content/events/better-research-vi-data-sharing-harvard-dataverse.md

### 7c. Genuine pages not yet rebuilt -- keep until replaced

The remainder are real standalone pages with no home yet, e.g.
become-an-affiliate, book-a-desk, contact-labs, dissertation-awards,
equipment-information, the eight computer-lab-services pages and the
six ECEE pages. These should stay reachable until each is rebuilt, then
be retired with its replacement.

Recommendation: delete 7a outright, retire 7b now that replacements
exist, and treat 7c as the migration backlog. All of it is scraped
Drupal markup, so nothing here is copy anyone wrote for this site.

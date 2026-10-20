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

You asked for a single-source boilerplate widget, so the series
taxonomy is how that was built. But it means
`/series/american-politics-research-workshop/` and
`/series/applied-statistics-workshop/` are pages that have no live
equivalent. Decide whether you want those URLs to exist, or whether the
boilerplate should attach to Program instead.

**"Ongoing & On-Demand" as a section** is also ours. Live has no
equivalent grouping; undated recurring sessions simply don't appear in
its upcoming list.

## 4. Series front matter

All of this is ours as *labels*, though the URLs it points at are real:

- short_name values: "APRW", "Applied Stats", "Alesina Seminar"
- "Sign up for the APRW mailing list" -- matches live verbatim
- "Join the Applied Stats mailing list" -- matches live verbatim
- "Subscribe to the Alesina Seminar mailing list" -- OURS, no live source
- "Alesina Seminar page" -- OURS, no live source
- course_number "Gov 3004" / "Gov 3009" -- from live boilerplate text

The APRW and Applied Statistics descriptions now match the live event
pages word for word, including the closing "All interested Harvard
affiliates are invited to attend. Lunch will be provided."

## 5. Awaiting your copy

`content/series/alesina-seminar-on-political-economy/_index.md` has no
description and no meeting schedule. Earlier drafts had both; both were
invented and have been removed. The live Alesina listing carries no
descriptive text, so there is nothing to migrate. The band renders
correctly without it, but it is thinner than the other two series.

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

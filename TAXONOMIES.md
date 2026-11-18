# Event taxonomies on iq.harvard.edu

Transcribed verbatim from the live calendar's filter panel
(https://www.iq.harvard.edu/calendar), 2026-10-20. Counts are the live
event totals at that date and are recorded only to show relative size.

Terms are generated from tagging: a term page appears here as soon as an
event carries that value, exactly as the live calendar's facets work.
Do not add `_index.md` files under `content/event-type/` etc. to
pre-create unused terms -- doing so makes the term binding fragile
(a term whose urlized name contains a double hyphen silently loses its
`.Pages`). Tag an event instead.

## Event Type

| Term | Live count |
|---|---|
| Conferences & Symposia | 31 |
| Guest Speakers/Talks | 162 |
| Help Desk Office Hours | 715 |
| Holidays | 111 |
| Special Events | 19 |
| Training | 118 |
| Workshops, Seminars & Classes | 1168 |

Note: the /events landing page renders this last term as
"Workshops, Seminars, & Classes" (extra comma). The vocabulary term
itself has no comma. Both spellings are live; ours follows each
context's live source.

## Program

| Term | Live count |
|---|---|
| Alesina Seminar on Political Economy | 129 |
| Center for Geographic Analysis | 72 |
| China Biograhical Database (CBDB) | 2 |
| Data Science Services | 53 |
| Dataverse Project | 449 |
| Human Flourishing Program | 10 |
| Laboratory for Innovation Science (LISH) | 3 |
| OpenDP | 2 |
| Program on Survey Research | 1 |

Note: "Biograhical" is misspelled on the live site. Kept as-is so our
tagging matches; correct it there first if it should change.

## Research Technology

| Term | Live count |
|---|---|
| Data Visualization | 10 |
| Dataverse | 484 |
| GIS | 188 |
| Python | 30 |
| R | 57 |
| RCE | 1 |
| Stata | 24 |
| UNIX | 8 |

The /events landing page lists all of these except Data Visualization.

## Service

| Term | Live count |
|---|---|
| Political Economy Seminar | 51 |

This is the Alesina Seminar under its former name: the Political Economy
Seminar was renamed in Alberto Alesina's memory. It is the same series
as the Program term "Alesina Seminar on Political Economy", so do not
model it as a second series.

## Not on the live site

`series` is ours, not theirs. The live site has no series vocabulary:
the APRW and Applied Statistics Workshop boilerplate is repeated on each
event page rather than drawn from a term, and the Alesina series is a
Program term. See the content audit for what this implies.

## State in Hugo after the events catch-up (2026-11-16)

Event files now carry exactly the tags their live page lists under
"See also", read from the live pages rather than retyped. 96 event files
were refreshed or created from live (everything dated from the original
scrape, 2026-05-26, onward, plus every event that already had a file).

- All four live vocabularies exist in `hugo.toml`: `event-type`, `program`,
  `research-technology`, and now `service`.
- `program` is the same vocabulary the People directory uses, so a Program
  term page lists that programme's events and, below them, its people.
- Terms in use by events: Event Type -- Conferences & Symposia, Help Desk
  Office Hours, Holidays, Special Events, Training, Workshops, Seminars &
  Classes. Program -- Alesina Seminar on Political Economy, Center for
  Geographic Analysis, Dataverse Project, Human Flourishing Program.
  Research Technology -- Dataverse, GIS. Service -- none.
- Live terms with no event in that window (so no term page yet, by the rule
  above): Guest Speakers/Talks; the other five Program terms; Data
  Visualization, Python, R, RCE, Stata, UNIX; Political Economy Seminar.
- The CBDB term is spelled correctly here, by Liz's decision (live:
  "Biograhical"). No event in the window uses it.

What changed from the tags we had before: live tags holidays as
**Holidays** (the old hand-typed calendar called them Special Events), tags
Alesina seminars with Program only (no Event Type), and does not tag the
dated Dataverse Office Hours with Research Technology: Dataverse, which
ours had added.

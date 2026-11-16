# People section audit

State of `/people/` and the parallel `people-*` sections, measured against a
running build and the deployed site on 2026-11-10.

This is the largest unresolved area of the rebuild. Most of it waits on one
editorial decision, recorded at the top.

---

## The decision everything else waits on

**Every person exists two or three times, and all the copies are live.**

| Structure | Files | Example URL | What it is |
|---|---|---|---|
| `content/people/` | 1,075 | `/people/adaner-usmani/` | Raw scraped Drupal, ~4.6 KB each, carries its own `<main>` |
| `content/people/<category>/` | 1,075 | `/people/faculty/adaner-usmani/` | Slim stub, ~0.7 KB, has a `category:` field |
| `content/people-*-profiles/` | 340 | `/people-faculty-profiles/adaner-usmani/` | Curated, ~1.4 KB, carries a real subtitle such as "Assistant Professor of Sociology" |

All 1,075 names in the first structure appear in the second — the overlap is
total, not partial — and all three URLs return 200. That is roughly **2,490
live pages for about 1,075 people**.

The third structure holds the only hand-written material: directors (13),
faculty profiles (144), staff profiles (61), visitor profiles (122). It also
covers under a third of the people.

**Decided 2026-11-13: one profile per person at `/people/<name>/`.**

Live has exactly one address per person -- `iq.harvard.edu/people/liz-salazar`
-- and nothing else. `/people/staff/liz-salazar` and
`/people-staff-profiles/liz-salazar` both 404 there. Everyone sits in one flat
directory whatever their role, and role is a tag rather than a folder.

So the decision is not which of our three folders wins. The URL should be
`/people/<name>/`, matching live. What has to change is which content sits at
it, because right now the right URL has the wrong content:

| | URL | Content |
|---|---|---|
| `content/people/` | matches live | raw scraped Drupal, ~4.6 KB, its own `<main>` |
| `content/people-*-profiles/` | invented, exists nowhere else | the curated profile with the real bio |

The curated profiles move into `content/people/`, replacing the scraped file
of the same name. The category folders -- `people/faculty/`, `people/staff/`
and the rest -- go entirely; `person-group` carries the category instead, which
is both how live models it and what the generated listings read.

Everything the three structures caused follows from that: the duplicate URLs,
the orphans, most of the nested `<main>`, and the directory-filter links that
404.

---

## The vocabulary

Live models people with two multi-valued taxonomies, and nothing else:
**Role** for the category tabs on `/our-people`, **Program** for the team
sections on service and programme pages. Steven Worthington carries Program
"Data Science Services" and Roles Leadership, Staff and Technical Support,
and that is what puts him in three places at once.

[PEOPLE-TAXONOMY.csv](PEOPLE-TAXONOMY.csv) is the approved list: 11 Role
terms and 15 Program terms, with live's slug beside ours. Liz reviewed it on
2026-11-16 and removed five terms that are not being carried over --
Technical Support, Computer Labs, Public Labs, Consilience Project and
Sponsored Research Services. Nothing here was tagged with any of the first
four, so removing them cost nothing.

Two notes from that review are worth keeping where they will be found:

- **"Sid" is correctly cased.** It is a software project named after Sid
  Verba, not a mis-capitalised acronym. Leave it.
- **CBDB is deliberately spelled correctly here.** Live has
  `china-biograhical-database-cbdb`, missing the p, in both the slug and the
  label. Our URL differs from live on purpose.

## Fixed

### Underscores in URLs → hyphens — done 2026-11-10

Every person URL used underscores (`/people/adaner_usmani/`) where live uses
hyphens (`iq.harvard.edu/people/adaner-usmani`), so no URL matched live.
2,146 files renamed across both `content/people/` structures. Checked first
that nothing internal linked to the old URLs — the only match was an
external Harvard address — and that no two filenames collided on the new
name.

### Composed landing-page copy removed — done 2026-11-10

`content/people/_index.md` carried copy written by Claude rather than taken
from live, and never approved:

- an opening paragraph about IQSS bringing together "a diverse community"
- four headcount descriptions: "275 faculty members conducting cutting-edge
  research", "16 dedicated staff supporting IQSS operations", "167
  affiliated researchers and collaborators", "617 graduate students and
  fellows"
- an "All People (1075)" section linking to `/people/all/`, which does not
  exist and returned 404
- a closing italic note describing the directory as an archive
- a page `description` used as the meta description

All removed, and the category links left behind were switched from
root-absolute (`/people/faculty/`, which ignores the
`/website-re-redesign/` base URL) to relative.

**None of it was ever visible.** `layouts/people/list.html` does not render
`.Content` at all, so the body of `_index.md` has never appeared on the
page — the copy, the headcounts, the `/people/all/` link that pointed at a
page which does not exist, all of it was dead content sitting in a public
repository rather than live text. Removing it is still right; it simply
corrects the record rather than the page.

> **To revisit once the structure is settled:** a headcount passage of the
> kind just removed is genuinely useful on this page — it tells a visitor
> the shape of the community before they click into a category. It was
> removed because the wording was invented and the numbers were hardcoded,
> so they would drift the moment anyone was added. When the canonical
> structure exists, this should come back with wording you approve and
> counts generated from the content rather than typed in, so they stay
> true on their own.

---

## Still open

### Two of the three structures are orphans

Only `people-*` — the 340 curated profiles — is reachable by navigating.
Both the site menu and the six category cards on `/people/` point there.

Nothing internal links to the other two. Searching the whole built site for
links into `/people/<category>/` finds five files, and four of them are that
section's own `index.xml` feeds; the fifth is an external address at UCSD
that happens to contain `/people/faculty/`. Links to a `/people/<name>/`
page come to one.

So **2,150 pages are live but unreachable except by typing the URL**. They
are not indexed today, because every page carries `noindex` while the site
is a prototype, but they would be the moment that is lifted.

### The People landing page is hardcoded

`layouts/people/list.html` contains no `range` over pages and no `.Content`.
The twelve directors are twelve hand-written cards, and the category grid is
seven more. Adding or removing a director, or changing a category, means
editing a template rather than content — and the page cannot reflect what is
actually in `content/people/`, because it never looks.

### 36 URLs carry undecoded UTF-8

Accented names kept their percent-encoding as literal characters in the
filename, so they publish to URLs like:

    /people/-c3-a1d-c3-a1m-stefkovics/

which should be `/people/adam-stefkovics/`. The URL also opens with a
hyphen. **The names themselves display correctly** — the page title renders
"Ádám Stefkovics" — so this is a URL problem only, not a content one.

Affected names include Ádám Stefkovics, Aljoša Milenković, António Câmara,
Arkādijs Zvaigzne and Diego Santa María Alcázar.

### 43 files carry `_0` or `_1` suffixes

Now `-0` and `-1` after the rename. Of these, **15 have an unsuffixed twin**
and are genuine duplicates; the other **28 have no twin**, so the suffix is
simply noise in the URL and can be dropped once it is clear which copy is
canonical.

### Nested `<main>` — 1,075 pages

Each scraped person file carries its own `<main>` inside the one the
template already provides, so assistive technology cannot tell which is the
main content and the skip link may land in the wrong place.

**This is the bulk of the 1,247 nested-`<main>` pages** on
[SITEWIDE-CHECKS.md](SITEWIDE-CHECKS.md). Resolving People resolves most of
that item too.

### Alt text and link text

The People pages are part of the sitewide totals and have not been reviewed
separately. See [SITEWIDE-CHECKS.md](SITEWIDE-CHECKS.md).

---

## Archive, don't delete
**No profile is ever destroyed.** Set 2026-11-16, after a near-miss worth
recording: the consolidation that moved curated profiles onto the
`/people/<name>/` URLs replaced four scraped files that had been hand-tagged
after the scrape, and the tags went with them. The Data Science Services page
dropped from five team members to one before anyone noticed.

Replacing a file is a form of destroying it. When one profile takes over
another's path, the loser is archived and any front matter it carried is
merged in rather than overwritten -- `program`, `role`, their weights,
`job_title`, `email`, `photo`.



Whichever structures lose the canonical decision move to
`C:\Users\els717\Documents\iqss-archive\` — outside the repository, because
the repository is public — rather than being removed. Nothing in this
section is deleted until well after the re-redesigned site goes live.

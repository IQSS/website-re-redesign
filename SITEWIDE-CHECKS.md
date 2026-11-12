# Sitewide checks

Big things to review across the whole site, not page by page. Counts are from
a full build on 2026-10-30 and will drift as content changes.

Nothing here is urgent. Nothing here gets deleted — see "Archive, don't
delete" at the bottom.

## Accessibility

**Image alt text — not yet reviewed.**
11,269 images. Every one has an `alt` attribute, so nothing is missing
outright. 420 have `alt=""`, which tells a screen reader to skip the image.
That is correct for decorative images and wrong for meaningful ones, and
nobody has checked which is which. The rest carry alt text inherited from the
scraped Drupal site, also unreviewed.

**Link text — done 2026-11-12.**
40 "Learn more" links now carry the name of what they lead to, as
screen-reader-only text: "Learn more about Clarify", "Learn more about
Dissertation Awards", and so on. Every name was taken from the heading or
bold label the link already sits under, so the only word added anywhere is
"about".

Seven bare ones remain, all in `services/technology/computer_labs.md`.
The nearest label there is "Address:", which would have produced "Learn
more about Address:" seven times -- worse than leaving them. That page is
also an orphan, so it waits for real wording rather than a derived one.

**Heading outline — done 2026-11-12.**
No page now carries two `<h1>`s. `content/misc/startup_foundry.md` had a
visually hidden page title repeating the words of the visible hero heading
below it; removing the hidden one leaves a single `<h1>` and stops screen
readers announcing the title twice.

## Structure

**The People section has its own audit.**
`/people/` and the parallel `people-*` sections are the largest unresolved
area of the rebuild: every person exists two or three times, at two or three
live URLs, and most of it waits on one editorial decision about which
structure is canonical. Details, and what has already been fixed, are in
[PEOPLE-AUDIT.md](PEOPLE-AUDIT.md). Its 1,075 scraped pages are also the
bulk of the nested-`<main>` count below.

**Nested `<main>` — 1,247 pages.**
Scraped pages carry their own `<main>` element inside the one the template
already provides. Two `<main>`s means assistive tech cannot tell which is the
main content, and the "skip to content" link may land in the wrong place.
This is content-level, not template-level: it is the de-scrape job proper,
and it is the largest single item on this list.

## Pages nothing links to

**2,263 of 2,942 pages — 77% — have no inbound link from anywhere on the
site.** Measured by extracting every internal link from every built page and
comparing against every page built: only 679 distinct pages are ever linked
to. The rest are reachable only by typing the URL.

It concentrates in two places, which is better news than the total suggests:

| Section | Orphans | What they are |
|---|---|---|
| `/people/` | 2,154 | The two duplicate person structures — see [PEOPLE-AUDIT.md](PEOPLE-AUDIT.md) |
| `/services/` | 71 | Scraped Client Support Services pages, below |
| everything else | ~38 | A long tail, mostly one page per section |

So this is not 2,263 separate problems. It is two decisions and a short list.

They stay out of search today only because every page carries `noindex`
while the site is a prototype. That protection ends at launch.

## Links that go nowhere

**Scraped root-absolute links — 3,357 across 1,168 files, 503 distinct.
Counted 2026-11-12.**
Scraped pages link to live's URL structure, which does not exist here, so
every one of them 404s. They concentrate in live's people-directory filters:

| Prefix | Links |
|---|---|
| `/role/` | 1,142 |
| `/people-last-name/` | 949 |
| `/most-recent-year-iqss/` | 273 |
| `/people/` | 218 |
| `/program/` | 158 |
| everything else | 617 |

About three quarters are those directory filters, which exist only inside the
scraped person pages -- so this shrinks with the People decision rather than
needing its own pass.

**Retired service still referenced — 63 content files.**
63 files link to `/client-support-services/...` — not one page but a whole
section of live's old site, with subpages for Zoom, VPN, printing, network
drives and the rest. Those URLs are root-absolute, so they ignore the base
URL and 404 regardless.

**All 63 are themselves orphans.** 58 are in `content/services/technology/`,
which is the scraped copy of that same retired section — 62 pages that
nothing links to, documenting the services of a team that no longer exists
and a section live has since removed. The remaining 5 sit in `/misc/`, which
is also outside the menu.

Repointing these links at the IT Support page would polish pages no visitor
can reach, about a service that is gone. The section wants archiving
instead, which clears the 63 references and 62 orphans together.

**A Drupal staging host leaks into 7 files.**
Eleven links point at `prod-harvardiqss.drupalsites.harvard.edu` -- Harvard's
Drupal staging server, picked up by the scrape. Two sit on the home page.
They may work today and may stop without notice, and they advertise an
internal host; they should point at the public address or at our own pages.

## Page weight

**The site does not hold its own images -- 1,223 are broken right now.**
The scrape captured markup but not media, so almost every picture still points
at Harvard's server:

| How it is referenced | `<img>` tags | What happens |
|---|---|---|
| `/sites/g/files/...`, no host | **1,223** | **404 on our site today** |
| `https://www.iq.harvard.edu/sites/...` | 1,048 | loads, but Harvard serves it |
| `images/`, ours | 41 | fine |

Verified on the deployed site: `noah_greifer_2021.jpg` and
`landing-honeycomb-3840.png` both return 404, while `images/srs-jorge-dasilva.jpg`
returns 200. Between the two Harvard-hosted styles they name about **1,450
distinct files**, of which 426 share a filename with something already in
`static/images/` -- Drupal's resized version of a picture we hold.

All 324 curated profiles in `people-*-profiles/` hotlink their portrait this
way; not one holds its own. If those paths change, or the images are
unpublished the way Valerie O'Kane's profile was, every portrait breaks at
once with no local fallback.

`tools/fetch-live-images.ps1` finds every reference, downloads each distinct
file into `static/images/` and writes a manifest; it changes no content file,
since rewriting references should happen once you can see what arrived. Run
`.\tools\fetch-live-images.ps1 -DryRun` first.

**Expect it to be refused.** The firewall rejects anything that is not a
browser: curl is refused, and so is an honestly-named client. robots.txt
permits these paths, so it is a filter on the client rather than a policy. The
better route is a Drupal media-library export, which also gets the masters
rather than the `styles/hwp_4_5__690x865/` derivatives these URLs point at.

**The two logos cost 228 KB on every page.**
`iqss-logo.png` (74 KB) is shown at 237 × 60 but stored at 1500 × 380.
`iqss-logo-gray-compact.png` (154 KB) is shown at about 147 × 56 but stored
at 1331 × 508. Worse, both download on every visit on every device: each is
hidden by CSS at the width where the other one shows, and `display: none`
does not stop a browser fetching an `<img>`. So every visitor pays for both
and sees one. This is the highest-leverage image fix on the site, because it
is on every page rather than one.

**Oversized images generally.**
Several pages ship photographs far larger than they are displayed — the worst
is a 4.2 MB PNG of a single portrait. Sizes, locations and what each should
become are in [GRAPHICS-TO-PRODUCE.md](GRAPHICS-TO-PRODUCE.md).

## Circle back

**The four `dss-*` pages.**
`dss-tutorials`, `dss-resources`, `dss-workshop-materials` and
`dss-research-output` in `content/research-resources/` mirror material live
has removed, and the rebuilt Data Science Services page no longer links to
them. They are our own pages rather than scraped copies, so the "gone on
live" test does not settle it. Liz wants to read them against live and
decide; not before then.

## Before launch

**Turn off `noindex`.**
`hugo.toml` sets `noindex = true` under `[params]` so the prototype stays out
of search results. This must be flipped to `false` when this becomes the
official site, and not before.

## Archive, don't delete

Nothing is deleted from this project until well after the re-redesigned site
goes live. Unused files move to an archive folder and stay retrievable.

The archive lives at `C:\Users\els717\Documents\iqss-archive\`, deliberately
outside the repository — this repo is public, so anything that should stay
private cannot live in it.

Currently unused but kept: `content/research-resources/client-support-services.md`.

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

**Link text — mostly fine, small cleanup.**
215,504 links (most are the nav and footer repeated on every page). 65 have
generic text like "Read more" or "Learn more" with no context, and 2 have no
text at all. A screen reader user tabbing through links hears only the link
text, so "Read more" five times on a page tells them nothing. This count only
catches links whose text is plain, so treat it as a floor.

**Heading outline.**
Each page should have exactly one `<h1>` and no skipped levels.
`content/misc/startup_foundry.md` has two `<h1>`s inside its own scraped
content.

## Structure

**Nested `<main>` — 1,247 pages.**
Scraped pages carry their own `<main>` element inside the one the template
already provides. Two `<main>`s means assistive tech cannot tell which is the
main content, and the "skip to content" link may land in the wrong place.
This is content-level, not template-level: it is the de-scrape job proper,
and it is the largest single item on this list.

## Links that go nowhere

**Scraped root-absolute links.**
Scraped pages link to live's URL structure (e.g.
`/undergraduate-research-scholars/for-faculty`), which does not exist here, so
they 404. Not yet counted.

**Retired page still referenced — 63 content files.**
63 files link to `client-support-services`, which is no longer in the menu
after the Client Support Services team was eliminated. The file itself stays
(see below); the links need to point somewhere real, most likely the new IT
Support page.

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

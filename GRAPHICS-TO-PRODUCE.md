# Graphics to produce

Files to make or re-export, with the size each one is actually displayed at.
Measured from a running build on 2026-11-05 at a 1440px viewport.

**The rule behind every "produce at" below:** export at twice the displayed
size, so the image stays sharp on a high-density screen, and no larger. A
file bigger than that is bytes nobody sees.

Nothing here is deleted or replaced until you say so — these are files to
hand back, and the templates get pointed at them afterwards.

---

## 1. User journey portraits — 4 new files

The highest-value item: these four replace **1.29 MB** of downloads with
about **30 KB**.

Right now each journey card shows a 64px portrait by loading the entire
1600×900 flowchart (≈320 KB each) and cropping it with CSS. Four of them load
before the page settles.

| | |
|---|---|
| **Where used** | `/become-an-affiliate/`, the four "Typical User Journeys" cards |
| **Displayed at** | 64 × 64 px |
| **Produce at** | **128 × 128 px** |
| **Ratio** | 1:1 square |
| **Format** | PNG-24 with transparent background |
| **Target weight** | ≤ 8 KB each |

**Files to produce:**

| New file | Crop from |
|---|---|
| `uj-researcher-portrait.png` | `uj-researcher.jpg` |
| `uj-faculty-portrait.png` | `uj-faculty.jpg` |
| `uj-administrator-portrait.png` | `uj-administrator.jpg` |
| `uj-student-portrait.png` | `uj-student.jpg` |

**The crop region is the same in all four source images:** the portrait
figure sits at **x 32–129, y 112–223** of the 1600×900 original — 98 × 111 px.
Centre that in the 128px square with a little breathing room on all sides;
it does not need to fill the frame.

Transparent background is preferable to white: the cards are white today, but
transparency means the portrait still works if that ever changes.

---

## 2. IQSS wordmark (wide) — re-export

| | |
|---|---|
| **File** | `static/images/iqss-logo.png` |
| **Where used** | Site header, **every page**, on screens wider than 768px |
| **Currently** | 1500 × 380, 74 KB |
| **Displayed at** | 237 × 60 — a 6.3× oversize |
| **Produce at** | **474 × 120 px** |
| **Ratio** | 3.95:1 |
| **Format** | **SVG preferred** (it is a wordmark); PNG-24 otherwise |
| **Target weight** | ≤ 5 KB as SVG, ≤ 15 KB as PNG |

---

## 3. IQSS compact mark — re-export

| | |
|---|---|
| **File** | `static/images/iqss-logo-gray-compact.png` |
| **Where used** | Site header, **every page**, on screens 768px and narrower |
| **Currently** | 1331 × 508, **154 KB** |
| **Displayed at** | ~147 × 56 — a 9× oversize |
| **Produce at** | **294 × 112 px** |
| **Ratio** | 2.62:1 |
| **Format** | **SVG preferred**; PNG-24 otherwise |
| **Target weight** | ≤ 5 KB as SVG, ≤ 12 KB as PNG |

> **Both logos download on every page, on every device.** Each is hidden by
> CSS at the width where the other one shows, but `display: none` does not
> stop a browser fetching an `<img>` — so every visitor pays for both, 228 KB
> in total, and only ever sees one. Smaller files fix most of this; the rest
> is a template change to stop fetching the hidden one, which is mine to make
> once the new files exist.

---

## 4. "Become an Affiliate" hero — replace

This one is a quality problem rather than a weight problem: the image is far
**too small** and is being stretched almost 4× to fill the band, so it is
soft.

| | |
|---|---|
| **File** | `static/images/affiliates.jpg` |
| **Where used** | Hero band on `/become-an-affiliate/` |
| **Currently** | 360 × 240, 43 KB — stretched to 1425 × 350 |
| **Produce at** | **2000 × 500 px** |
| **Ratio** | 4:1 |
| **Format** | JPEG, quality ~75 |
| **Target weight** | ≤ 250 KB |

2000 × 500 matches `about-banner.jpg`, which is the size the other hero bands
already use, so this brings the page into line with the rest of the site.

Text sits over the left half of this band, so keep that area uncluttered and
reasonably dark — the heading and subtitle are white.

---

## 5. Oversized photographs — re-export

Correct in content, far larger than they are ever shown. Each is listed with
what it should become.

| File | Where used | Now | Displayed | Produce at | Format |
|---|---|---|---|---|---|
| `tyler-vanderweele.png` | Testimonial on `/research/incubation/` | 1420 × 2131, **4.2 MB** | 300 × 400 | **600 × 800** | JPEG ~75 |
| `data-science-hero.png` | Home page, Data Science Services | 1920 × 825, 1.59 MB | full-width hero | **1920 × 825** | JPEG ~75 |
| `about-banner.jpg` | Hero on `/about/` | 2000 × 500, 1.11 MB | full-width hero | 2000 × 500 (keep) | JPEG ~75 |
| `survey-research.png` | Card on `/programs-products/` | 1548 × 776, 892 KB | 200 × 100 | **400 × 200** | JPEG ~75 |
| `people-len-wisniewski.png` | `/people/` card, and his own profile | 690 × 865, 540 KB | 70 × 70 card, 150 × 150 profile | **300 × 300** | JPEG ~75 |

**`tyler-vanderweele.png` is the single worst file on the site at 4.2 MB** —
a photograph saved as PNG, which is a format for flat graphics, not photos.
Its frame is also 3:4 on the page but 2:3 in the file, so crop to 3:4 when
re-exporting rather than letting the page squash it.

The same PNG-for-a-photograph mistake affects `people-len-wisniewski.png`.
JPEG at quality 75 will be a fraction of the size with no visible difference.
`survey-research.png` is the most oversized of the group at 7.7× — nearly
900 KB for a card shown at 200 × 100.

`people-len-wisniewski.png` is cropped square by the page (`object-fit:
cover`) from a 690 × 865 portrait, so crop it square yourself rather than
leaving the browser to choose what to cut.

Hero images stay at 1920–2000px wide rather than doubling: at that size the
file cost of a 2× export outweighs the sharpness nobody notices on a
background photograph.

---

## 6. Data Science Services — 8 new files

The DSS page was rebuilt on 2026-11-12 to match live's current redesign,
which is a different page from the one we had: a honeycomb of subject areas,
four service cards, a statistics panel and five staff portraits. The markup
references these filenames already, so the page shows broken images until
they exist.

Live's own versions are on `iq.harvard.edu` under
`/sites/g/files/omnuum8171/files/2026-08/` if you want to start from them.

### Two wide information graphics

Both carry their own text, so they must be legible. Live serves them at
3840px wide; half that is enough for a page whose content column is 1160px,
and these should get the same click-to-enlarge treatment as the Mission
graphic if they end up hard to read inline.

| File | Shows | Produce at | Ratio | Format | Target |
|---|---|---|---|---|---|
| `dss-honeycomb.png` | "What we can help with" — AI agents plus twenty subject areas | **1920 wide** | match source | PNG-24 | 400 KB |
| `dss-stats.png` | "What we have done since 2011" — help given and what came of it | **1920 wide** | match source | PNG-24 | 400 KB |

The alt text for both is already written into the page, transcribing every
figure and label, so a screen reader gets the full content either way.

### Four service icons

| File | For |
|---|---|
| `dss-service-consulting.png` | Consulting |
| `dss-service-collaboration.png` | Collaboration |
| `dss-service-tool-building.png` | Analytical tool building |
| `dss-service-training.png` | Training |

| | |
|---|---|
| **Displayed at** | 180 × 180 |
| **Produce at** | **360 × 360** |
| **Ratio** | 1:1 |
| **Format** | PNG-24, transparent |
| **Target weight** | 40 KB each |

Live serves these at exactly 360 × 360, so its files can be used as they are.

### Five staff portraits — one file each, shared with the People directory

These are **not** DSS-only files. The team section on the Data Science
Services page is built from the People directory: the five profiles are
tagged `service: Data Science Services`, and each one carries its own
`photo`. So one portrait per person serves both their profile and any
service page that lists them, and nobody's face is stored twice.

| File | Person | Profile |
|---|---|---|
| `people-joshua-cetron.jpg` | Joshua Cetron | `content/people/joshua-cetron.md` |
| `people-noah-greifer.jpg` | Noah Greifer | `content/people/noah-greifer.md` |
| `people-jinjie-liu.jpg` | Jinjie Liu | `content/people/jinjie-liu.md` |
| `people-steve-worthington.jpg` | Steven Worthington | `content/people/steven-worthington-0.md` |
| `people-dan-yuan.jpg` | Dan Yuan | `content/people/dan-yuan.md` |

| | |
|---|---|
| **Displayed at** | 240 × 300 on the service page, 70 × 70 in directory cards |
| **Produce at** | **480 × 600** |
| **Ratio** | 4:5 portrait |
| **Format** | JPEG q75 |
| **Target weight** | 60 KB each |

4:5 is live's own crop for staff photographs and it serves them at exactly
480 × 600, so those files can be used as they are. Directory cards crop the
same file square with `object-fit: cover`, so keep the face in the upper
middle.

`people-steve-worthington.jpg` already exists and is already used in the
directory; it wants re-exporting at 480 × 600 rather than replacing with a
new name, since the People layout references that filename.

The five `dss-cetron.jpg`-style files from the older version of the page are
no longer referenced by anything.

## Not needed

`mission-overview.jpg` (4966 × 3973, 1.2 MB) is **not referenced anywhere** —
the About page uses `mission-overview-hd.jpg` instead. No need to re-export
it. Per the archive rule it stays where it is rather than being removed.

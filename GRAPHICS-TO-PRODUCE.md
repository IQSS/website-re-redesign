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
| `survey-research.png` | Scientific Programs | 1548 × 776, 892 KB | card image | **760 × 380** | JPEG ~75 |
| `people-len-wisniewski.png` | People directory | — , 540 KB | portrait | **600 × 600** | JPEG ~75 |

**`tyler-vanderweele.png` is the single worst file on the site at 4.2 MB** —
a photograph saved as PNG, which is a format for flat graphics, not photos.
Its frame is also 3:4 on the page but 2:3 in the file, so crop to 3:4 when
re-exporting rather than letting the page squash it.

The same PNG-for-a-photograph mistake affects `people-len-wisniewski.png` and
`survey-research.png`. JPEG at quality 75 will be a fraction of the size with
no visible difference.

Hero images stay at 1920–2000px wide rather than doubling: at that size the
file cost of a 2× export outweighs the sharpness nobody notices on a
background photograph.

---

## Not needed

`mission-overview.jpg` (4966 × 3973, 1.2 MB) is **not referenced anywhere** —
the About page uses `mission-overview-hd.jpg` instead. No need to re-export
it. Per the archive rule it stays where it is rather than being removed.

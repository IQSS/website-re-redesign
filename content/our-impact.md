---
title: "Our Impact"
date: 2026-05-28
draft: false
layout: "resource-page"
hero_image: "images/impact-banner.jpg"
subtitle: "IQSS encourages and allows researchers to think more expansively and take on projects that would otherwise have been impossible."
---

These are examples of how IQSS drives tangible change in the world.

<style>
/* ── Impact story tiles ───────────────────────────────────────────────
   Mobile-first: graphic, heading, blurb and link are all rendered in
   normal flow, always visible. The hover reveal is layered on top only
   inside the `hover: hover` query below, so touch devices never inherit
   a reveal they cannot trigger.

   The blurb is a SIBLING of the media box, not a child: the media box
   is clipped (overflow:hidden, fixed aspect) so a nested blurb would be
   invisible on mobile. Each tile is one anchor wrapping everything —
   no nested links, one tab stop. */
.impact-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 22px;
    margin: 30px 0 10px;
}

.impact-tile {
    /* flex, not block: the markdown leaves whitespace text nodes between the
       child divs, and in a block container those generate a ~20px line box
       that pushes the media down and knocks the hover overlay out of register.
       A flex container discards whitespace-only anonymous children. */
    display: flex;
    flex-direction: column;
    position: relative;
    text-decoration: none;
    color: inherit;
    background: #fff;
    border: 1px solid #e6e6e6;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    transition: box-shadow 0.2s ease, transform 0.2s ease;
}
.impact-tile:hover,
.impact-tile:focus-visible { box-shadow: 0 10px 24px rgba(0,0,0,0.14); transform: translateY(-2px); }
.impact-tile:focus-visible { outline: 3px solid var(--orange-brand); outline-offset: 3px; }

.impact-media { display: flex; background: var(--bg-light-base); }
/* Two class selectors so this beats the layout's `.rp-content img`, which
   is the same specificity and would otherwise win on document order. That
   rule adds a 20px vertical margin — 40px of dead space inside the media
   box, which also desyncs the hover overlay from the image it covers. */
.impact-tile .impact-media img {
    display: block;
    width: 100%;
    aspect-ratio: 16 / 9;
    object-fit: cover;
    margin: 0;
    border-radius: 0;
}

/* Symmetric padding, and the body grows to absorb the grid's leftover
   stretch space with the title centred in it. Grid rows are equal height,
   so a one-line title would otherwise dump ~25px of slack below itself
   while two-line titles sat tight against the card edge. Centring keeps
   the gap above the title equal to the gap below it on every tile. */
.impact-body {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 14px 18px;
}
/* Two class selectors to beat the layout's `.rp-content h3`, which is the
   same specificity, later in document order, and forces #333. */
.impact-tile .impact-body h3 {
    font-size: 18px;
    line-height: 1.35;
    color: var(--orange-brand);
    margin: 0;
}

.impact-reveal { padding: 8px 18px 18px; }
.impact-reveal p { font-size: 14.5px; line-height: 1.6; color: #555; margin: 0 0 10px; }
.impact-tile .impact-more {
    display: inline-block;
    font-size: 14px;
    font-weight: 600;
    color: var(--orange-brand);   /* 4.55:1 on the white card */
}

/* Two columns once there is room */
@media (min-width: 700px) {
    .impact-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}

/* ── Pointer devices only ─────────────────────────────────────────────
   `hover: hover` + `pointer: fine` excludes touchscreens, so phones and
   tablets keep the stacked layout above. :focus-within keeps the reveal
   reachable by keyboard, where hover does not exist either. */
@media (hover: hover) and (pointer: fine) {
    .impact-reveal {
        position: absolute;
        top: 0; left: 0;
        width: 100%;
        aspect-ratio: 16 / 9;   /* matches the media box exactly */
        padding: 18px;
        /* Translucent so the photograph reads through. 0.75 is chosen, not
           guessed: over a pure-white pixel (the worst case) white text still
           measures 5.51:1. At 0.65 it drops to 4.13 and fails AA. */
        background: rgba(26, 58, 92, 0.75);
        color: #fff;
        opacity: 0;
        transition: opacity 0.25s ease;
        display: flex;
        flex-direction: column;
        justify-content: center;
        overflow: hidden;
    }
    /* Two class selectors again, to beat the layout's `.rp-content p`
       (same specificity, later in document order) which otherwise forces
       the blurb to #444 — dark grey on navy, effectively unreadable.
       Clamp rather than scroll: a scrollable hover overlay is dismissed the
       moment the pointer leaves it, so the tail would be unreachable. */
    .impact-tile .impact-reveal p {
        color: #fff;
        font-size: 13.5px;
        line-height: 1.5;
        display: -webkit-box;
        -webkit-line-clamp: 6;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    /* Stays white here, deliberately. Brand orange on this navy measures
       1.21:1 over a bright image and only 2.21:1 against solid navy — it
       never clears AA at any opacity, because the two are too close in
       luminance. Orange is used on the white card instead (above). */
    .impact-tile .impact-more { color: #fff; text-decoration: underline; }
    .impact-media img { transition: opacity 0.25s ease; }

    .impact-tile:hover .impact-reveal,
    .impact-tile:focus-within .impact-reveal { opacity: 1; }
    /* Only a slight dim now — the translucent overlay above does the
       darkening, so fading the image hard would defeat seeing it at all. */
    .impact-tile:hover .impact-media img,
    .impact-tile:focus-within .impact-media img { opacity: 0.9; }
}

@media (prefers-reduced-motion: reduce) {
    .impact-tile, .impact-reveal, .impact-media img { transition: none; }
}
</style>

<div class="impact-grid">

<a class="impact-tile" href="https://news.harvard.edu/gazette/story/2023/11/harvard-study-plays-key-role-in-suit-against-airline-uniform-maker/" target="_blank" rel="noopener noreferrer">
<div class="impact-media">
<img src="https://www.iq.harvard.edu/sites/g/files/omnuum8171/files/styles/hwp_1_1__1315x1315/public/harvard-iqss/files/flight-attendant-7x5-unsplash.jpg?itok=UzTAzLle" alt="Back of a flight attendant walking down the aisle of an empty airline cabin" />
</div>
<div class="impact-body"><h3>Investigating Flight Attendants' Safety</h3></div>
<div class="impact-reveal">
<p>In the longest-running longitudinal study of its kind, a study by Dr. Eileen McNeely, executive director of SHINE at IQSS, collected data on uniforms from major US airlines. Laboratory tests found harmful substances on a manufacturer's uniforms, and analysis showed a clear connection between the introduction of these uniforms and reports of debilitating medical issues such as respiratory problems and thyroid disease.</p>
<span class="impact-more">About the SHINE study →<span class="sr-only"> (opens in new tab)</span></span>
</div>
</a>

<a class="impact-tile" href="../news/dataverse-publishes-houghton-library-saef-data-collection/">
<div class="impact-media">
<img src="https://www.iq.harvard.edu/sites/g/files/omnuum8171/files/styles/hwp_16_9__960x540/public/harvard-iqss/files/black-congressmen-1872_currier-ives_houghton-library_3x2.jpg?h=db32434a&itok=2JULYS3R" alt="19th-century engraving print of seven black men, five of whom are seated" />
</div>
<div class="impact-body"><h3>Digitizing History for the Future of Data Research</h3></div>
<div class="impact-reveal">
<p>In the first major endeavor to represent a significant Harvard Library collection as data, the IQSS Dataverse Project collaborated with the Houghton Library to create the Slavery, Abolition, Emancipation, and Freedom (SAEF) Data Collection, an open access research dataset of more than 1200 items relating to African American history from the Early Republic through Reconstruction.</p>
<span class="impact-more">Read the full story →</span>
</div>
</a>

<a class="impact-tile" href="../news/data-science-services-at-iqss-harnessing-data-interpretation/">
<div class="impact-media">
<img src="https://www.iq.harvard.edu/sites/g/files/omnuum8171/files/styles/hwp_16_9__960x540/public/harvard-iqss/files/dataviz-laptop_carlos-muza_3x2.jpg?itok=5wRyHooL" alt="Laptop displaying analytical data" />
</div>
<div class="impact-body"><h3>Harnessing Data Interpretation for Academic Advancement</h3></div>
<div class="impact-reveal">
<p>At a time when research across disciplines increasingly requires a range of skills to collect and interpret data, scholars can find themselves struggling with hurdles at various points in their projects. Data Science Services (DSS) has provided an innovative set of resources that supports a smoother research cycle for researchers across Harvard.</p>
<span class="impact-more">Read the full story →</span>
</div>
</a>

<a class="impact-tile" href="../news/twitter-sentiment-geographical-index/">
<div class="impact-media">
<img src="https://www.iq.harvard.edu/sites/g/files/omnuum8171/files/styles/hwp_16_9__960x540/public/harvard-iqss/files/emoji-network_alex-shuper_3x2.jpg?itok=cnS15_Ej" alt="Multicolored emojis connected by network lines on a dark field" />
</div>
<div class="impact-body"><h3>Measuring Population Well-Being with Social Media</h3></div>
<div class="impact-reveal">
<p>Can we derive any useful information from social media posts about movies, food, or seemingly nothing in particular? By creating the Twitter Sentiment Geographical Index (TSGI), Devika Kakkar's team at the Center for Geographic Analysis collaborated with other researchers to study a range of topics such as pollution, climate change, and emotional well-being.</p>
<span class="impact-more">Read the full story →</span>
</div>
</a>

<a class="impact-tile" href="../news/data-highway-a-trailblazing-journey-into-trucking/">
<div class="impact-media">
<img src="https://www.iq.harvard.edu/sites/g/files/omnuum8171/files/styles/hwp_16_9__960x540/public/harvard-iqss/files/axle1-truck-data.png?itok=_2WI3E94" alt="Illustration of a truck with attached icons representing location, vehicle, and driver data" />
</div>
<div class="impact-body"><h3>Trailblazing a Path into Trucking for the 21st Century</h3></div>
<div class="impact-reveal">
<p>As our highways become the new digital landscape, where every truck is a node and every delivery a connection, an IQSS fellow-turned-entrepreneur is helping build the transportation infrastructure of tomorrow. IQSS Data Privacy Lab alumnus Jinyan Zang, founder and COO of Axle, has created a data platform to transform trucking logistics.</p>
<span class="impact-more">Read the full story →</span>
</div>
</a>

</div>

---

## Our Community

<img src="../images/impact-team.jpg" alt="IQSS team members" style="width:200px;float:right;margin:0 0 15px 20px;border-radius:8px;" />

IQSS is comprised of faculty and students representing nearly every school within Harvard, plus visiting scholars, fellows, and postdocs from institutions across the globe. These scholars are supported by a staff of more than 50 dedicated IT professionals, administrators, and support personnel.

Our philosophy: the more information we share, the better the social science research and the more likely it is that we will be able to fix some of the world's most complex social problems.

---

## Make a Gift

A contribution from you can provide IQSS with great opportunities to expand our research, programs, and community.

<a href="https://community.alumni.harvard.edu/give/51724705" class="cta-button" target="_blank" rel="noopener noreferrer">Donate to IQSS<span class="sr-only"> (opens in new tab)</span></a>

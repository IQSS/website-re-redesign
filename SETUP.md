# IQSS Hugo Site - Setup Instructions

How this site is hosted, deployed and previewed.

## Where things live

| What | Where |
|---|---|
| Repository | `IQSS/website-re-redesign` on GitHub (public) |
| Live site | https://iqss.github.io/website-re-redesign/ |
| Deploy | GitHub Actions workflow `.github/workflows/hugo.yml`, on every push to `main` |
| Hugo version | 0.167.0 extended, both locally and in the workflow |

The site was first set up in `lenwiz/hugoclone-iqss` (live at
https://lenwiz.github.io/hugoclone-iqss/) and moved to the IQSS organization in
October 2026. The full commit history came with it.

The site sets a `noindex` robots tag on every page (`noindex = true` under
`[params]` in `hugo.toml`) so the prototype stays out of search results. Set it
to `false` when this becomes the official site.

## Prerequisites

- A GitHub account with **Write** access to `IQSS/website-re-redesign`
- An SSH key added to that GitHub account
- Git
- Hugo Extended **0.167.0** (match the `HUGO_VERSION` in the workflow)

## Get a local copy

```bash
git clone git@github.com:IQSS/website-re-redesign.git
cd website-re-redesign
```

## Preview locally

The built site in `public/` is committed to the repository (about 3,000 files).
A plain `hugo server` rewrites those files, which buries real edits under
thousands of changed files. Build the preview to a folder **outside** the
repository instead:

```bash
hugo server --destination ../website-preview --disableFastRender
```

Then open the address Hugo prints. The workflow rebuilds `public/` from source
on every deploy, so the committed copy is never what gets published.

If `public/` ever shows mass changes, discard them:

```bash
git checkout -- public
git clean -fd public
```

## Publish a change

Every push to `main` goes live within about a minute, so preview first.

```bash
git status                    # check that only your source files changed
git add <files you changed>   # name them; avoid "git add ." so public/ stays out
git commit -m "Describe the change"
git push
```

Follow the build on the repository's **Actions** tab. If it fails, the live
site keeps the last good version.

## GitHub Pages settings

Already configured. For reference, in the repository: **Settings → Pages →
Build and deployment → Source: GitHub Actions**. The workflow passes the Pages
address to Hugo as the base URL, so `baseURL` in `hugo.toml` only matters for
builds run outside the workflow.

## Upgrading Hugo

Change your local Hugo and `HUGO_VERSION` in `.github/workflows/hugo.yml`
together. When they differed (0.167.0 locally, 0.128.0 in the workflow), pages
that previewed correctly failed to build on GitHub.

## Custom domain (optional)

To serve the site from a harvard.edu name:

1. Add a CNAME file with the domain:
   ```bash
   echo "your-name.iq.harvard.edu" > static/CNAME
   ```
2. Set `baseURL` in `hugo.toml` to that address.
3. Ask HUIT to add a DNS CNAME record pointing to `iqss.github.io`.
4. In **Settings → Pages**, enter the custom domain and turn on **Enforce HTTPS**.

## Giscus comments (not active)

`layouts/partials/giscus.html` can show GitHub Discussions comments on a page,
but no layout includes it and `hugo.toml` has no `giscus` settings, so it does
nothing today. To turn it on:

1. Enable **Discussions** in the repository settings.
2. Install the Giscus app (https://github.com/apps/giscus) on the repository.
3. At https://giscus.app/, enter `IQSS/website-re-redesign` and copy the
   `repoId` and `categoryId` it generates.
4. Add them to `hugo.toml` under `[params.giscus]` with `enabled = true`, and
   include the partial in the page layout that should show comments.

## Slack blog bot

`slack-blog-bot/` publishes approved Slack posts to the blog by writing files
straight to the repository through the GitHub API. See
`slack-blog-bot/README.md`. Its code still targets `lenwiz/hugoclone-iqss`; it
needs a new repository target and token before it can publish here.

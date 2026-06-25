# Yang Ni — Personal Academic Website

Source for `https://yni-astro.github.io` (when you go public — see `PUBLISH.md`).

A **single-page** site built with [Jekyll](https://jekyllrb.com/). Everything renders on
one scrolling page (`index.html`); the sidebar links jump to sections. Publications are
driven by small markdown files — no HTML editing needed to add a paper.

---

## Quick local preview

You need a modern Ruby (≥ 3.0) and Bundler.

```bash
# One-time
gem install bundler
cd ~/personalhomepage
bundle install

# Preview (auto-reloads as you edit)
bundle exec jekyll serve --livereload
```

Open <http://127.0.0.1:4000>. Edits to markdown / HTML / CSS reload automatically.
**Changes to `_config.yml` require restarting the server.**

---

## How it's organized

```
.
├── _config.yml              # site + author settings, ADS library URL, build options
├── _layouts/default.html    # page shell: sidebar + content + scroll-spy script
├── _includes/
│   ├── head.html            # <head>: fonts, icons, CSS
│   ├── sidebar.html         # fixed sidebar: avatar, anchor nav, ORCID + ADS links
│   └── pub-line.html        # one clean publication entry (authors, title, venue, links)
├── _publications/           # ← one .md per paper (drives Publications + Research)
├── _talks/   _news/         # content for Talks/News (currently hidden)
├── talks.html  news.html    # standalone listing pages, currently hidden (published: false)
├── index.html               # the whole page: About · Research · Publications · Contact
├── assets/
│   ├── css/main.css         # all styling; color palette in :root at the top
│   ├── images/
│   │   ├── profile.jpg      # sidebar avatar (web-optimized)
│   │   ├── favicon.png      # site icon
│   │   └── research/*.png   # Research-highlight figures
│   └── pdf/CV_Yang.pdf      # the downloadable CV
└── profilephoto.jpg         # full-resolution avatar master (excluded from the build)
```

The site is one file — `index.html` — split into `<section>`s with the ids `#about`,
`#research`, `#publications`, and `#contact`. The sidebar nav links are in-page anchors,
and a small script in `_layouts/default.html` highlights whichever section is in view.

---

## Add a publication

Create `_publications/YYYY-MM-slug.md`. Papers are sorted by `date`; **first-author papers
are listed first**, each group newest-first.

```yaml
---
title: "Paper title"
authors: "**Y. Ni**, A. Coauthor, B. Coauthor"   # bold your name with **...**
journal: "ApJ"
volume: "995"
pages: "96"
year: 2025
date: 2025-12-09                 # used for sorting (YYYY-MM-DD)
is_first_author: true            # true → shown in the "First-author" group
is_highlight: false              # true → also featured in Research (see below)
arxiv_link: "https://arxiv.org/abs/..."
ads_link:   "https://ui.adsabs.harvard.edu/abs/..."
doi_link:   "https://doi.org/..."     # optional
excerpt: "One-line summary (used as the Research blurb if no body is written)."
---
```

That alone makes the paper appear in the **Publications** list with `ADS · arXiv · DOI`
links.

## Feature a paper in Research (figure + abstract)

In that paper's front matter:

1. Set `is_highlight: true`.
2. Add a figure: drop an image into `assets/images/research/`, then set
   `highlight_image: /assets/images/research/<your-file>.png`. Figures display at full
   column width, flush with the page (no frame).
3. Write the abstract as markdown **below** the closing `---` of the front matter
   (multi-paragraph is fine). If the body is empty, the `excerpt:` is used instead.

## Talks & News (currently hidden)

`talks.html` and `news.html` are set to `published: false`, so they don't build — but the
content in `_talks/` and `_news/` is kept. To bring them back: set `published: true` and
either add a sidebar link to `/talks/` (or `/news/`), or fold the items into `index.html`
as a new section to match the single-page style.

## Update the CV, avatar, or favicon

- **CV** — replace `assets/pdf/CV_Yang.pdf` (keep the filename). The "Download CV" button
  in the About section points there.
- **Avatar** — replace `assets/images/profile.jpg` (kept small for the web).
  `profilephoto.jpg` at the repo root is the full-resolution master.
- **Favicon** — replace `assets/images/favicon.png`.

## Theming

The color palette lives in the `:root` block at the top of `assets/css/main.css`. Change a
single variable (e.g. `--accent`) and it ripples site-wide. The active palette is light
(white background); a dark preset is included, commented out.

## ADS library

`_config.yml → author.ads_library` holds your curated NASA ADS public library URL; the
sidebar ADS icon and the Publications link point to it. To change it, paste a new library
URL there and restart the server.

---

## Going public

See `PUBLISH.md`.

## When you want help

The architecture — markdown files for papers, CSS variables for theming, includes for
layout — keeps most edits local and reversible. For larger changes (restoring Talks/News,
new section types, NASA ADS / arXiv auto-import), just come back to chat.

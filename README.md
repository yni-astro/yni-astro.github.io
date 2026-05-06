# Yang Ni — Personal Academic Website

Source for `https://yni-astro.github.io` (when you go public — see `PUBLISH.md`).

Built with [Jekyll](https://jekyllrb.com/). Each publication, talk, and news item is a
small markdown file — no HTML editing required to update content.

---

## Quick local preview

You need Ruby installed. macOS ships with Ruby but it's old; install a fresh one via
[Homebrew](https://brew.sh/) or [rbenv](https://github.com/rbenv/rbenv).

```bash
# One-time setup
brew install ruby           # if you don't already have a modern ruby
gem install bundler
cd ~/personalhomepage
bundle install              # installs Jekyll + dependencies into ./vendor

# Preview the site (live-reloads as you edit)
bundle exec jekyll serve
```

Open <http://127.0.0.1:4000> in your browser. Changes to markdown / HTML reload
automatically. Changes to `_config.yml` require restarting the server.

---

## Project layout

```
.
├── _config.yml          # site title, author info, ADS library URL, sitewide settings
├── _layouts/            # HTML page templates
├── _includes/           # reusable HTML snippets (sidebar, head, pub-card)
├── _publications/       # ← one .md per paper
├── _talks/              # ← one .md per talk
├── _news/               # ← one .md per news item
├── assets/
│   ├── css/main.css     # all the styling lives here (palette in :root at the top)
│   ├── images/          # profile.jpg, hero.png, pubs/*.png, research/*.png
│   └── pdf/CV_Yang.pdf  # canonical CV PDF
├── index.html           # home page
├── about.html           # about page
├── research.html        # research highlights (driven by `is_highlight: true`)
├── publications.html    # publications listing (auto-generated from _publications/)
├── talks.html           # talks listing
├── news.html            # full news archive
├── cv.html              # CV page
└── contact.html         # contact page
```

The original `CV_Yang.pdf`, `profilephoto.jpg`, and `herosci.png` at the root are
the originals you dropped in. The site uses the copies under `assets/`. You can
delete the root copies if you like — they are excluded from the build.

---

## How to add a new paper

Create a new file in `_publications/` named `YYYY-MM-short-slug.md` (e.g.
`2026-04-disks-ii.md`). The filename doesn't matter for the listing — items are
sorted by the `date:` field — but a date-prefix keeps the folder tidy.

```yaml
---
title: "Your paper title here"
authors: "**Y. Ni**, A. Coauthor, B. Coauthor"   # bold yours with **...**
journal: "ApJ"
volume: "XXX"
pages: "YY"
year: 2026
date: 2026-04-15            # used for sorting (YYYY-MM-DD)
is_first_author: true       # shows the "first author" badge + featured on home
is_highlight:    false      # set true to feature on the Research page (see below)
arxiv_link: "https://arxiv.org/abs/2604.XXXXX"
ads_link:   "https://ui.adsabs.harvard.edu/abs/..."
doi_link:   ""              # optional
code_link:  ""              # optional
thumbnail:        /assets/images/pubs/2026-disks-ii.png       # 4:3 thumbnail
highlight_image:  /assets/images/research/2026-disks-ii.png   # optional larger figure for Research page
excerpt: "One- to three-sentence plain-English summary that shows up under the title."
---

Optional longer markdown abstract. This appears only on the Research page when
`is_highlight: true`. It can span multiple paragraphs and use **bold**, *italics*,
[links](https://example.com), and inline math `$x^2$`.
```

Then drop a 4:3 thumbnail into `assets/images/pubs/` and rebuild. That's it.

If the paper has no thumbnail, omit the `thumbnail:` line — a placeholder shows.

---

## How to add a talk

Create a file in `_talks/`:

```yaml
---
title: "Talk title"
event: "Conference / colloquium name"
location: "City, country (or institution)"
host: "Prof. Someone"        # optional, only for invited colloquia
kind: "Contributed talk"      # or "Invited talk", "Poster", "Seminar"
date: 2026-06-10
---
```

---

## How to add a news item

Create a file in `_news/`. The body is markdown — it appears verbatim.

```yaml
---
date: 2026-04-15
---
Our new paper on **X** is on [arXiv](https://arxiv.org/abs/...).
```

The four most recent news items show on the home page; everything appears on `/news/`.

---

## How to update your CV PDF

Replace `assets/pdf/CV_Yang.pdf` with the new PDF (keep the same filename). The
"Download CV" buttons point to that path.

If you want to update the on-page CV summary too, edit `cv.html`.

---

## How to update the hero figure or profile photo

Replace `assets/images/hero.png` (homepage hero) or `assets/images/profile.jpg`
(sidebar avatar) with your new image. Same filename, no other changes needed.
To resize or recrop the hero, see "Tune the hero figure" below.

---

# Common modifications — recipes

A reference for the kinds of edits you'll want to make over time. Most live in
one or two files. The dev loop: keep `bundle exec jekyll serve --livereload`
running in one Terminal — the browser at <http://127.0.0.1:4000> auto-reloads
as you edit.

## Switch between light and dark themes

Open `assets/css/main.css`. The first ~40 lines look like:

```css
:root {
  /* === Active palette (light academic) === */
  --bg:           #fafaf7;
  --bg-sidebar:   #ffffff;
  ...

  /* === Dark theme preset (uncomment to switch) ===
  --bg:           #0e0f12;
  --bg-sidebar:   #15171b;
  ...
  */
}
```

To go back to the dark theme: comment out the active light values and uncomment
the dark preset. To experiment with custom colors: just edit the values in the
active block. Save — every page rethemes immediately.

The palette is intentionally a small set of variables; changing one (e.g. `--accent`)
ripples to every link, badge, button border, and active-nav highlight site-wide.

## Tune the hero figure (size and crop)

In `assets/css/main.css`, find the `.hero__figure` rule. It's documented inline:

```css
.hero__figure {
  width: 100%;
  aspect-ratio: 16 / 7;       /* shape: 16/9 (taller), 21/9 (cinematic), etc. */
  object-fit: cover;          /* cover = crop to fill, contain = letterbox */
  object-position: center;    /* which part survives a crop */
}
```

Three knobs:

- **Aspect ratio** — make it taller (`16 / 9`), shorter (`21 / 9`), or square (`1 / 1`).
- **Fit mode** — `cover` zoom-crops to fill the box; `contain` shows the whole figure with empty bands above/below; `none` displays at native pixel size.
- **Crop position** — only matters when `object-fit: cover`. Use `center top`, `25% 75%`, etc., to choose which part of the image is preferred during cropping.

For a fixed pixel height instead of an aspect ratio: delete `aspect-ratio` and replace with `max-height: 380px;`.

## Add a new top-level page

Three steps. Example: adding a `/teaching/` page.

1. Create `teaching.html` at the project root:

   ```yaml
   ---
   layout: default
   title: Teaching
   subtitle: Optional subtitle for the page header.
   show_title: true
   permalink: /teaching/
   ---

   <p>Whatever HTML or markdown you want here.</p>
   ```

2. Add it to the sidebar — open `_includes/sidebar.html` and add a line inside the `<nav>` block (Font Awesome icon names from <https://fontawesome.com/icons>):

   ```html
   <a href="{{ '/teaching/' | relative_url }}"
      class="sidebar__navlink {% if current contains '/teaching' %}is-active{% endif %}">
     <i class="fa-solid fa-chalkboard-user"></i><span>Teaching</span>
   </a>
   ```

3. (Optional) Style any new components in `assets/css/main.css`.

## Mark a paper as a Research highlight

In the paper's `_publications/*.md` file, set `is_highlight: true` in the front
matter. To control what shows on the Research page:

- Title, authors, journal — pulled from the existing front matter.
- Figure — uses `highlight_image:` if set, otherwise falls back to `thumbnail:`. Drop a larger figure into `assets/images/research/` and reference it.
- Abstract — anything you write **below** the closing `---` of the front matter renders as the abstract. Multi-paragraph markdown supported. If empty, the short `excerpt:` is used as a fallback.
- Links — ADS / arXiv / DOI / code buttons use the same fields as the publications list.

## Update your ADS library link

In `_config.yml` set:

```yaml
author:
  ads_library: "https://ui.adsabs.harvard.edu/user/libraries/<your-library-id>"
```

To get the URL: open your library on ADS → "Share Library" → copy the link. The
sidebar and the top of `publications.html` and `contact.html` automatically point
to your library when this field is non-empty, and fall back to an ADS author
search when it's empty.

## Add a dark / light mode toggle

The current setup keeps either light or dark active via `:root`. To let visitors
flip between modes:

1. In `assets/css/main.css`, keep the active light values in `:root`, and add the dark values inside `:root[data-theme="dark"] { ... }` instead of leaving them commented out.

2. Add a button to the sidebar (`_includes/sidebar.html`) — somewhere under the social icons:

   ```html
   <button id="theme-toggle" aria-label="Toggle theme" style="background: none; border: 0; color: var(--text-dim); cursor: pointer; font-size: 1.05rem; margin-top: 8px;">
     <i class="fa-solid fa-moon"></i>
   </button>
   ```

3. Add a small inline script (in `_layouts/default.html` near the closing `</body>`):

   ```html
   <script>
     const root = document.documentElement;
     const saved = localStorage.getItem('theme');
     if (saved) root.setAttribute('data-theme', saved);
     document.getElementById('theme-toggle')?.addEventListener('click', () => {
       const next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
       root.setAttribute('data-theme', next);
       localStorage.setItem('theme', next);
     });
   </script>
   ```

This persists the user's choice across visits via `localStorage`.

## Change accent / link color

Edit `--accent` and `--accent-hov` in the `:root` block of `main.css`. Picks a
single hex code; the whole site retunes (links, active-nav, button outlines,
focus rings).

If you also want to retune the warm secondary accent (used for "first author"
badges and the bolded "Y. Ni" in author lists), edit `--accent-warm`.

## Customize a publication card

Open `_includes/pub-card.html`. The card layout is small and self-contained — you
can rearrange the title/authors/venue/excerpt/links order, add fields (citation
count, conference indicator, code DOI), or remove things. Style classes live in
`main.css` under the `Publication cards` heading.

## Swap fonts

Two places:

1. In `_includes/head.html`, change the `<link rel="stylesheet" href="https://fonts.googleapis.com/...">` to load a different family from Google Fonts.
2. In `assets/css/main.css`, change the `--font-sans` variable in `:root`.

For a serif body (e.g. for a more traditional academic look), set
`--font-sans: 'Source Serif Pro', Georgia, serif;` after loading it from Google Fonts.

## Reorder sidebar nav items

Edit the order of `<a class="sidebar__navlink">` elements in `_includes/sidebar.html`.
That's it — the order in the file is the order on screen.

## Add MathJax for equations on the Research page

If you want to typeset LaTeX equations in highlight abstracts, add this to the
end of `_includes/head.html`:

```html
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
```

Then write `\(x^2\)` for inline math or `\[E = mc^2\]` for display math in any
markdown file. For dollar-sign delimiters (`$x^2$`), see the MathJax config docs.

## Add a search box across publications

Out of scope for a static site without extra tooling, but doable with
[lunr.js](https://lunrjs.com/) or [Pagefind](https://pagefind.app/). A 30-line
addition once you have ~20 papers and want it. Ask me when you're ready.

---

## When you want help

For anything not covered here — bigger redesigns, new section types, integrations
with NASA ADS or arXiv APIs to auto-import papers, multilingual support — just
come back to chat. The architecture above (small markdown files for content,
CSS variables for theming, includes for layout) is designed so most edits are
local and reversible.

---

## Going public

See `PUBLISH.md`.

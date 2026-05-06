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
├── _config.yml          # site title, author info, sitewide settings
├── _layouts/            # HTML page templates
├── _includes/           # reusable HTML snippets (sidebar, head, pub-card)
├── _publications/       # ← one .md per paper
├── _talks/              # ← one .md per talk
├── _news/               # ← one .md per news item
├── assets/
│   ├── css/main.css     # all the styling lives here
│   ├── images/          # profile.jpg, hero.png, pubs/*.png
│   └── pdf/CV_Yang.pdf  # canonical CV PDF
├── index.html           # home page
├── about.html           # about page
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
arxiv_link: "https://arxiv.org/abs/2604.XXXXX"
ads_link:   "https://ui.adsabs.harvard.edu/abs/..."
doi_link:   ""              # optional
code_link:  ""              # optional
thumbnail:  /assets/images/pubs/2026-disks-ii.png   # 4:3 image, ~600px wide
excerpt: "One- to three-sentence plain-English summary that shows up under the title."
---
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

## How to change colors / fonts

All visual styling lives in `assets/css/main.css`. The color palette is at the top
in the `:root { ... }` block — change those CSS variables and every component
re-themes automatically.

---

## How to update the hero figure or profile photo

Replace `assets/images/hero.png` (homepage hero) or `assets/images/profile.jpg`
(sidebar avatar) with your new image. Same filename, no other changes needed.

---

## Going public

See `PUBLISH.md`.

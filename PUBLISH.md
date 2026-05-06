# Going public

Right now, this repo is private at `git@github.com:yni-astro/personalwebsite-source.git`.
Private GitHub repos cannot be served by GitHub Pages, so the site is **invisible**
to anyone but you.

When you're ready to publish your homepage at **`https://yni-astro.github.io`**,
follow the steps below. You can do this any time — none of the work in
`personalwebsite-source` needs to be redone.

---

## Step 1 — Create the public repo

GitHub treats a repo named `<username>.github.io` as your "user site": it auto-publishes
to `https://<username>.github.io`.

1. Go to <https://github.com/new>.
2. Repository name: **`yni-astro.github.io`** (this exact name — it must match your
   GitHub username).
3. Visibility: **Public**.
4. Do **not** initialize with README / .gitignore / license.
5. Click **Create repository**.

---

## Step 2 — Push your site to the public repo

From your local `personalhomepage` folder:

```bash
# Add the public repo as a second remote (alongside your private one)
git remote add public git@github.com:yni-astro/yni-astro.github.io.git

# Push everything to the public repo
git push public main
```

Your private repo (`origin`) keeps working as before — you can continue to push
work-in-progress / drafts there. When something is ready to be public, push it to
`public` as well:

```bash
git push origin main      # private
git push public main      # public
```

(Or set up a single command to push to both — see "Pushing to both at once" below.)

---

## Step 3 — Enable GitHub Pages with Jekyll 4

GitHub Pages' default builder uses an older Jekyll. We're using Jekyll 4, which is
fine, but we need to tell GitHub to build with a workflow rather than the default.

1. In your `yni-astro.github.io` repo on github.com, go to **Settings → Pages**.
2. Under **Build and deployment → Source**, choose **GitHub Actions**.
3. Click **Configure** on the suggested **Jekyll** workflow, or paste the workflow
   below into `.github/workflows/jekyll.yml` and push it. Either works.

Recommended workflow file (`.github/workflows/jekyll.yml`):

```yaml
name: Build & Deploy Jekyll site
on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
          bundler-cache: true
      - uses: actions/configure-pages@v4
      - run: bundle exec jekyll build
        env:
          JEKYLL_ENV: production
      - uses: actions/upload-pages-artifact@v3
        with:
          path: ./_site
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

After pushing this workflow, every push to `main` of the public repo automatically
rebuilds and redeploys your site. Build progress is in the **Actions** tab.

---

## Step 4 — Verify

After the first successful workflow run (≈1–2 minutes), visit
<https://yni-astro.github.io>. Your site is live.

If you see a 404 for ~10 minutes after deployment: that's normal for a brand-new
user site. Wait, then refresh.

---

## Optional: pushing to both at once

If you want a single command to push to both private and public, edit
`.git/config` and add a second `url =` line under `[remote "origin"]`:

```
[remote "origin"]
    url = git@github.com:yni-astro/personalwebsite-source.git
    url = git@github.com:yni-astro/yni-astro.github.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*
```

Now `git push` writes to both. (Pulls still only come from the first.) Skip this
if you'd rather keep the two repos cleanly separated.

---

## Optional: drafts that never go public

If you want to keep certain pages or papers private but draft them in the same repo,
use a top-level `drafts/` directory and add it to `_config.yml` exclude:

```yaml
exclude:
  - drafts/
```

Files inside `drafts/` stay in git but never appear on the built site.

---

## Optional: custom domain (e.g. yangni.org)

If you buy a domain later, in your repo:

1. Add a file named `CNAME` with one line: `yangni.org` (or whatever you bought).
2. In your DNS provider, create a CNAME record `www → yni-astro.github.io` and
   four A records on the apex pointing to GitHub's Pages IPs (185.199.108.153,
   185.199.109.153, 185.199.110.153, 185.199.111.153).
3. In **Settings → Pages**, set the custom domain and tick "Enforce HTTPS"
   once the cert provisions (~1 hour).

---

## Reverting to private

If you ever want to take the public site down: in
`yni-astro.github.io` → **Settings → Pages**, change Source to **None**. The site
stops serving immediately. You can also delete the public repo entirely; the
private one is unaffected.

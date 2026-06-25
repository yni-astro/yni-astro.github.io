# First-time setup — your turn

This walks you through three things you need to do on your Mac:

1. Clean up a partially-initialized git repo (one-time)
2. Push to your private GitHub repo
3. Install Jekyll and preview the site locally

---

## 1. Clean up build artifacts and re-init git

I tried to initialize git and build a quick HTML preview while constructing the
site, but the sandbox's permissions left two artifacts behind: a partial `.git/`
folder and a `preview/` folder with broken HTML. Both are safe to delete (the
`.gitignore` already excludes `preview/` so it won't end up in your repo, but
removing it keeps the folder tidy). From your Mac Terminal:

```bash
cd ~/personalhomepage
rm -rf .git preview
git init -b main
git config user.name "Yang Ni"
git config user.email "yangniastro@gmail.com"
```

---

## 2. Push to your private GitHub repo

Your private repo: `git@github.com:yni-astro/personalwebsite-source.git`

```bash
cd ~/personalhomepage

# Stage everything
git add .

# Sanity-check what will be committed (you should see ~25 files,
# but NOT _site/, vendor/, .DS_Store, or any preview/ folder)
git status

# Initial commit
git commit -m "Initial homepage"

# Connect to your private repo and push
git remote add origin git@github.com:yni-astro/personalwebsite-source.git
git push -u origin main
```

If `git push` fails with an authentication error: you probably need to add your
SSH key to GitHub. Run `ssh -T git@github.com` to test; if that fails, follow
[this GitHub guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).
Or switch the remote to HTTPS:

```bash
git remote set-url origin https://github.com/yni-astro/personalwebsite-source.git
git push -u origin main
```

After this, your site lives in your private repo. It is **invisible** to
everyone but you — private repos cannot serve GitHub Pages.

---

## 3. Install Jekyll & preview locally

You need Ruby (≥ 3.0) and Bundler. macOS ships with an older Ruby; install a
fresh one with Homebrew:

```bash
# One-time: install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install a modern Ruby
brew install ruby

# Add brew's Ruby to your PATH (paste into ~/.zshrc, then `source ~/.zshrc`)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Install bundler + Jekyll deps for this project
gem install bundler
cd ~/personalhomepage
bundle install
```

Then preview the site:

```bash
bundle exec jekyll serve --livereload
```

Open <http://127.0.0.1:4000> in your browser. The site auto-reloads as you edit.

---

## Going forward

- Adding a paper (or restoring the hidden Talks/News): see `README.md`.
- Going public at `https://yni-astro.github.io`: see `PUBLISH.md`.
- `profilephoto.jpg` at the repo root is kept as the full-resolution master of
  your avatar (the site serves an optimized copy at `assets/images/profile.jpg`).
  The earlier root duplicates of the CV PDF and hero image were removed; their
  full-res copies live under `assets/`.

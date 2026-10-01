# CV — built from its own repo

The CV source is **not** stored here. It lives in its own repository,
`git@github.com:yni-astro/CV_Yang.git`, cloned locally at `~/mycv`.
The website only ships the compiled copy at `assets/pdf/CV_Yang.pdf` — never edit that by hand.

One-time setup (if `~/mycv` isn't the clone yet):

    git clone git@github.com:yni-astro/CV_Yang.git ~/mycv

Update workflow:

1. Edit the CV in `~/mycv`; commit and push there as usual.
2. From the homepage repo run `./cv/build.sh` — it pulls the latest CV, compiles it,
   and installs `assets/pdf/CV_Yang.pdf`.
3. Run the commit/push command the script prints (the message records which CV commit was used).

`build.sh` honours `CV_SRC=/path/to/clone` if the clone lives elsewhere.
This folder is excluded from the Jekyll build.

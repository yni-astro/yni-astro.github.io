# CV source — single source of truth

Keep the CV's LaTeX source **here** (`main.tex` + any `.cls`/`.sty`/images it needs).
The website serves the compiled copy at `assets/pdf/CV_Yang.pdf`; never edit that file by hand.

Update workflow:

1. Edit `cv/main.tex`.
2. Run `./cv/build.sh` — compiles and installs `assets/pdf/CV_Yang.pdf`.
3. `git add -A && git commit -m "Update CV" && git push public main && git push origin main`.

This directory is excluded from the Jekyll build (`exclude:` in `_config.yml`), so sources are never published.

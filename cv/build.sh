#!/usr/bin/env bash
# Build the CV from cv/main.tex and install it where the website serves it.
#   ./cv/build.sh          (run from anywhere in the repo)
# Then commit + push as usual; the site's cache-busting delivers the new PDF to visitors.
set -euo pipefail
cd "$(dirname "$0")"
TEX=main.tex
DEST=../assets/pdf/CV_Yang.pdf

if [[ ! -f "$TEX" ]]; then
  echo "cv/$TEX not found. Put your CV source here (main.tex plus any .cls/.sty/images) and re-run." >&2
  exit 1
fi

if command -v latexmk >/dev/null 2>&1; then
  latexmk -pdf -interaction=nonstopmode -halt-on-error "$TEX"
else
  pdflatex -interaction=nonstopmode -halt-on-error "$TEX"
  pdflatex -interaction=nonstopmode -halt-on-error "$TEX"
fi

cp main.pdf "$DEST"
echo "Installed -> assets/pdf/CV_Yang.pdf"
echo "Next:  git add -A && git commit -m 'Update CV' && git push public main && git push origin main"

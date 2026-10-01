#!/usr/bin/env bash
# Sync the CV from its own git repo, compile it, and install the PDF where the website serves it.
#
#   ./cv/build.sh                     # uses ~/mycv (a clone of git@github.com:yni-astro/CV_Yang.git)
#   CV_SRC=/other/clone ./cv/build.sh # or point at a different clone
#
# Afterwards: commit + push the homepage as usual (the script prints the exact command).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
SITE="$(cd "$HERE/.." && pwd)"
CV_SRC="${CV_SRC:-$HOME/mycv}"
DEST="$SITE/assets/pdf/CV_Yang.pdf"

if [[ ! -d "$CV_SRC/.git" ]]; then
  echo "No CV clone at $CV_SRC. Create it first:" >&2
  echo "  git clone git@github.com:yni-astro/CV_Yang.git \"$CV_SRC\"" >&2
  exit 1
fi

echo "Syncing CV source in $CV_SRC ..."
git -C "$CV_SRC" pull --ff-only

cd "$CV_SRC"
if [[ -f main.tex ]]; then
  TEX=main.tex
else
  N=$(ls *.tex 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$N" != "1" ]]; then
    echo "Cannot identify the main .tex in $CV_SRC (found $N candidates). Name it main.tex." >&2
    exit 1
  fi
  TEX=$(ls *.tex)
fi

if command -v latexmk >/dev/null 2>&1; then
  latexmk -pdf -interaction=nonstopmode -halt-on-error "$TEX"
else
  pdflatex -interaction=nonstopmode -halt-on-error "$TEX"
  pdflatex -interaction=nonstopmode -halt-on-error "$TEX"
fi

cp "${TEX%.tex}.pdf" "$DEST"
REV="$(git -C "$CV_SRC" rev-parse --short HEAD)"
echo
echo "Installed -> assets/pdf/CV_Yang.pdf   (built from CV_Yang@$REV)"
echo "Next:"
echo "  cd \"$SITE\" && git add -A && git commit -m \"Update CV (CV_Yang@$REV)\" && git push public main && git push origin main"

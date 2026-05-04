#!/bin/bash
set -e

FILE="index"
OUT_DIR="tmp"

mkdir -p "$OUT_DIR/fontconfig"

export XDG_CACHE_HOME="$(pwd)/$OUT_DIR/fontconfig"

echo "== XeLaTeX fast build (no bib) =="
echo "== XeLaTeX pass 1 =="
xelatex -output-directory "$OUT_DIR" -synctex=1 -interaction=nonstopmode "$FILE.tex"
echo "== XeLaTeX pass 2 =="
xelatex -output-directory "$OUT_DIR" -synctex=1 -interaction=nonstopmode "$FILE.tex"

cp "$OUT_DIR/$FILE.pdf" .

echo "SUCCESS (no bibliography)"
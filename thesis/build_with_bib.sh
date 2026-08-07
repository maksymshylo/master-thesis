#!/bin/bash
set -e

FILE="index"
OUT_DIR="tmp"
CLASS_OPTIONS=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --times|--font=times)
      CLASS_OPTIONS="times"
      shift
      ;;
    --font)
      if [[ "${2:-}" == "times" ]]; then
        CLASS_OPTIONS="times"
        shift 2
      else
        echo "Unsupported font: ${2:-}" >&2
        exit 1
      fi
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

if [[ "${THESIS_FONT:-}" == "times" ]]; then
  CLASS_OPTIONS="times"
elif [[ -n "${THESIS_FONT:-}" ]]; then
  echo "Unsupported THESIS_FONT: $THESIS_FONT" >&2
  exit 1
fi

mkdir -p "$OUT_DIR/fontconfig"

export XDG_CACHE_HOME="$(pwd)/$OUT_DIR/fontconfig"

if [[ -n "$CLASS_OPTIONS" ]]; then
  TEX_INPUT="\\PassOptionsToClass{$CLASS_OPTIONS}{dstu}\\input{$FILE.tex}"
else
  TEX_INPUT="$FILE.tex"
fi

if [[ "$CLASS_OPTIONS" == "times" ]] && command -v fc-match >/dev/null 2>&1; then
  FONT_MATCH="$(fc-match -f '%{family}\n' 'Times New Roman' | head -n 1)"
  if [[ "$FONT_MATCH" != *"Times New Roman"* ]]; then
    echo "Times New Roman was requested but was not found by fontconfig." >&2
    echo "Install the font or expose the host font directory to the build environment." >&2
    exit 1
  fi
fi

run_xelatex() {
  SYNCTEX_OPTION="-synctex=1"
  if [[ "${THESIS_SYNCTEX:-1}" == "0" ]]; then
    SYNCTEX_OPTION="-synctex=0"
  fi
  xelatex -jobname "$FILE" -output-directory "$OUT_DIR" "$SYNCTEX_OPTION" -interaction=nonstopmode "$TEX_INPUT"
}

echo "== XeLaTeX pass 1 =="
run_xelatex

echo "== Biber =="
biber "$OUT_DIR/$FILE"

echo "== XeLaTeX pass 2 =="
run_xelatex

echo "== XeLaTeX pass 3 =="
run_xelatex

cp "$OUT_DIR/$FILE.pdf" .

echo "SUCCESS (with bibliography)"

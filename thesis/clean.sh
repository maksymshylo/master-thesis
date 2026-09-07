#!/bin/bash
set -e

OUT_DIR="tmp"
FILE="index"

FULL=false

if [ "$1" == "--full" ]; then
    FULL=true
fi

echo "== Cleaning LaTeX build artifacts =="

rm -rf "$OUT_DIR"

if [ "$FULL" = true ]; then
    rm -f "$FILE.pdf"
    echo "Also removed PDF"
fi

echo "SUCCESS"
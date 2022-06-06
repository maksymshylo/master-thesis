set -e

mkdir -p tmp
xelatex -output-directory tmp -synctex=1 -interaction=nonstopmode index.tex
cp tmp/index.pdf .
cp tmp/index.synctex.gz .
echo 'SUCCESS'

set -e

mkdir -p tmp
mkdir -p tmp/fontconfig
export XDG_CACHE_HOME="$(pwd)/tmp/fontconfig"
xelatex -output-directory tmp -synctex=1 -interaction=nonstopmode index.tex
cp tmp/index.pdf .
cp tmp/index.synctex.gz .
echo 'SUCCESS'

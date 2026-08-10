# Master Thesis

This directory contains the source files for the master's thesis.

## Structure

- `index.tex` - main document file;
- `config.tex` - document configuration;
- `chapters/` - thesis chapters;
- `bibliography.bib` - bibliography data;
- `build.sh`, `build_with_bib.sh`, `clean.sh` - build and cleanup scripts.

## Build

Build the shared [`latex-dstu` image](https://github.com/maksymshylo/latex-dstu/blob/master/docker/README.md) first.
Then run the following command from this directory:

Fast build without bibliography:

```bash
docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd):/work/thesis" \
  latex-dstu:latest \
  bash -lc 'cd /work/thesis && bash build.sh'
```

Full build with bibliography:

```bash
docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd):/work/thesis" \
  latex-dstu:latest \
  bash -lc 'cd /work/thesis && bash build_with_bib.sh'
```

Output PDF:

- `thesis/index.pdf`

### Build Thesis with Times New Roman font

By default, the thesis uses `XITS`. 
To build with the operating system's
`Times New Roman`, make sure it's installed:

- **macOS**: usually available at
  `/System/Library/Fonts/Supplemental/Times New Roman.ttf`
- **Windows**: usually available at
  `C:\Windows\Fonts\times.ttf`
- **Linux**: install a package that provides Microsoft core fonts, for example
  `ttf-mscorefonts-installer` on Ubuntu/Debian-based systems

Copy the required font files into the project-local `.fonts/` directory first.

```bash
mkdir -p .fonts
cp "/System/Library/Fonts/Supplemental/Times New Roman.ttf" .fonts/
cp "/System/Library/Fonts/Supplemental/Times New Roman Bold.ttf" .fonts/
cp "/System/Library/Fonts/Supplemental/Times New Roman Italic.ttf" .fonts/
cp "/System/Library/Fonts/Supplemental/Times New Roman Bold Italic.ttf" .fonts/
```

Build thesis with `Times New Roman`:
```
docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd):/work/thesis" \
  -v "$(pwd)/.fonts:/usr/local/share/fonts:ro" \
  latex-dstu:latest \
  bash -lc 'cd /work/thesis && bash build_with_bib.sh --times'
```

## Clean Build Artifacts

```bash
cd thesis
bash clean.sh
```

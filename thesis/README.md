# Thesis

This directory contains the source files for the master's thesis. The project
is built directly with the shared `latex-dstu` image.

## Build

Build the shared image once:

```bash
cd /Users/mshylo/dev/latex-dstu
docker build -f docker/Dockerfile -t latex-dstu:latest .

```

Run the full thesis build from this directory:

```bash
cd /Users/mshylo/dev/master-thesis/thesis
docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd):/work/thesis" \
  latex-dstu:latest \
  bash -lc 'cd /work/thesis && bash build_with_bib.sh'
```

The output is `thesis/index.pdf`.

For a fast build without Biber, use `bash build.sh` instead.

## Times New Roman

Place the Times New Roman font files in a local `.fonts/` directory and mount
it into Docker. On macOS, the files are usually in
`/System/Library/Fonts/Supplemental/`:

```bash
docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd):/work/thesis" \
  -v "$(pwd)/.fonts:/usr/local/share/fonts:ro" \
  latex-dstu:latest \
  bash -lc 'cd /work/thesis && bash build_with_bib.sh --times'
```

The `.fonts/` directory is ignored by Git. `THESIS_SYNCTEX=0` disables SyncTeX
when a mounted filesystem causes file-locking issues.

## Structure

- `index.tex` - main document file;
- `config.tex` - document configuration;
- `chapters/` - thesis chapters;
- `bibliography.bib` - bibliography data;
- `build.sh`, `build_with_bib.sh`, `clean.sh` - build and cleanup scripts.

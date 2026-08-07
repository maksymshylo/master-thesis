# Presentation

This directory contains the LaTeX presentation for the master's thesis.

## Build

Build the shared `latex-dstu` image first.
Then run the following command from this directory:

```bash
docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd):/work/presentation" \
  latex-dstu:latest \
  bash -lc 'cd /work/presentation && bash build.sh'
```

The output is `presentation/index.pdf`.

## Structure

- `index.tex` - main presentation file;
- `slides/` - individual slides;
- `images/` - presentation images;
- `build.sh` - build script.

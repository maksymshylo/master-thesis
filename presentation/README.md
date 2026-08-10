# Presentation

This directory contains the LaTeX presentation for the master's thesis.

## Structure

- `index.tex` - main presentation file;
- `slides/` - individual slides;
- `images/` - presentation images;
- `build.sh` - build script.

## Build

Build the shared [`latex-dstu` image](https://github.com/maksymshylo/latex-dstu/blob/master/docker/README.md) first.
Then run the following command from this directory:

```bash
docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(pwd):/work/presentation" \
  latex-dstu:latest \
  bash -lc 'cd /work/presentation && bash build.sh'
```

The output is `presentation/index.pdf`.

# Deployment

This site deploys static HTML to GitHub Pages. CV PDFs are built and deployed separately from the `cv` repository to persistent S3 URLs; they are not part of this build.

## Local commands

Use `npm` as the local task runner from the repository root:

- `npm run build` regenerates jemdoc HTML in a TeX Live Docker container, then copies the site into `_site/`
- `npm run site:assemble` is an alias for `build`
- `npm run serve` serves the already-built `_site/` at `http://localhost:8888`
- `npm run preview` rebuilds the site and starts the local preview server
- `npm run jemdoc` regenerates HTML from jemdoc sources only (no `_site/` assembly). Generated HTML is gitignored; edit jemdoc sources and build locally or via CI.

Notes:

- `npm install` is not required because the repo currently uses no Node dependencies.
- Docker is required for `build` and `jemdoc`. The default image is `ghcr.io/xu-cheng/texlive-debian:latest`. Override with `LATEX_DOCKER_IMAGE` and `LATEX_DOCKER_PLATFORM` (default `linux/amd64`).
- Set `PORT` to override the preview server port, for example `PORT=9000 npm run preview`.
- CV PDFs are built and deployed from the sibling `../cv` repository (`npm run build` and `npm run deploy` there).

## What the workflow does

The workflow at `.github/workflows/pages.yml`:

1. Checks out `aleeper/aleeper.github.io`.
2. Regenerates the website HTML from the jemdoc sources in Docker.
3. Assembles a publishable static site into `_site/`.
4. Uploads and deploys `_site/` to GitHub Pages.

## Triggers

The workflow runs on:

- pushes to `master`
- manual dispatch

## Required GitHub Pages setting

In the `aleeper.github.io` repository settings:

1. Open `Settings` -> `Pages`.
2. Set `Source` to `GitHub Actions`.

## Hosted assets

CV PDFs are published to:

- `https://s3-us-west-1.amazonaws.com/adamleeper.com/cv/LeeperResume.pdf`
- `https://s3-us-west-1.amazonaws.com/adamleeper.com/cv/LeeperCV.pdf`

Mechanics PDFs are published from the sibling `../engineering_mechanics` repository (`npm run deploy` there) to:

- `https://s3-us-west-1.amazonaws.com/adamleeper.com/mechanics/reader.pdf`
- `https://s3-us-west-1.amazonaws.com/adamleeper.com/mechanics/primer.pdf`

Other historical assets remain on S3 under `s3-us-west-1.amazonaws.com/adamleeper.com`, including papers, videos, and music.

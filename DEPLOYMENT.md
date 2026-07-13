# Deployment

This site now supports a fully static GitHub Pages deployment driven by GitHub Actions.

## Local commands

Use `npm` as the local task runner from the repository root:

- `npm run cv:build` builds the CV PDFs in a Dockerized TeX environment
- `npm run site:assemble` regenerates jemdoc HTML and copies the site plus generated PDFs into `_site/`
- `npm run build` runs the full local build: CV container build, jemdoc regeneration, and site assembly
- `npm run serve` serves the already-built `_site/` at `http://localhost:8888`
- `npm run preview` rebuilds the site and starts the local preview server
- `npm run jemdoc` regenerates the checked-in HTML from the jemdoc sources

Notes:

- `npm install` is not required because the repo currently uses no Node dependencies.
- `npm run cv:build` delegates to the sibling repository checkout at `../cv`.
- Set `PORT` to override the preview server port, for example `PORT=9000 npm run preview`.

## What the workflow does

The workflow at `.github/workflows/pages.yml`:

1. Checks out `aleeper/aleeper.github.io`.
2. Regenerates the website HTML from the jemdoc sources.
3. Checks out `aleeper/cv`.
4. Builds `LeeperResume.pdf` and `LeeperCV.pdf` from the LaTeX source using `xu-cheng/latex-action`.
5. Assembles a publishable static site into `_site/`.
6. Uploads and deploys `_site/` to GitHub Pages.

## Triggers

The workflow runs on:

- pushes to `master`
- manual dispatch
- a daily schedule
- `repository_dispatch` events of type `cv-updated`

## Required GitHub Pages setting

In the `aleeper.github.io` repository settings:

1. Open `Settings` -> `Pages`.
2. Set `Source` to `GitHub Actions`.

## Optional CV-triggered rebuilds

If you also want `aleeper/cv` to trigger website rebuilds automatically, add the
`CV_SITE_REBUILD_TOKEN` repository secret to `aleeper/cv`.

That token can be either:

- a classic PAT with `public_repo` scope because `aleeper.github.io` is public
- or a fine-grained PAT with access to `aleeper/aleeper.github.io` and `Contents: Read and write`

Once that secret is configured, the workflow in `aleeper/cv` will notify the website repo after changes land on `master`.

## Audit findings

This migration removes the need for EC2/SSH-based deployment for the main site and CV PDFs.

The following assets are still referenced outside this repository and were not migrated because they are not present locally in either repo:

- `mechanics/reader.pdf`
- `mechanics/primer.pdf`
- multiple historical paper PDFs hosted under `s3-us-west-1.amazonaws.com/adamleeper.com`
- multiple research videos hosted under `s3-us-west-1.amazonaws.com/adamleeper.com`
- multiple music/audio files hosted under `s3-us-west-1.amazonaws.com/adamleeper.com`

Those can be migrated later by checking the files into the website repo or moving them to another static object host and updating links.

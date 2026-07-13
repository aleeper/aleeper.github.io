# Deployment

This site deploys static HTML to GitHub Pages. Built artifacts such as CV PDFs are hosted separately on S3.

## Local commands

Use `npm` as the local task runner from the repository root:

- `npm run site:assemble` regenerates jemdoc HTML and copies the site into `_site/`
- `npm run build` is an alias for `site:assemble`
- `npm run serve` serves the already-built `_site/` at `http://localhost:8888`
- `npm run preview` rebuilds the site and starts the local preview server
- `npm run jemdoc` regenerates the checked-in HTML from the jemdoc sources

Notes:

- `npm install` is not required because the repo currently uses no Node dependencies.
- Set `PORT` to override the preview server port, for example `PORT=9000 npm run preview`.
- CV PDFs are built locally from the sibling `../cv` repository with `npm run build` and deployed to S3 with `npm run deploy`.

## What the workflow does

The workflow at `.github/workflows/pages.yml`:

1. Checks out `aleeper/aleeper.github.io`.
2. Regenerates the website HTML from the jemdoc sources.
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

Other historical assets remain on S3 under `s3-us-west-1.amazonaws.com/adamleeper.com`, including papers, videos, music, and future mechanics PDFs.

Visit **[hanjabolgo.github.io/SuLabTest1022](https://hanjabolgo.github.io/SuLabTest1022)** 🚀

# Su Lab at SMART website

The lab website is built with the [Lab Website Template](https://github.com/greenelab/lab-website-template), Jekyll, and GitHub Actions.

## Publishing

The live site is intended to be published at <https://hanjabolgo.github.io/SuLabTest1022/>. The `main` branch contains the Jekyll source. On each push, GitHub Actions builds the site and deploys the generated files to `gh-pages`; GitHub Pages should publish the root of that branch.

To enable publishing in GitHub, open **Settings → Pages**, choose **Deploy from a branch**, select **gh-pages** and **/(root)**, then save. The first successful Actions run creates the publishing branch.

## Updating content

- Edit the homepage in `index.md`.
- Edit research, team (People), publications, lab photos, contact, and joining information in their page folders.
- Add or update a member profile in `_members/` using the existing Markdown files as examples.
- Commit changes to `main`; the `on-push` workflow rebuilds and republishes the site.

## Local preview

The template includes a Docker preview script at `.docker/run.sh`. It builds the site in a local container and serves it for review.

## Migrated content

See [MIGRATION.md](MIGRATION.md) for source inventory and current/alumni membership details. Gallery captions are in `_data/lab-photos.json`; photos are in `images/lab-photos/`. Current profiles use `status: current` and `order` in `_members/`. Former profiles use `status: alumni`.

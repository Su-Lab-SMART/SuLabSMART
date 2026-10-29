Visit **[su-lab-smart.github.io/SuLabSMART](https://su-lab-smart.github.io/SuLabSMART)** 🚀

# SuLabSMART website

The lab website is built with the [Lab Website Template](https://github.com/greenelab/lab-website-template), Jekyll, and GitHub Actions.

## Publishing

The live site is intended to be published at <https://su-lab-smart.github.io/SuLabSMART/>. The `main` branch contains the Jekyll source. On each push, GitHub Actions builds the site and deploys the generated files to `gh-pages`; GitHub Pages should publish the root of that branch.

To enable publishing in GitHub, open **Settings → Pages**, choose **Deploy from a branch**, select **gh-pages** and **/(root)**, then save. The first successful Actions run creates the publishing branch.

## Updating content

Use the English forms in [Pages CMS](https://app.pagescms.org/), selecting this repository and the `main` branch. See [EDITOR_GUIDE.md](EDITOR_GUIDE.md) for everyday editing and the one-time GitHub App setup. Saving content automatically rebuilds and publishes the website.

## Local preview

The template includes a Docker preview script at `.docker/run.sh`. It builds the site in a local container and serves it for review.

## Migrated content

See [MIGRATION.md](MIGRATION.md) for source inventory and current/alumni membership details. Gallery entries are in `_photos/`; images are in `images/lab-photos/`. Current profiles use `status: current` and `order` in `_members/`. Former profiles use `status: alumni`.

## Content management

Use [Pages CMS](https://app.pagescms.org/) with the `main` branch. English forms are configured in `.pages.yml`. See [EDITOR_GUIDE.md](EDITOR_GUIDE.md) for account setup, content editing, image uploads, publishing, and recovery. Content lives in `_data/pages`, `_data/settings.json`, `_data/contact.json`, and the `_members`, `_research`, `_publications`, `_photos`, `_awards`, and `_custom_pages` collections. Page templates contain layout only.

After a local build, run `bundle exec ruby scripts/check_content.rb` to check CMS field coverage and generated links.

# Su Lab website editing guide

## Open the editor

Go to https://app.pagescms.org/ and sign in. The repository owner must first connect the Pages CMS GitHub App to **hanjabolgo/SuLabTest1022**. Select this repository and the **main** branch. English forms will appear automatically.

For this website, saving to main triggers the existing GitHub Actions build and Pages deployment. Allow a few minutes, then refresh the website. A successful save means the content is stored; it does not mean deployment has finished. If an update is missing, check https://github.com/hanjabolgo/SuLabTest1022/actions before saving again.

## What you can edit

- **Page text:** headings, introductions, and link labels for Home, Research, People, Publications, Lab Photos, Join Us, and Contact.
- **People — current members & alumni:** add people, change biographies, upload portraits, edit emails and links, and switch membership between Current and Alumni. Do not create a second record when a member leaves; switch their membership and fill in Roles and years in the lab. Lower Display order numbers appear first within each group.
- **Research topics:** add or edit topics, descriptions, illustrations, image descriptions, captions, and order.
- **Publications:** one record per paper, with separate title, authors, year, journal, volume/pages, article link, PMID, supporting links, contribution notes, and order. Papers are grouped by year automatically, newest year first; Display order controls placement within a year.
- **Lab Photos:** one record per image. Upload or select the Photo, enter its displayed date and Caption, add an accessible Image description, and set Display order. The Photo title is primarily for finding it in the CMS. Use a lower order number to put a new picture near the top.
- **Awards:** recipient, rich-text award details, and display order.
- **Lab contact details:** shared lab emails, postal address, map URL, and footer links. These also update Contact and Join Us where enabled. Personal member emails are edited in the member record.
- **Website settings & navigation:** lab name, tagline, search description, logo, browser icon, social sharing image, header/footer backgrounds, copyright/illustration credit, footer label, and navigation. Drag navigation entries to reorder; turn Show in menu off to hide a link. Hiding a link does not delete its page.
- **Additional pages:** create a standalone page, then add its address under Website settings & navigation if you want it in the menu. A page titled “Lab Resources” is normally created at `/pages/lab-resources/`. The CMS automatically creates its filename; existing filenames cannot be renamed in the form so published addresses stay stable.

## Text and images

Use the rich-text toolbar or the `/` command menu to format text, add links, or insert images. No HTML, Liquid, YAML, Git commands, or terminal login is needed for ordinary editing. Source-mode switching is hidden. Scientific Unicode characters such as CO₂ and Fruᴹ can be copied and pasted; they remain editable as text.

The Image library supports browsing and uploads. Use the image picker inside the specific record to upload **and attach** a picture. Uploading to the library alone does not add a gallery entry. Pictures are stored in this repository; the site resolves their paths automatically under `/SuLabTest1022/`. Use useful alternative descriptions for accessibility.

For external links paste a full `https://...` address. For a page on this site, use a path such as `/research/`, `/team/`, or `/pages/lab-resources/`, without the `/SuLabTest1022` prefix. Use the link picker / toolbar for links inside rich text.

## Publishing and recovery

Review the changed text and images, save, and wait for the build. Each save is recorded in GitHub history. Ask the repository owner to restore an earlier commit if a mistake needs to be undone. Removing a photo record removes it from the gallery; keep the underlying image if another entry still uses it.

The forms control content. Layout code, build settings, and the CMS configuration are maintained separately. Adding ordinary records or Additional pages needs no coding; changing page layouts still requires a developer.

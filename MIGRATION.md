# Original website content migration

Source: https://sites.google.com/view/su-lab-ucsd/home (live pages retrieved October 28, 2026).

- Home: complete original introduction.
- Research: four complete research sections and four illustrations.
- People: 4 current members with portraits and complete biographies, awards, and full alumni list. Existing former-member profile URLs remain available.
- Publications: 34 entries across 19 years (2006–2026), including original author lists and supporting links.
- Lab Photos: 59 original photographs and their captions, in original page order, stored locally in the repository.
- Join Us: original recruitment invitation and contact emails.
- Contact: existing URL retained; removed from main navigation. Email, address, and illustration credit appear in the footer.

The live People source differs from search caches: Kalyani Cauwenberghs, Jessica Xiong, Muskaan Garg, and Margarita Bellah are now listed as alumni. The source spells Jessica as “Jexxica” in its alumni list; this migration corrects that obvious typo to match her existing profile.

Image provenance is recorded in `migration-assets.json`. Google Sites interface controls and Google branding are omitted.

## CMS content structure

The Pages CMS refactor preserves the migrated content and URLs. Research, publications, photos, awards, and members are independent collection records. All 32 alumni now have editable member records; biographies were not invented where the source supplied only a name and service history. Editable page copy is in `_data/pages/`, with branding/navigation in `_data/settings.json` and shared contact details in `_data/contact.json`. Scientific superscripts/subscripts are represented by Unicode characters so rich-text editing does not strip them.

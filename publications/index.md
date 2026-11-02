---
---
{% assign info = site.data.pages.publications | localize_page: 'publications' %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign papers = site.publications | sort: 'order' | group_by: 'year' | sort: 'name' | reverse %}
{% for year in papers %}
<h2>{{ year.name | escape }}</h2>
{% for paper in year.items %}{% assign localized_paper = paper | bilingual_record %}
<article class="publication-entry">
  <p>{{ localized_paper.authors | escape }} ({{ localized_paper.year }}). {{ localized_paper.title | escape }}. <em>{{ localized_paper.journal | escape }}</em>{% if localized_paper.details and localized_paper.details != '' %} {{ localized_paper.details | escape }}{% endif %}.
  {% if localized_paper.article_url and localized_paper.article_url != '' %}<a href="{{ localized_paper.article_url | escape }}">{% if page.lang == 'zh' %}论文原文{% else %}{{ localized_paper.article_label | default: 'Article' | escape }}{% endif %}</a>{% endif %}
  {% if localized_paper.pmid and localized_paper.pmid != '' %}<span>PMID: {{ localized_paper.pmid | escape }}.</span>{% endif %}
  {% for link in localized_paper.links %} <a href="{{ link.url | escape }}">{{ link.label | escape }}</a>.{% endfor %}</p>
  {% include translation-notice.html item=localized_paper %}{{ localized_paper.content | render_content }}
</article>
{% endfor %}
{% endfor %}

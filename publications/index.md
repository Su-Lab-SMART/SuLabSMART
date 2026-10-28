---
---
{% assign info = site.data.pages.publications %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign papers = site.publications | sort: 'order' | group_by: 'year' | sort: 'name' | reverse %}
{% for year in papers %}
<h2>{{ year.name | escape }}</h2>
{% for paper in year.items %}
<article class="publication-entry">
  <p>{{ paper.authors | escape }} ({{ paper.year }}). {{ paper.title | escape }}. <em>{{ paper.journal | escape }}</em>{% if paper.details and paper.details != '' %} {{ paper.details | escape }}{% endif %}.
  {% if paper.article_url and paper.article_url != '' %}<a href="{{ paper.article_url | escape }}">{{ paper.article_label | default: 'Article' | escape }}</a>{% endif %}
  {% if paper.pmid and paper.pmid != '' %}<span>PMID: {{ paper.pmid | escape }}.</span>{% endif %}
  {% for link in paper.links %} <a href="{{ link.url | escape }}">{{ link.label | escape }}</a>.{% endfor %}</p>
  {{ paper.content | render_content }}
</article>
{% endfor %}
{% endfor %}

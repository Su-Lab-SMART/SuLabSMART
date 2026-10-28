---
---
{% assign info = site.data.pages.home %}
<h1>{{ info.heading | escape }}</h1>
<h2>{{ info.section_heading | escape }}</h2>
{{ info.introduction | render_content }}
<h2>{{ info.links_heading | escape }}</h2>
<ul>{% for link in info.links %}<li><a href="{{ link.url | relative_url | escape }}">{{ link.label | escape }}</a></li>{% endfor %}</ul>

---
---
{% assign info = site.data.pages.home | localize_page: 'home' %}
<h1>{{ info.heading | escape }}</h1>
<h2>{{ info.section_heading | escape }}</h2>
{{ info.introduction | render_content }}
<h2>{{ info.links_heading | escape }}</h2>
<ul>{% for link in info.links %}<li><a href="{{ link.url | localized_url | relative_url | escape }}">{{ link.label | escape }}</a></li>{% endfor %}</ul>

<p class="home-language-link"><a href="{{ page.alternate_url | relative_url }}" lang="{{ page.alternate_lang }}">{% if page.lang == "zh" %}View the English website{% else %}浏览简体中文版{% endif %}</a></p>

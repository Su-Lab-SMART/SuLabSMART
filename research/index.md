---
---
{% assign info = site.data.pages.research %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign topics = site.research | sort: 'order' %}
{% for topic in topics %}
<h2>{{ topic.title | escape }}</h2>
{{ topic.content | render_content }}
{% if topic.image and topic.image != '' %}
<figure class="figure">
  <a href="{{ topic.image | relative_url | escape }}"><img src="{{ topic.image | relative_url | escape }}" alt="{{ topic.image_alt | default: topic.title | escape }}" loading="lazy"></a>
  {% if topic.image_caption != '' %}<figcaption class="figure-caption">{{ topic.image_caption | escape }}</figcaption>{% endif %}
</figure>
{% endif %}
{% unless forloop.last %}{% include section.html %}{% endunless %}
{% endfor %}

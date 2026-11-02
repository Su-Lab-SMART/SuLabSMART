---
---
{% assign info = site.data.pages.research | localize_page: 'research' %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign topics = site.research | sort: 'order' %}
{% for topic in topics %}{% assign localized_topic = topic | bilingual_record %}
<h2>{{ localized_topic.title | escape }}</h2>
{% include translation-notice.html item=localized_topic %}
{{ localized_topic.content | render_content }}
{% if localized_topic.image and localized_topic.image != '' %}
<figure class="figure">
  <a href="{{ localized_topic.image | localized_url | relative_url | escape }}"><img src="{{ localized_topic.image | localized_url | relative_url | escape }}" alt="{{ localized_topic.image_alt | default: localized_topic.title | escape }}" loading="lazy"></a>
  {% if localized_topic.image_caption != '' %}<figcaption class="figure-caption">{{ localized_topic.image_caption | escape }}</figcaption>{% endif %}
</figure>
{% endif %}
{% unless forloop.last %}{% include section.html %}{% endunless %}
{% endfor %}

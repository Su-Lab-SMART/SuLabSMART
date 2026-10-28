---
---
{% assign info = site.data.pages.photos %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign photos = site.photos | sort: 'order' %}
<div class="lab-gallery">
{% for photo in photos %}
  <figure class="lab-photo">
    <a href="{{ photo.image | relative_url | escape }}" aria-label="{{ photo.alt | default: photo.title | escape }} — {{ info.open_photo_label | escape }}">
      <img src="{{ photo.image | relative_url | escape }}" alt="{{ photo.alt | default: photo.title | escape }}" loading="lazy" decoding="async">
    </a>
    <figcaption>{% if photo.date_label != '' %}<p>{{ photo.date_label | escape }}</p>{% endif %}{{ photo.content | render_content }}</figcaption>
  </figure>
{% endfor %}
</div>

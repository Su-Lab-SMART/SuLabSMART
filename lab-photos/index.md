---
---
{% assign info = site.data.pages.photos | localize_page: 'photos' %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign photos = site.photos | sort: 'order' %}
<div class="lab-gallery">
{% for photo in photos %}{% assign localized_photo = photo | bilingual_record %}
  <figure class="lab-photo">
    <a href="{{ localized_photo.image | localized_url | relative_url | escape }}" aria-label="{{ localized_photo.alt | default: localized_photo.title | escape }} — {{ info.open_photo_label | escape }}">
      <img src="{{ localized_photo.image | localized_url | relative_url | escape }}" alt="{{ localized_photo.alt | default: localized_photo.title | escape }}" loading="lazy" decoding="async">
    </a>
    <figcaption>{% if localized_photo.date_label != '' %}<p>{{ localized_photo.date_label | escape }}</p>{% endif %}{% include translation-notice.html item=localized_photo %}{{ localized_photo.content | render_content }}</figcaption>
  </figure>
{% endfor %}
</div>

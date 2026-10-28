---
title: Lab Photos
nav:
  order: 5
---

# Lab Photos

Lab gatherings, milestones, celebrations, and everyday life in the Su Lab.

<div class="lab-gallery">
{% for photo in site.data.lab-photos %}
  <figure class="lab-photo">
    <a href="{{ photo.image | relative_url }}" aria-label="{{ photo.alt | escape }} — open full photo">
      <img src="{{ photo.image | relative_url }}" alt="{{ photo.alt | escape }}" loading="lazy" decoding="async">
    </a>
    <figcaption>{% for line in photo.caption %}<p>{{ line | escape }}</p>{% endfor %}</figcaption>
  </figure>
{% endfor %}
</div>

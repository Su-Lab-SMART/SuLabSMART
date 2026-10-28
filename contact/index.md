---
---
{% assign info = site.data.pages.contact %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
<h2>{{ info.email_heading | escape }}</h2>
<ul>{% for email in site.data.contact.emails %}<li><a href="mailto:{{ email.address | escape }}">{{ email.label | default: email.address | escape }}</a></li>{% endfor %}</ul>
{% include section.html %}
<h2>{{ info.location_heading | escape }}</h2>
<p>{% for line in site.data.contact.address_lines %}{{ line | escape }}{% unless forloop.last %}<br>{% endunless %}{% endfor %}</p>
{% if site.data.contact.maps_url != '' %}<p><a href="{{ site.data.contact.maps_url | escape }}">{{ info.maps_label | escape }}</a></p>{% endif %}
